using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing;

namespace Mumble.Web.StarterKit.Models.Images
{
    public static class ImageHelper
    {
        /// <summary>
        /// Creates optimized/in scale image of specified size
        /// </summary>
        /// <param name="original"></param>
        /// <param name="maxWidth"></param>
        /// <param name="maxHeight"></param>
        /// <returns></returns>
        public static Image CreateOptimized(Image original, int maxWidth, int maxHeight)
        {
            double div = 1;
            if (original.Width > original.Height)
            {
                div = (double)maxWidth / (double)original.Width;
            }
            else
            {
                div = (double)maxHeight / (double)original.Height;
            }

            int width = (int)(original.Width * div);
            int height = (int)(original.Height * div);

            Bitmap optimized = new Bitmap(width, height);
            Graphics g = Graphics.FromImage(optimized);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
            RectangleF source = new RectangleF(0, 0, original.Width, original.Height);

            g.DrawImage(original, new RectangleF(0, 0, width, height), source, GraphicsUnit.Pixel);
            g.Dispose();

            return optimized;
        }

        /// <summary>
        /// Creates avatar image of specified size. If scale is not the same, avatar gets the original center as source
        /// </summary>
        /// <param name="original"></param>
        /// <param name="?"></param>
        /// <param name="?"></param>
        /// <returns></returns>
        public static Image CreateAvatar(Image original, int width, int height)
        {
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

            return avatar;
        }
    }
}
