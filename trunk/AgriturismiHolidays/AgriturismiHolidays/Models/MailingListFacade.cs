using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Mumble.Web.StarterKit.Models.ExtPartial;
using System.Collections.Generic;

namespace Premier.Models
{
    partial class MailingListFacade
	{
        StarterKitContainer _container = new StarterKitContainer();

        /// <summary>
        /// Permette di reperire la MailingList filtrando l'elenco per name, surname, phone ed email.
        /// Nessuno di questi parametri è obbligatorio.
        /// </summary>
        /// <returns>Restituisce l'elenco della mailing list filtrato.</returns>
        public List<MailingList> GetMailingList(string name, string surname, string phone, string email)
        {
            
            var mailingList = from m in _container.MailingList
                              where ((m.Name.Contains(name)) || (string.IsNullOrEmpty(name)))
                              && ((m.Surname.Contains(surname)) || (string.IsNullOrEmpty(surname)))
                              && ((m.Phone.Contains(phone)) || (string.IsNullOrEmpty(phone)))
                              && ((m.Email.Contains(email)) || (string.IsNullOrEmpty(email)))
                              select m;

            return mailingList.ToList();
        }

        public bool GetMailingListExists(string name, string surname, string phone, string email)
        {
            return GetMailingList(name, surname, phone, email).Count > 0;
        }

        public List<MailingList> GetMailingList()
        {
            return GetMailingList(null, null, null, null);
        }

        public MailingList GetMailingList(int userId)
        {
            return _container.MailingList.Include("MailingListGroups").FirstOrDefault(m => m.UserID == userId);
        }

        public IEnumerable<MailingList> GetMailingListByGroup(int groupId)
        {
            return _container.MailingList.Where(m => m.MailingListGroups.GroupID == groupId);
        }

        public MailingList GetMailingList(int userId, StarterKitContainer context)
        {
            return context.MailingList.FirstOrDefault(m => m.UserID == userId);
        }

        public IEnumerable<MailingListGroup> GetMailingListGroups()
        {
            return _container.MailingListGroups;
        }

        public MailingListGroup GetMailingListGroup(int groupId)
        {
            return _container.MailingListGroups.FirstOrDefault(m => m.GroupID == groupId);
        }

        public MailingListGroup GetMailingListGroup(string groupname)
        {
            return _container.MailingListGroups.FirstOrDefault(m => m.Name == groupname);
        }


        public MailingListGroup GetMailingListGroup(int groupId, StarterKitContainer context)
        {
            return context.MailingListGroups.FirstOrDefault(m => m.GroupID == groupId);
        }
    }
}
