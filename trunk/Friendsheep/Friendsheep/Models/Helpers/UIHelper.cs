using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Linq;
using System.Text;
using Mumble.Friendsheep.Models.Exceptions;
using Mumble.Friendsheep.Models.Managers;
using System.Threading;
using System.IO;
using System.Globalization;
using System.Configuration;

namespace Mumble.Friendsheep.Models.Helpers
{
    public static class UIHelper
    {
        public const string CultureSessionKey = "Culture";
        public static readonly Dictionary<int, string> Months;

        private static Dictionary<string, Dictionary<string, string>> _translations = new Dictionary<string,Dictionary<string,string>>();

        static UIHelper()
        {
            Months = new Dictionary<int,string>();
            Months.Add(1, "January");
            Months.Add(2, "February");
            Months.Add(3, "March");
            Months.Add(4, "April");
            Months.Add(5, "May");
            Months.Add(6, "June");
            Months.Add(7, "July");
            Months.Add(8, "August");
            Months.Add(9, "September");
            Months.Add(10, "October");
            Months.Add(11, "November");
            Months.Add(12, "December");
        }

        public static string DefaultCulture
        {
            get
            {
                return ConfigurationManager.AppSettings["DefaultCulture"];
            }
        }

        /// <summary>
        /// Gets current UI culture
        /// </summary>
        public static string CurrentCulture
        {
            get
            {
                object sessionCulture = HttpContext.Current.Session[CultureSessionKey];
                if (sessionCulture != null)
                {
                    return sessionCulture.ToString();
                }
                else
                {
                    HttpContext.Current.Session[CultureSessionKey] = DefaultCulture;
                    return DefaultCulture;
                }
            }
        }

        /// <summary>
        /// Change current site culture. If null culture specified, Default culture is used
        /// </summary>
        /// <param name="culture"></param>
        public static void ChangeCulture(string culture)
        {
            if (culture == null)
                culture = DefaultCulture;

            HttpContext.Current.Session[CultureSessionKey] = culture;
        }

        /// <summary>
        /// Create a friendly date like: 1 hour ago, 1 minute ago, yersterday
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public static string CreateFriendlyDate(DateTime date)
        {
            return date.ToString();
        }

        /// <summary>
        /// Translate specified key
        /// </summary>
        /// <param name="key">key to translate</param>
        /// <returns>translated key</returns>
        public static string Translate(string key)
        {
            Dictionary<string, string> dictionary = GetCurrentDictionary();
            if (dictionary.ContainsKey(key))
                return dictionary[key];

            return key;
        }

        /// <summary>
        /// Gets or load current culture dictionary
        /// </summary>
        /// <returns></returns>
        private static Dictionary<string, string> GetCurrentDictionary()
        {
            string culture = CurrentCulture;
            if (!_translations.ContainsKey(culture))
            {
                Dictionary<string, string> translation = new Dictionary<string, string>();
                string path = HttpContext.Current.Server.MapPath(String.Format("/Lang/{0}.txt", culture));
                StreamReader file = File.OpenText(path);

                try
                {
                    string line;
                    while ((line = file.ReadLine()) != null)
                    {
                        line = line.Trim();
                        if (line.StartsWith("//") || String.IsNullOrEmpty(line)) { continue; }
                        string[] split = line.Split(new string[] { "=" }, 2, StringSplitOptions.None);
                        string key = split[0].Trim();
                        string value = split[1].Trim();

                        translation.Add(key, value);
                    }
                }
                finally
                {
                    file.Close();
                }

                _translations.Add(culture, translation);
            }

            return _translations[culture];
        }

        /// <summary>
        /// Translate function shortcut
        /// </summary>
        public static string T(string key)
        {
            return Translate(key);
        }

        /// <summary>
        /// Creates new enum html dropdown list
        /// </summary>
        /// <param name="enumType">type of enum</param>
        /// <param name="id">html tag id and name</param>
        /// <param name="selectedValue">initial dropdown value</param>
        /// <param name="translated">translate or not enum text</param>
        /// <returns>dropdown markup</returns>
        public static string EnumDropDown(Type enumType, string id, object selectedValue, bool translated, string nullValue)
        {
            XElement select = new XElement("select", 
                new XAttribute("id", id),
                new XAttribute("name", id));

            string[] names = Enum.GetNames(enumType);
            Array values = Enum.GetValues(enumType);

            if (nullValue != null)
            {
                select.Add(new XElement("option", new XAttribute("value", ""), nullValue));
            }

            for (int i = 0; i < names.Length; i++)
			{
                string name = names[i];
                string text = translated ? Translate(name) : name;
                XElement option = new XElement("option", new XAttribute("value", values.GetValue(i).ToString()), text);
                if (values.GetValue(i).Equals(selectedValue)) { option.Add(new XAttribute("selected", "selected")); }
                select.Add(option);
			}

            return select.ToString();
        }

        /// <summary>
        /// Creates 3 separated dropdown lists for datetime selection. Names are prefix + "_day", prefix + "_month", prefix + "_year"
        /// </summary>
        /// <param name="prefix">prefix before id and name of each dropdowns</param>
        /// <param name="selectedValue">initial selected value</param>
        /// <returns>3 dropdown markup</returns>
        public static string DayMonthYearSelector(string prefix, DateTime? selectedValue)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append(CreateRangeDropDown(String.Format("{0}_day", prefix), 1, 31, selectedValue.HasValue ? (int?)selectedValue.Value.Day : null, false, Translate("Day") + "...")).Append("&nbsp;");
            builder.Append(CreateDictionaryDropDown<int, string>(String.Format("{0}_month", prefix), Months, -1, false, Translate("Month") + "...", true)).Append("&nbsp;");
            builder.Append(CreateRangeDropDown(String.Format("{0}_year", prefix), 1900, 2010, selectedValue.HasValue ? (int?)selectedValue.Value.Year : null, true, Translate("Year") + "..."));

            return builder.ToString();
        }

        /// <summary>
        /// Creates a dropdown from an generic-typed dictionary. In options value is key of dictionary
        /// </summary>
        /// <param name="id">html tag id and name</param>
        /// <param name="start">start value of range</param>
        /// <param name="stop">stop value of range</param>
        /// <param name="selectedValue">selected value of range</param>
        /// <param name="inverse">if true, range is inverse</param>
        /// <returns>dropdown markup</returns>
        public static string CreateDictionaryDropDown<T1, T2>(string id, Dictionary<T1, T2> items, T1 selectedValue, bool inverse, string nullValue, bool translate)
        {
            XElement select = new XElement("select",
                new XAttribute("name", id),
                new XAttribute("id", id));

            if (nullValue != null)
            {
                select.Add(new XElement("option", new XAttribute("value", ""), nullValue));
            }

            foreach(var item in items)
            {
                string text = translate ? Translate(item.Value.ToString()) : item.Value.ToString();

                XElement option = new XElement("option",
                    new XAttribute("value", item.Key.ToString()),
                    text);

                if (selectedValue != null && item.Key.Equals(selectedValue)) { option.Add(new XAttribute("selected", "selected")); }
                select.Add(option);
            }

            return select.ToString();
        }

        /// <summary>
        /// Creates numeric range dropdown list
        /// </summary>
        /// <param name="id">html tag id and name</param>
        /// <param name="start">start value of range</param>
        /// <param name="stop">stop value of range</param>
        /// <param name="selectedValue">selected value of range</param>
        /// <param name="inverse">if true, range is inverse</param>
        /// <returns>dropdown markup</returns>
        public static string CreateRangeDropDown(string id, int start, int stop, int? selectedValue, bool inverse, string nullValue)
        {
            XElement select = new XElement("select",
                new XAttribute("name", id),
                new XAttribute("id", id));

            int index = start;
            int final = stop;
            if(inverse) { index = stop; final = start; }

            if (nullValue != null)
            {
                select.Add(new XElement("option", new XAttribute("value", ""), nullValue));
            }

            while(true)
            {
                XElement option = new XElement("option",
                    new XAttribute("value", index.ToString()),
                    index.ToString());

                if (selectedValue.HasValue && index == selectedValue) { option.Add(new XAttribute("selected", "selected")); }
                select.Add(option);

                if(inverse) { index--; }
                else { index++; }

                if (inverse) { if (final > index) break; }
                else { if (index > final) break; }
            }

            return select.ToString();
        }
    }
}