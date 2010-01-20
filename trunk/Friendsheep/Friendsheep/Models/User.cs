using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Friendsheep.Models.Helpers;

namespace Mumble.Friendsheep.Models
{
    public partial class User
    {

        /// <summary>
        /// Gets or sets user gender
        /// </summary>
        public Gender Gender
        {
            get
            {
                return (Gender)Enum.Parse(typeof(Gender), tGender);
            }
            set
            {
                tGender = value.ToString();
            }
        }

        /// <summary>
        /// Gets or sets look/character wheight. (0 to 100) If character is 40, look is 60
        /// </summary>
        public int CharacterWeight
        {
            get
            {
                return (100 - LookWeight);
            }
            set
            {
                LookWeight = 100 - value;
            }
        }

        public override string ToString()
        {
            return String.Format("{0} {1} [{2}]", FirstName, LastName, Email);
        }
    }
}