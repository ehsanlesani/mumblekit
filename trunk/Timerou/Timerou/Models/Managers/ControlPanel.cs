using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Timerou.Models.Helpers;
using System.IO;
using Mumble.Timerou.Models.Exceptions;

namespace Mumble.Timerou.Models.Managers
{
    /// <summary>
    /// Manage user control panel and media. Logon is required
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
        /// Save or update video using specified information
        /// </summary>
        public Video SaveVideo(Guid? videoId, string youtubeVideoId, string title, string body, string country, string countryCode, string region, string postalCode, string city, string province, string address, double lat, double lng, int year)
        {
            Video video = null;

            //check if is a new video or an existent one
            if (videoId.HasValue)
            {
                video = _container.Medias.OfType<Video>().Where(p => p.Id == videoId).FirstOrDefault();
                if (video == null)
                {
                    throw new ArgumentException("videoId");
                }
            }
            else
            {
                video = new Video()
                {
                    Id = Guid.NewGuid(),
                    Created = DateTime.Now,
                    IsTemp = false
                };
            }

            video.YoutubeId = youtubeVideoId;
            video.Title = title;
            video.Body = body;
            video.Lat = lat;
            video.Lng = lng;
            video.Country = country;
            video.CountryCode = countryCode;
            video.Region = region;
            video.Province = province;
            video.City = city;
            video.PostalCode = postalCode;
            video.Address = address;
            video.IsTemp = false;
            video.User = _user;
            video.Year = year;

            _container.SaveChanges();

            return video;
        }

        /// <summary>
        /// Save or update picture using specified information. All user temp pictures are removed
        /// </summary>
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

        /// <summary>
        /// Delete user media from db and files from hard disk
        /// </summary>
        /// <param name="id"></param>
        public void DeleteMedia(Guid id)
        {
            //delete from db
            var media = (from m in _container.Medias
                         where m.User.Id == _user.Id
                         && m.Id == id
                         select m).FirstOrDefault();

            if(media == null) 
            {
                throw new MediaNotFoundException(id);
            }

            //delete al media-related contents
            media.DeleteContents();
            //and delete media from db
            _container.DeleteObject(media);
            _container.SaveChanges();
        }

        /// <summary>
        /// Save user comment into specified media
        /// </summary>
        /// <param name="mediaID"></param>
        /// <param name="commentBody"></param>
        public Comment PostComment(Guid mediaId, string commentBody)
        {
            var media = (from m in _container.Medias
                         where m.User.Id == _user.Id
                         && m.Id == mediaId
                         select m).FirstOrDefault();

            if (media == null)
            {
                throw new MediaNotFoundException(mediaId);
            }

            Comment comment = new Comment()
            {
                Body = commentBody,
                Created = DateTime.Now,
                Id = Guid.NewGuid(),
                User = _user,
                Media = media
            };

            _container.AddToComments(comment);
            _container.SaveChanges();

            return comment;
        }

        /// <summary>
        /// Load comments in specified media
        /// </summary>
        /// <param name="mediaId"></param>
        /// <returns></returns>
        public IEnumerable<Comment> LoadComments(Guid mediaId)
        {
            var comments = from m in _container.Comments
                           where m.Media.Id == mediaId
                           select m;

            return comments;
        }

        public int CountComments(Guid mediaId)
        {
            var comments = (from m in _container.Comments
                            where m.Media.Id == mediaId
                            select m).Count();

            return comments;
        }

    }
}