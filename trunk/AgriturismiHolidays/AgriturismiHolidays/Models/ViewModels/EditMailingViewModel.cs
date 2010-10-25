using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Web.StarterKit.Models.ExtPartial;

namespace Mumble.Web.StarterKit.Models.ViewModels
{
    public class EditMailingViewModel : CustomViewModel
    {
        public MailingList MailingList { get; set; }
        public IEnumerable<MailingListGroup> MailingListGroups { get; set; }
    }
}
