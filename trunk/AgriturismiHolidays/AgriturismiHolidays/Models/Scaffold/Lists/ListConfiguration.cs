using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Lists
{
    /// <summary>
    /// Represent list visualization configuration
    /// </summary>
    public class ListConfiguration
    {
        public List<ColumnConfiguration> Columns { get; set; }

        public ListConfiguration()
        {
            Columns = new List<ColumnConfiguration>();
        }

        /// <summary>
        /// Add a visible column to list
        /// </summary>
        /// <param name="columnName"></param>
        public void AddColumn(string name, string header, FormatFunc formatter)
        {
            Columns.Add(new ColumnConfiguration(name, header, formatter));
        }

        /// <summary>
        /// Add a visible column to list using standard formatter
        /// </summary>
        /// <param name="columnName"></param>
        public void AddColumn(string name, string header)
        {
            AddColumn(name, header, Formatters.StandardFormatter);
        }
    }
}