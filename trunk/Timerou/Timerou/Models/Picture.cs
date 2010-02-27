using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;
using Mumble.Timerou.Models.Helpers;

namespace Mumble.Timerou.Models
{
    public partial class Picture
    {
        private string _saveFormat = "jpg";

        /// <summary>
        /// Save picture creating avatar and optimized using original stream
        /// </summary>
        /// <param name="pictureStream">Contains picture data</param>
        public void SaveFiles(Stream pictureStream)
        {
            //load original image
            Image original = Image.FromStream(pictureStream);
            
            CreateAvatar(original);
            CreateOptimized(original); //this saves image scale
            
            string path = HttpContext.Current.Server.MapPath(String.Format("/{0}/{1}", ConfigurationManager.AppSettings["BasePicturesPath"], OriginalPath));
            SavePicture(original, path);

            pictureStream.Close();
        }

        /// <summary>
        /// Change picture assignment changing file names, height and width. This is possible only for temp pictures
        /// </summary>
        /// <param name="newPicture"></param>
        public void AssignFilesToOtherPicture(Picture newPicture)
        {
            if (!(IsTemp.HasValue && IsTemp.Value))
            {
                throw new InvalidOperationException("You can change assignment only if picture is temporary");
            }
            
            string originalPath = null;
            string newPath = null;
            
            //rename original
            originalPath = HttpContext.Current.Server.MapPath(String.Format("/{0}/{1}", ConfigurationManager.AppSettings["BasePicturesPath"], OriginalPath));
            newPath = HttpContext.Current.Server.MapPath(String.Format("/{0}/{1}", ConfigurationManager.AppSettings["BasePicturesPath"], newPicture.OriginalPath));
            this.RenameFile(originalPath, newPath);

            //rename optimized
            originalPath = HttpContext.Current.Server.MapPath(String.Format("/{0}/{1}", ConfigurationManager.AppSettings["BasePicturesPath"], OptimizedPath));
            newPath = HttpContext.Current.Server.MapPath(String.Format("/{0}/{1}", ConfigurationManager.AppSettings["BasePicturesPath"], newPicture.OptimizedPath));
            this.RenameFile(originalPath, newPath);

            //rename avatar
            originalPath = HttpContext.Current.Server.MapPath(String.Format("/{0}/{1}", ConfigurationManager.AppSettings["BasePicturesPath"], AvatarPath));
            newPath = HttpContext.Current.Server.MapPath(String.Format("/{0}/{1}", ConfigurationManager.AppSettings["BasePicturesPath"], newPicture.AvatarPath));
            this.RenameFile(originalPath, newPath);

            newPicture.Height = Height;
            newPicture.Width = Width;
        }

        /// <summary>
        /// Delete all picture related files (if exists) from disk
        /// </summary>
        public void DeleteFiles()
        {
            string path = HttpContext.Current.Server.MapPath(String.Format("/{0}/{1}", ConfigurationManager.AppSettings["BasePicturesPath"], OriginalPath));
            if (File.Exists(path)) { File.Delete(path); }
            path = HttpContext.Current.Server.MapPath(String.Format("/{0}/{1}", ConfigurationManager.AppSettings["BasePicturesPath"], OptimizedPath));
            if (File.Exists(path)) { File.Delete(path); }
            path = HttpContext.Current.Server.MapPath(String.Format("/{0}/{1}", ConfigurationManager.AppSettings["BasePicturesPath"], AvatarPath));
            if (File.Exists(path)) { File.Delete(path); }
        }

        private void RenameFile(string source, string destination)
        {
            //check if source exitst
            if (File.Exists(source))
            {
                //check if destination exists and delete it
                if (File.Exists(destination))
                {
                    File.Delete(destination);
                }

                File.Move(source, destination);
            }
            else
            {
                throw new FileNotFoundException(source);
            }
        }

        private void CreateOptimized(Image original)
        {
            int maxWidth = Int32.Parse(ConfigurationManager.AppSettings["MaxPictureWidth"]);
            int maxHeight = Int32.Parse(ConfigurationManager.AppSettings["MaxPictureHeight"]);

            Image optimized = ImageHelper.CreateOptimized(original, maxWidth, maxHeight);

            Height = optimized.Height;
            Width = optimized.Width;

            string path = HttpContext.Current.Server.MapPath(String.Format("/{0}/{1}", ConfigurationManager.AppSettings["BasePicturesPath"], OptimizedPath));
            SavePicture(optimized, path);
            optimized.Dispose();
        }

        private void CreateAvatar(Image original)
        {
            int width = Int32.Parse(ConfigurationManager.AppSettings["AvatarWidth"]);
            int height = Int32.Parse(ConfigurationManager.AppSettings["AvatarHeight"]);

            Image avatar = ImageHelper.CreateAvatar(original, width, height);

            string path = HttpContext.Current.Server.MapPath(String.Format("/{0}/{1}", ConfigurationManager.AppSettings["BasePicturesPath"], AvatarPath));
            SavePicture(avatar, path);
            avatar.Dispose();
        }

        private void SavePicture(Image picture, string path)
        {
            string dirPath = Path.GetDirectoryName(path);
            if (!Directory.Exists(dirPath)) { Directory.CreateDirectory(dirPath); }
            FileStream fout = new FileStream(path, FileMode.Create);
            ImageCodecInfo encoder = ImageCodecInfo.GetImageEncoders().Where(c => c.MimeType == "image/jpeg").First();
            EncoderParameters parameters = new EncoderParameters(1);
            Int64 quality = Int64.Parse(ConfigurationManager.AppSettings["PictureQuality"]);
            parameters.Param[0] = new EncoderParameter(Encoder.Quality, quality);
            picture.Save(fout, encoder, parameters);
            fout.Close();
        }

        /// <summary>
        /// Gets or sets the avatar path
        /// </summary>
        public string AvatarPath
        {
            get
            {
                if (User == null && !UserReference.IsLoaded) { UserReference.Load(); }
                if (User == null) { throw new ArgumentNullException("User"); }

                return String.Format("{0}/{1}.{2}",
                    User.Email.Replace("@", "_"),
                    String.Format(ConfigurationManager.AppSettings["PictureAvatar"], Id),
                    _saveFormat);
            }
        }

        /// <summary>
        /// Gets or sets the original path
        /// </summary>
        public string OriginalPath
        {
            get
            {
                if (User == null && !UserReference.IsLoaded) { UserReference.Load(); }
                if (User == null) { throw new ArgumentNullException("User"); }

                return String.Format("{0}/{1}.{2}",
                    User.Email.Replace("@", "_"),
                    String.Format(ConfigurationManager.AppSettings["PictureOriginal"], Id),
                    _saveFormat);
            }
        }

        /// <summary>
        /// Gets or sets the optimized path
        /// </summary>
        public string OptimizedPath
        {
            get
            {
                if (User == null && !UserReference.IsLoaded) { UserReference.Load(); }
                if (User == null) { throw new ArgumentNullException("User"); }

                return String.Format("{0}/{1}.{2}",
                    User.Email.Replace("@", "_"),
                    String.Format(ConfigurationManager.AppSettings["PictureOptimized"], Id),
                    _saveFormat);
            }
        }

        public override void DeleteContents()
        {
            string basePath = HttpContext.Current.Server.MapPath(String.Format("/{0}/", ConfigurationManager.AppSettings["BasePicturesPath"]));
            string[] files = {
                                 String.Concat(basePath, OriginalPath),
                                 String.Concat(basePath, OptimizedPath),
                                 String.Concat(basePath, AvatarPath)
                             };

            foreach (var file in files)
            {
                if (File.Exists(file)) { File.Delete(file); }
            }
        }

    }
}