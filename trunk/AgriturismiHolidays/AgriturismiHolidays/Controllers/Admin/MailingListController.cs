using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using System.Net.Mail;

namespace Premier.Controllers
{
    using Models;
    using Mumble.Web.StarterKit.Models.ExtPartial;
    using System.Data;
    using Mumble.Web.StarterKit.Models.ViewModels;

    public class MailingListController : Controller
    {
        StarterKitContainer _context = new StarterKitContainer();
        MailingListFacade _mailingFacade = new MailingListFacade();
        
        private string _smtp = "smtp.aruba.it";
        private string _username = "2026586@aruba.it";
        private string _password = "45e34ca6";
        private string _mail = "info@expoholidays.com";

        #region Lists

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Index()
        {
            List<MailingList> contacts = _context.MailingList.ToList();
            return View(contacts);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Index(FormCollection parameters)
        {
            MailingListFacade context = new MailingListFacade();
            List<MailingList> contacts = context.GetMailingList(
                parameters["Name"],
                parameters["Surname"],
                parameters["Phone"],
                parameters["Email"]);

            return View(contacts);

        }

        //
        // GET: /MailingList/Details/5

        [ActionName("ThankYou")]
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Details(int UserID)
        {
            MailingList contact = _mailingFacade.GetMailingList(UserID);
            return View(contact);
        }

        public ActionResult GroupList()
        {
            List<MailingListGroup> groups = _context.MailingListGroups.ToList();
            return View(groups);
        }

#endregion

        public ActionResult Iscriviti(string usermail)
        {
            MailingList ml = ParseContact(usermail);
            if (ModelState.IsValid)
            {
                try
                {
                    _context.AddToMailingList(ml);
                    _context.SaveChanges();

                    return Json(new { isOnError = false } );
                }
                catch (Exception e)
                {
                    ModelState.AddModelError("Errore", e);
                    return Json(new { isOnError = true });
                }
                finally
                { }
            }
            else
                return Json(new { isOnError = true });
            //return RedirectToAction("Index", "Home");
        }
                      

        #region Create

        public ActionResult CreateGroup()
        {
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult CreateGroup(string groupname)
        {
            MailingListGroup group = _mailingFacade.GetMailingListGroup(groupname);
            
            if(String.IsNullOrEmpty(groupname) || group != null)            
            {
                ModelState.AddModelError("GroupName", "nome del gruppo non valido");
                return View();
            }

            try
            {
                MailingListGroup mGroup = new MailingListGroup();
                mGroup.Name = groupname;

                _context.AddToMailingListGroups(mGroup);
                _context.SaveChanges();

                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("GroupName", ex);
            }

            return View();
        }


        public ActionResult Create()
        {
            var groupList = _mailingFacade.GetMailingListGroups();
            EditMailingViewModel model = new EditMailingViewModel();
            model.MailingListGroups = groupList;

            return View(model);
        }
        
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(FormCollection form)
        {
            MailingList ml = ParseContact(form["Email"]);
            if (ModelState.IsValid)
            {
                try
                {
                    int value = Int32.Parse(form["GroupId"]);
                    ml.MailingListGroupsReference.EntityKey = new EntityKey("StarterKitContainer.MailingListGroups", "GroupID", value);
                    _context.AddToMailingList(ml);
                    _context.SaveChanges();

                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("Errore", ex);
                }
            }
            return View();
        }

#endregion

        #region Edit

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult EditGroup(int GroupID)
        {
            MailingListGroup mGroup = _mailingFacade.GetMailingListGroup(GroupID);

            return View(mGroup);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult EditGroup(int groupId, FormCollection collection)
        {
            MailingListGroup group = _mailingFacade.GetMailingListGroup(groupId, _context);
            try
            {
                if (string.IsNullOrEmpty(collection["Name"]))
                    ModelState.AddModelError("Name", "Devi specificare il nome.");

                if (ModelState.IsValid)
                {                    
                    group.Name = collection["Name"];
                    _context.SaveChanges();

                    return RedirectToAction("GroupList");
                }
            }
            catch (Exception e)
            {
                ModelState.AddModelError("Errore", e);
            }
            return RedirectToAction("GroupList");;
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Edit(int UserID)
        {
            MailingList contact = _mailingFacade.GetMailingList(UserID);
            EditMailingViewModel model = new EditMailingViewModel();
            model.MailingList = contact;
            model.MailingListGroups = _mailingFacade.GetMailingListGroups();

            return View(model);
        }

        //
        // POST: /MailingList/Edit/5

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Edit(int UserID, FormCollection collection)
        {
            MailingList contact = null;
            EditMailingViewModel model = new EditMailingViewModel();
            //TO BE CONTINUED...
            try
            {              
                contact = _mailingFacade.GetMailingList(UserID, _context);
                if (ModelState.IsValid)
                {
                    //UpdateModel<MailingList>(contact);
                    contact.Email = collection["Email"];
                    int value = Int32.Parse(collection["GroupId"]);
                    contact.MailingListGroupsReference.EntityKey = new EntityKey("StarterKitContainer.MailingListGroups", "GroupID", value);
                    //_context.AddToMailingList(contact);
                    _context.SaveChanges();
                    
                    return RedirectToAction("Index");
                }

                return View(contact);
            }
            catch(Exception e)
            {
                ModelState.AddModelError("Errore", e);

                return View(contact);
            }            
        }

        #endregion

        #region Delete

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Delete(int UserID)
        {
            MailingList contact = _mailingFacade.GetMailingList(UserID, _context);
            if (contact != null)
            {
                _context.DeleteObject(contact);
                _context.SaveChanges();
            }
            return RedirectToAction("Index");
        }


        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult DeleteGroup(int groupID)
        {
            MailingListGroup mGroup = _mailingFacade.GetMailingListGroup(groupID, _context);
            if (mGroup != null)
            {
                _context.DeleteObject(mGroup);
                _context.SaveChanges();
            }
            return RedirectToAction("GroupList");
        }

        #endregion

        #region SendMail


        [ValidateInput(false)]
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult SendMail()
        {
            ViewData["MailingListGroups"] = new SelectList(_mailingFacade.GetMailingListGroups(), "GroupID", "Name");

            return View();
        }

        [ValidateInput(false)]
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult SendMail(string subject, string message, string mailingListGroups)
        {
            if (string.IsNullOrEmpty(subject))
                ModelState.AddModelError("subject", "Devi specificare l'oggetto del messaggio.");

            if (string.IsNullOrEmpty(message))
                ModelState.AddModelError("message", "Devi specificare il messaggio.");

            if (ModelState.IsValid)
            {
                // Elenco completo dei contatti.
                int groupId = Int32.Parse(mailingListGroups);
                var contatti = _mailingFacade.GetMailingListByGroup(groupId);
                MailMessage mailMessage = new MailMessage();
                mailMessage.BodyEncoding = System.Text.Encoding.UTF8;
                mailMessage.Body = message;
                mailMessage.IsBodyHtml = true;
                mailMessage.Subject = subject;
                mailMessage.From = new MailAddress(_mail);

                foreach (MailingList contatto in contatti)
                    mailMessage.To.Add(new MailAddress(contatto.Email));

                // Configurazione per l'invio del messaggio alla mailing list.
                bool operationCompleted = true;
                SmtpClient client = null;
                try
                {
                    client = new SmtpClient(
                        _smtp);
                    client.Credentials = new System.Net.NetworkCredential(
                        _username,
                        _password);

                    client.Send(mailMessage);
                }
                catch { operationCompleted = false; }
                finally
                {
                    client = null;
                }
                mailMessage.Dispose();
                mailMessage = null;

                if (operationCompleted)
                    return RedirectToAction("Index");

            }
            return View();
        }


        [ValidateInput(false)]
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult SendMailToOne(int UserID)
        {
            MailingList contatto = _mailingFacade.GetMailingList(UserID);
            return View(contatto);
        }

        [ValidateInput(false)]
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult SendMailToOne(string Subject, string Message, int UserID)
        {
            MailingList contatto = _mailingFacade.GetMailingList(UserID);
            if (string.IsNullOrEmpty(Subject))
                ModelState.AddModelError("Subject", "Devi specificare l'oggetto!");
            if (string.IsNullOrEmpty(Message))
                ModelState.AddModelError("Message", "Devi specificare il messaggio da inviare.");

            if (ModelState.IsValid)
            {
                // Configurazione del messaggio da inviare.
                MailMessage mailMessage = new MailMessage();
                mailMessage.BodyEncoding = System.Text.Encoding.UTF8;
                mailMessage.Body = Message;
                mailMessage.IsBodyHtml = true;
                mailMessage.Subject = Subject;
                mailMessage.From =
                    new MailAddress(_mail);

                mailMessage.To.Add(new MailAddress(contatto.Email));

                // Configurazione per l'invio del messaggio alla mailing list.
                bool operationCompleted = true;
                SmtpClient client = null;

                try
                {
                    client = new SmtpClient(
                        _smtp);
                    client.Credentials = new System.Net.NetworkCredential(
                        _username,
                        _password);

                    client.Send(mailMessage);
                }
                catch { operationCompleted = false; }
                finally
                {
                    client = null;
                }

                mailMessage.Dispose();
                mailMessage = null;

                if (operationCompleted)
                    return RedirectToAction("Index");
            }

            return View();
        }

        #endregion

        #region Utils

        public MailingList ParseContact(string mail)
        {
            if (!String.IsNullOrEmpty(mail))
            {
                MailingList ml = new MailingList();
                ml.Email = mail;
                ml.Name = "";
                ml.Surname = "";
                ml.Phone = "";

                return ml;
            }
            else 
            {
                ModelState.AddModelError("Email", "Devi specificare un indirizzo email valido.");

                return null;
            }
        }

        #endregion
    }
}
