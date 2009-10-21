using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Mumble.Web.StarterKit.Models;

namespace MumbleKit.Views.Shared
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        public IEnumerable<Section> Sections { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            var container = new StarterKitContainer();
            Sections = from s in container.Sections.Include("Pages")
                       orderby s.Description
                       select s;
        }
    }
}