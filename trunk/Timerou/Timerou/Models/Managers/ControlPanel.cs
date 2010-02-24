﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Timerou.Models.Helpers;
using System.IO;

namespace Mumble.Timerou.Models.Managers
{
    /// <summary>
    /// Manage user control panel and media
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

            picture.SaveFiles(pictureStream);

            _container.AddToMedias(picture);
            _container.SaveChanges();

            return picture;
        }

        /// <summary>
        /// Save or update picture using specified information. All user temp pictures are removed
        /// </summary>
        /// <param name="pictureId"></param>
        /// <param name="tempPictureId"></param>
        /// <param name="title"></param>
        /// <param name="body"></param>
        /// <param name="country"></param>
        /// <param name="countryCode"></param>
        /// <param name="region"></param>
        /// <param name="postalCode"></param>
        /// <param name="city"></param>
        /// <param name="province"></param>
        /// <param name="address"></param>
        /// <param name="lat"></param>
        /// <param name="lng"></param>
        /// <returns></returns>
        public Picture SavePicture(Guid? pictureId, Guid? tempPictureId, string title, string body, string country, string countryCode, string region, string postalCode, string city, string province, string address, double lat, double lng, int year)
        {
            Picture picture = null;

            //check if is a new picture or an existent one
            if (pictureId.HasValue)
            {
                picture = _container.Medias.OfType<Picture>().Where(p => p.Id == pictureId).FirstOrDefault();
                if (picture == null)
                {
                    throw new ArgumentException("pictureId");
                }

                //if is an existent picture and a temp picture id is passed, the picture is changed and a pictures file rename is required
                if (tempPictureId.HasValue)
                {
                    Picture tempPicture = _container.Medias.OfType<Picture>().Where(p => p.Id == tempPictureId).FirstOrDefault();
                    tempPicture.AssignFilesToOtherPicture(picture);
                }
            }
            else
            {
                //if is a new picture, an initial temp picture is required
                if(tempPictureId.HasValue)
                {
                    picture = _container.Medias.OfType<Picture>().Where(p => p.Id == tempPictureId).FirstOrDefault();
                    picture.Created = DateTime.Now;
                }

                if (picture == null)
                {
                    throw new ArgumentException("tempPictureId");
                }
            }

            picture.Title = title;
            picture.Body = body;
            picture.Lat = lat;
            picture.Lng = lng;
            picture.Country = country;
            picture.CountryCode = countryCode;
            picture.Region = region;
            picture.Province = province;
            picture.City = city;
            picture.PostalCode = postalCode;
            picture.Address = address;
            picture.IsTemp = false;
            picture.User = _user;
            picture.Year = year;

            //delete all user temp pictures;
            var tempPictures = from m in _container.Medias
                               where m is Picture
                               let p = (m as Picture)
                               where p.User.Id == _user.Id
                               && p.Id != picture.Id //if this is a temp picture
                               && p.IsTemp == true
                               select p;

            foreach (var tp in tempPictures)
            {
                _container.DeleteObject(tp);
            }

            _container.SaveChanges();

            //after picture deletion, file deletion is necessary
            foreach (var tp in tempPictures)
            {
                tp.DeleteFiles();
            }

            return picture;
        }
    }
}