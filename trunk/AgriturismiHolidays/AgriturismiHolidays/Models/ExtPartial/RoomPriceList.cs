using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.ExtPartial
{
    public partial class RoomPriceList
    {
        public override string ToString()
        {
            return this.Price.GetValueOrDefault().ToString();
        }
    }
}