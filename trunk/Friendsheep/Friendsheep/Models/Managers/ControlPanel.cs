using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Friendsheep.Models.Helpers;
using System.IO;

namespace Mumble.Friendsheep.Models.Managers
{
    /// <summary>
    /// Manage user control panel
    /// </summary>
    public class ControlPanel
    {
        private User _user;
        private FriendsheepContainer _container;

        public ControlPanel(User user, FriendsheepContainer container)
        {
            _user = user;
            _container = container;
        }

        /// <summary>
        /// Creates and persist new album for specified user
        /// </summary>
        /// <returns></returns>
        public Album CreateAlbum()
        {
            Album album = Album.CreateAlbum(Guid.NewGuid(), DateTime.Now.ToString(UIHelper.DateFormat));
            _user.Albums.Add(album);

            _container.SaveChanges();

            return album;
        }

        /// <summary>
        /// Save a picture into album creating avatar and optimized into filesystem
        /// </summary>
        /// <param name="album"></param>
        /// <param name="stream"></param>
        /// <param name="p"></param>
        /// <returns></returns>
        public Picture SavePicture(Album album, Stream pictureStraem, string fileName)
        {
            //create picture object and save optimized, avatar and original
            Picture picture = Picture.CreatePicture(Guid.NewGuid(), 0, DateTime.Now, Path.GetFileNameWithoutExtension(fileName), false, 0, 0);
            album.Pictures.Add(picture);
            picture.Album = album;
            picture.Save(pictureStraem);

            _container.SaveChanges();

            return picture;
        }
    }
}