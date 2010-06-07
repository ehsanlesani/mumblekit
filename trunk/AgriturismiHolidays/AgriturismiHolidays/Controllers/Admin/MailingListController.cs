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

        [Authorize]
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult SendMail()
        {
            return View();
        }

        [Authorize]
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
                mailMessage.Subject = subject;
                mailMessage.From =
                    new MailAddress(System.Configuration.ConfigurationManager.AppSettings["Mail_To"]);
                            
                foreach (MailingList contatto in contatti)
                    mailMessage.To.Add(new MailAddress(contatto.Email));

                // Configurazione per l'invio del messaggio alla mailing list.
                bool operationCompleted = true;
                SmtpClient client = null;
                try
                {
                    client = new SmtpClient(
                        System.Configuration.ConfigurationManager.AppSettings["Mail_ToSMTPServer"]);
                    client.Credentials = new System.Net.NetworkCredential(
                        System.Configuration.ConfigurationManager.AppSettings["Mail_To"],
                        System.Configuration.ConfigurationManager.AppSettings["Mail_ToPassword"]);

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

        [Authorize]
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Index()
        {
            List<MailingList> contacts = _context.MailingList.ToList();
            return View(contacts);
        }

        [Authorize]
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

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Iscriviti(MailingList mailingList)
        {
            ParseContact(mailingList);
            if (ModelState.IsValid)
            {
                try
                {
                    _context.AddToMailingList(mailingList);
                    _context.SaveChanges();

                    return RedirectToAction("ThankYou", new { UserID = mailingList.UserID });
                }
                catch (Exception e)
                {
                    ModelState.AddModelError("Errore", e);
                }
                finally
                { }
            }
            return RedirectToAction("Index", "Home");
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(MailingList mailingList)
        {
            ParseContact(mailingList);
            if (ModelState.IsValid)
            {
                try
                {
                    if (ModelState.IsValid)
                    {
                        _context.AddToMailingList(mailingList);
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

        [Authorize]
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
            MailingList contact = _mailingFacade.GetMailingList(UserID);
            try
            {
                if (string.IsNullOrEmpty(collection["Name"]))
                    ModelState.AddModelError("Name", "Devi specificare il nome.");
                if (string.IsNullOrEmpty(collection["Surname"]))
                    ModelState.AddModelError("Surname", "Devi specificare il cognome.");

                if (ModelState.IsValid)
                {
                    UpdateModel<MailingList>(contact);
                    _context.SaveChanges();
                    
                    return RedirectToAction("Index");
                }
            }
            catch(Exception e)
            {
                ModelState.AddModelError("Errore", e);
            }
            return View();
        }

        [Authorize]
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Delete(int UserID)
        {
            MailingList contact = _mailingFacade.GetMailingList(UserID);
            if (contact != null)
            {
                _context.DeleteObject(contact);
                _context.SaveChanges();
            }
            return RedirectToAction("Index");
        }

        [Authorize]
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult SendMailToOne(int UserID)
        {
            MailingList contatto = _mailingFacade.GetMailingList(UserID);
            return View(contatto);
        }

        [Authorize]
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
                mailMessage.Subject = Subject;
                mailMessage.From =
                    new MailAddress(System.Configuration.ConfigurationManager.AppSettings["Mail_To"]);

                mailMessage.To.Add(new MailAddress(contatto.Email));

                // Configurazione per l'invio del messaggio alla mailing list.
                bool operationCompleted = true;
                SmtpClient client = null;
                try
                {
                    client = new SmtpClient(
                        System.Configuration.ConfigurationManager.AppSettings["Mail_ToSMTPServer"]);
                    client.Credentials = new System.Net.NetworkCredential(
                        System.Configuration.ConfigurationManager.AppSettings["Mail_To"],
                        System.Configuration.ConfigurationManager.AppSettings["Mail_ToPassword"]);

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

        public void ParseContact(MailingList contact)
        {
            if (string.IsNullOrEmpty(contact.Name))
                ModelState.AddModelError("Name", "Devi specificare il nome.");
            if (string.IsNullOrEmpty(contact.Surname))
                ModelState.AddModelError("Surname", "Devi specificare il cognome.");
            if (string.IsNullOrEmpty(contact.Email))
                ModelState.AddModelError("Email", "Devi specificare un indirizzo email valido.");
        }
    }
}
