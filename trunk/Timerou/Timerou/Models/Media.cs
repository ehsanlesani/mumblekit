using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models
{
    public partial class Media
    {
        /// <summary>
        /// Delete all content associated with media. ES: All pictures files for picture
        /// </summary>
        public abstract void DeleteContents();
    }
}
