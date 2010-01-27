using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Timerou.Models.Helpers;
using System.IO;

namespace Mumble.Timerou.Models.Managers
{
    /// <summary>
    /// Manage user control panel
    /// </summary>
    public class ControlPanel
    {
        private User _user;
        private TimerouContainer _container;

        public ControlPanel(User user, TimerouContainer container)
        {
            _user = user;
            _container = container;
        }

        /// <summary>
        /// Save a picture into album creating avatar and optimized into filesystem
        /// </summary>
        /// <param name="album"></param>
        /// <param name="stream"></param>
        /// <param name="p"></param>
        /// <returns></returns>
        public Picture SavePicture(Stream pictureStraem, string fileName)
        {
            throw new NotImplementedException();
            //create picture object and save optimized, avatar and original
            //Picture picture = Picture.CreatePicture(Guid.NewGuid(), 0, DateTime.Now, Path.GetFileNameWithoutExtension(fileName), false, 0, 0);
            //album.Pictures.Add(picture);
            
            //picture.Save(pictureStraem);

            //_container.SaveChanges();

            //return picture;
        }
    }
}