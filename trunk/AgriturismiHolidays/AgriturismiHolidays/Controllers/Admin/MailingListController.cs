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

    public class MailingListController : Controller
    {
        StarterKitContainer _context = new StarterKitContainer();
        MailingListFacade _mailingFacade = new MailingListFacade();
        
        private string _smtp = "smtp.aruba.it";
        private string _username = "2026586@aruba.it";
        private string _password = "45e34ca6";
        private string _mail = "info@expoholidays.com";
        /*
        private string _smtp = "box.exent.it";
        private string _username = "geek@exent.it";
        private string _password = "sasso";
        private string _mail = "geek@exent.it";
        */
        [ValidateInput(false)]
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult SendMail()
        {
            return View();
        }

        [ValidateInput(false)]
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult SendMail(string subject, string message)
        {
            if (string.IsNullOrEmpty(subject))
                ModelState.AddModelError("subject", "Devi specificare l'oggetto del messaggio.");

            if (string.IsNullOrEmpty(message))
                ModelState.AddModelError("message", "Devi specificare il messaggio.");

            if (ModelState.IsValid)
            {
                // Elenco completo dei contatti.
                List<MailingList> contatti = _mailingFacade.GetMailingList();
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

        //
        // GET: /MailingList/Create
        
        public ActionResult Create()
        {
            return View();
        }

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

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(string email)
        {
            MailingList ml = ParseContact(email);
            if (ModelState.IsValid)
            {
                try
                {
                    if (ModelState.IsValid)
                    {
                        _context.AddToMailingList(ml);
                        _context.SaveChanges();

                        return RedirectToAction("Index");
                    }
                    else
                    {

                    }
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("Errore", ex);
                }
            }
            return View();
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Edit(int UserID)
        {
            MailingList contact = _mailingFacade.GetMailingList(UserID);

            return View(contact);
        }

        //
        // POST: /MailingList/Edit/5

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Edit(int UserID, FormCollection collection)
        {
            MailingList contact = _mailingFacade.GetMailingList(UserID, _context);
            try
            {
                if (ModelState.IsValid)
                {
                    //UpdateModel<MailingList>(contact);
                    contact.Email = collection["Email"];
                    //_context.AddToMailingList(contact);
                    _context.SaveChanges();
                    
                    return RedirectToAction("Index");
                }
            }
            catch(Exception e)
            {
                ModelState.AddModelError("Errore", e);
            }

            return View(contact);
        }

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
    }
}
