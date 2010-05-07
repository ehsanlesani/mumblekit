using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    public class CommentsResponse : SimpleResponse
    {
        public static CommentsResponse FromComments(IEnumerable<Comment> comments)
        {
            var commentsResponse = new CommentsResponse(false, "");

            foreach (var comment in comments)
            {
                commentsResponse.Comments.Add(CommentResponse.FromComment(comment));
            }
            return commentsResponse;
        }

        public CommentsResponse(bool error, string message) 
            : base(error, message)
        { 
            Comments = new List<CommentResponse>();
        }

        public List<CommentResponse> Comments { get; set; }
    }
}
