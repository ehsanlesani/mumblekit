using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Timerou.Models;
using Mumble.Timerou.Models.Auth;
using Mumble.Timerou.Models.Responses;
using Mumble.Timerou.Models.Exceptions;
using Mumble.Timerou.Models.Helpers;
using Mumble.Timerou.Models.Managers;

namespace Mumble.Timerou.Controllers
{
    public class CommentsController : AuthController
    {
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Post(Guid mediaId, string body)
        {
            SimpleResponse response = null;

            try
            {
                Authorize();

                if (String.IsNullOrEmpty(body))
                {
                    throw new ArgumentException("Body not specified", "body");
                }

                ControlPanel controlPanel = new ControlPanel(AccountManager.LoggedUser, Container);
                Comment comment = controlPanel.PostComment(mediaId, body);

                response = CommentResponse.FromComment(comment);
            }
            catch (AuthException)
            {
                response = new SimpleResponse(true, UIHelper.Translate("err.unauthorized"));
            }
            catch (Exception ex)
            {
                response = new SimpleResponse(true, ex.Message);
            }

            return this.CamelCaseJson(response);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Load(Guid mediaId)
        {
            SimpleResponse response = null;

            try
            {
                Authorize();

                ControlPanel controlPanel = new ControlPanel(AccountManager.LoggedUser, Container);
                IEnumerable<Comment> comments = controlPanel.LoadComments(mediaId);

                response = CommentsResponse.FromComments(comments);
            }
            catch (AuthException)
            {
                response = new SimpleResponse(true, UIHelper.Translate("err.unauthorized"));
            }
            catch (Exception ex)
            {
                response = new SimpleResponse(true, ex.Message);
            }

            return this.CamelCaseJson(response);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Count(Guid mediaId)
        {
            SimpleResponse response = null;

            try
            {
                Authorize();

                ControlPanel controlPanel = new ControlPanel(AccountManager.LoggedUser, Container);
                int comments = controlPanel.CountComments(mediaId);

                response = new CountResponse(false, "", comments);
            }
            catch (AuthException)
            {
                response = new SimpleResponse(true, UIHelper.Translate("err.unauthorized"));
            }
            catch (Exception ex)
            {
                response = new SimpleResponse(true, ex.Message);
            }

            return this.CamelCaseJson(response);
        }

    }
}
