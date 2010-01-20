using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Friendsheep.Models
{
    public partial class Mood
    {
        public MoodValue Value
        {
            get
            {
                return (MoodValue)tValue;
            }
            set
            {
                tValue = (int)value;
            }
        }
    }
}