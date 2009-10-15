using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;

namespace Mumble.Web.StarterKit.Models.Scaffold.Converters.Custom
{
    public class AttachmentsConverter : IValueConverter
    {
        public object Convert(string value)
        {
            StarterKitContainer container = (StarterKitContainer)Scaffolder.Current.ObjectContext;
            Page page = Scaffolder.Current.CurrentEntity as Page;
            
            if (page != null)
            {
                AttachmentInfo[] infos = JsonConvert.DeserializeObject<AttachmentInfo[]>(value);
                if (infos != null)
                {
                    foreach (AttachmentInfo info in infos)
                    {
                        bool newRecord = false;
                        
                        Attachment attachment = null;
                        //check if exits
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
                            attachment.Page = null;
                            container.DeleteObject(attachment);
                        }
                        else
                        {
                            attachment.Title = info.Title;
                            attachment.Description = info.Title;

                            HttpPostedFile file = HttpContext.Current.Request.Files[info.FileInput];
                            if (file != null && file.ContentLength > 0)
                            {
                                file.SaveAs(HttpContext.Current.Server.MapPath("~/Public/") + file.FileName);
                                attachment.Path = file.FileName;

                                if (newRecord)
                                    page.Attachments.Add(attachment);
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
            Page page = Scaffolder.Current.CurrentEntity as Page;

            if (page != null)
            {
                infos = (from a in container.Attachments
                         where a.Page.Id == page.Id
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