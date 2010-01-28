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
        /// Save temp picture for user
        /// </summary>
        /// <param name="pictureStream"></param>
        /// <returns></returns>
        public Picture CreateTempPicture(Stream pictureStream)
        {
            //create picture object and save optimized, avatar and original
            Picture picture = new Picture()
            {
                Id = Guid.NewGuid(),
                User = _user,
                IsTemp = true,
                Created = DateTime.Now                
            };

            picture.Save(pictureStream);

            _container.AddToMapObjects(picture);
            _container.SaveChanges();

            return picture;
        }
    }
}