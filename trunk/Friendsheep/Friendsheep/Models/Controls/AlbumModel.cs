using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Friendsheep.Models.Controls
{
    public class AlbumModel
    {
        public AlbumModel(User user)
        {
            User = user;
        }

        public User User { get; set; }

        /// <summary>
        /// Gets user albums ordered by title
        /// </summary>
        public IEnumerable<Album> Albums
        {
            get
            {
                if (!User.Albums.IsLoaded) { User.Albums.Load(); }
                return User.Albums.OrderBy(a => a.Title);
            }
        }
    }
}