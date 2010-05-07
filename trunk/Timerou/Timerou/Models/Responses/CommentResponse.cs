using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Timerou.Models.Helpers;

namespace Mumble.Timerou.Models.Responses
{
    public class CommentResponse : SimpleResponse
    {
        public static CommentResponse FromComment(Comment comment)
        {
            CommentResponse response = new CommentResponse(false, "")
            {
                Body = comment.Body,
                UserName = String.Format("{0} {1}", comment.User.FirstName, comment.User.LastName),
                UserId = comment.User.Id,
                Created = comment.Created.ToString(UIHelper.DateFormat)
            };

            return response;
        }

        public CommentResponse(bool error, string message) 
            : base(error, message)
        { }

        public string Body { get; set; }
        public string UserName { get; set; }
        public Guid UserId { get; set; }
        public string Created { get; set; }
    }
}
