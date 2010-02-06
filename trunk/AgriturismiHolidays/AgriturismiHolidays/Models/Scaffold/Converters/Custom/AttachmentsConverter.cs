using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using System.Net.Mime;
using Mumble.Web.StarterKit.Models.Images;
using System.Drawing;
using Mumble.Web.StarterKit.Models.ExtPartial;

namespace Mumble.Web.StarterKit.Models.Scaffold.Converters.Custom
{
    public class AttachmentsConverter : IValueConverter
    {
        public object Convert(string value)
        {
            StarterKitContainer container = (StarterKitContainer)Scaffolder.Current.ObjectContext;
            IEntityWithAttachments entity = Scaffolder.Current.CurrentEntity as IEntityWithAttachments;
            
            if (entity != null)
            {
                AttachmentInfo[] infos = JsonConvert.DeserializeObject<AttachmentInfo[]>(value);
                if (infos != null)
                {
                    foreach (AttachmentInfo info in infos)
                    {
                        bool newRecord = false;
                        
                        Attachment attachment = null;
                        //check if exists
                        if (info.Id.HasValue)
                        {
                            attachment = container.Attachments.Where(a => a.Id == info.Id).First();
                        }
                        else
                        {
                            attachment = new Attachment();
                            attachment.Id = Guid.NewGuid();
                            newRecord = true;
                        }

                        if (info.Id.HasValue && info.Delete)
                        {
                            attachment.Pages = null;
                            container.DeleteObject(attachment);
                        }
                        else
                        {
                            attachment.Title = info.Title;
                            attachment.Description = info.Title;

                            HttpPostedFile file = HttpContext.Current.Request.Files[info.FileInput];
                            if (file != null && file.ContentLength > 0)
                            {
                                if (file.ContentType.Equals("image/jpg") ||
                                    file.ContentType.Equals("image/jpeg") ||
                                    file.ContentType.Equals("image/pjpeg"))
                                {
                                    // TODO: Code Below is just for a "friend" usage. Please modify it to be useful in a general purpose context.
                                    //file.SaveAs(HttpContext.Current.Server.MapPath("~/Public/") + attachment.Id.ToString() + ".jpg");
                                    Image tmpImage = null;
                                    tmpImage = ImageHelper.CreateAvatar(Image.FromStream(file.InputStream), 640, 480);
                                    attachment.Path = attachment.Id.ToString();
                                    tmpImage.Save(HttpContext.Current.Server.MapPath("~/Public/") + attachment.Id.ToString() + ".jpg");

                                    tmpImage = ImageHelper.CreateAvatar(Image.FromStream(file.InputStream), 100, 100);
                                    tmpImage.Save(HttpContext.Current.Server.MapPath("~/Public/") + attachment.Id.ToString() + "_lil.jpg");

                                    if (newRecord)
                                        entity.Attachments.Add(attachment);
                                }
                                else 
                                {
                                    throw new FormatException("You can upload only *.JPEG");
                                }
                            }
                        }
                    }
                }
            }

            return null;
        }

        public string Convert(object value)
        {
            AttachmentInfo[] infos = new AttachmentInfo[0];
            StarterKitContainer container = (StarterKitContainer)Scaffolder.Current.ObjectContext;
            IEntityWithAttachments entity = Scaffolder.Current.CurrentEntity as IEntityWithAttachments;

            if (entity != null)
            {
                if (!entity.Attachments.IsLoaded)
                    entity.Attachments.Load();

                infos = (from a in entity.Attachments
                         select new AttachmentInfo()
                         {
                             Id = a.Id,
                             Path = a.Path,
                             Title = a.Title
                         }).ToArray();
            }

            return JsonConvert.SerializeObject(infos);
        }

        class AttachmentInfo
        {
            public Guid? Id { get; set; }
            public string Title { get; set; }
            public string Path { get; set; }
            public string FileInput { get; set; }
            public bool Delete { get; set; }
        }
    }
}