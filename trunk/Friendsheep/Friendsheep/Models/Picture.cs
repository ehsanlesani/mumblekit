using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;

namespace Mumble.Friendsheep.Models
{
    public partial class Picture
    {
        private string _saveFormat = "jpg";

        /// <summary>
        /// Create a default profile picture object
        /// </summary>
        public static Picture Default
        {
            get
            {
                Picture def = Picture.CreatePicture(
                    Guid.Empty,
                    0,
                    DateTime.Now,
                    "",
                    false,
                    Int32.Parse(ConfigurationManager.AppSettings["MaxPictureHeight"]),
                    Int32.Parse(ConfigurationManager.AppSettings["MaxPictureWidth"]));

                return def;
            }
        }

        /// <summary>
        /// Save picture creating avatar and optimized using original stream
        /// </summary>
        /// <param name="pictureStream">Contains picture data</param>
        public void Save(Stream pictureStream)
        {
            //load original image
            Image original = Image.FromStream(pictureStream);
            
            CreateAvatar(original);
            CreateOptimized(original); //this saves image dimensions

            pictureStream.Close();
        }

        private void CreateOptimized(Image original)
        {
            int maxWidth = Int32.Parse(ConfigurationManager.AppSettings["MaxPictureWidth"]);
            int maxHeight = Int32.Parse(ConfigurationManager.AppSettings["MaxPictureHeight"]);
            double div = 1;
            if (original.Width > original.Height)
            {
                div = (double)maxWidth / (double)original.Width;
            }
            else
            {
                div = (double)maxHeight / (double)original.Height;
            }

            Width = (int)(original.Width * div);
            Height = (int)(original.Height * div);

            Bitmap optimized = new Bitmap(Width, Height);
            Graphics g = Graphics.FromImage(optimized);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
            RectangleF source = new RectangleF(0, 0, original.Width, original.Height);

            g.DrawImage(original, new RectangleF(0, 0, Width, Height), source, GraphicsUnit.Pixel);
            g.Dispose();

            string path = HttpContext.Current.Server.MapPath(String.Format("/{0}/{1}", ConfigurationManager.AppSettings["BasePicturesPath"], OptimizedPath));
            SavePicture(optimized, path);
            optimized.Dispose();
        }

        private void CreateAvatar(Image original)
        {
            int width = Int32.Parse(ConfigurationManager.AppSettings["AvatarWidth"]);
            int height = Int32.Parse(ConfigurationManager.AppSettings["AvatarHeight"]);
            Bitmap avatar = new Bitmap(width, height);
            Graphics g = Graphics.FromImage(avatar);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;

            //create source rectangle
            double div = 0.0;
            double destMaxSize = Math.Max(width, height);
            double originMinSize = Math.Min(original.Width, original.Height);
            div = originMinSize / destMaxSize;
            RectangleF source = new RectangleF(0, 0, (int)(width * div), (int)(height * div));
            if (original.Width - source.Width != 0)
            {
                source.X = (original.Width - source.Width) / 2;
            }
            if (original.Height - source.Height != 0)
            {
                source.Y = (original.Height - source.Height) / 2;
            }

            g.DrawImage(original, new RectangleF(0, 0, width, height), source, GraphicsUnit.Pixel);
            g.Dispose();

            string path = HttpContext.Current.Server.MapPath(String.Format("/{0}/{1}", ConfigurationManager.AppSettings["BasePicturesPath"], AvatarPath));
            SavePicture(avatar, path);
            avatar.Dispose();
        }

        private void SavePicture(Bitmap picture, string path)
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
                return String.Format("{0}/{1}.{2}",
                    Album.User.Email.Replace("@", "_"),
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
                return String.Format("{0}/{1}.{2}",
                    Album.User.Email.Replace("@", "_"),
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
                return String.Format("{0}/{1}.{2}",
                    Album.User.Email.Replace("@", "_"),
                    String.Format(ConfigurationManager.AppSettings["PictureOptimized"], Id),
                    _saveFormat);
            }
        }
    }
}