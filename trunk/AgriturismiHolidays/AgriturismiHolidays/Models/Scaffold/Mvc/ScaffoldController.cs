using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Data.SqlClient;
using System.Data;

namespace Mumble.Web.StarterKit.Models.Scaffold.Mvc
{
    public abstract class ScaffoldController<T> : Controller where T : EntityObject
    {
        protected abstract ObjectContext ObjectContext { get; }   

        protected virtual string EditView { get { return "~/Views/Scaffold/Edit.aspx"; } }
        protected virtual string ListView { get { return "~/Views/Scaffold/List.aspx"; } }
        protected virtual string EditAction { get { return Url.Action("/Edit")+"/"; } }
        protected virtual string SaveAction { get { return Url.Action("/Save")+"/"; } }
        protected virtual string ListAction { get { return Url.Action("/List")+"/"; } }
        protected virtual string DeleteAction { get { return Url.Action("/Delete")+"/"; } }
        protected Scaffolder Scaffolder { get; private set; }
        
        public ScaffoldController()
        {
            Scaffolder = new Scaffolder(ObjectContext);
        }

        public virtual ActionResult Index()
        {
            return List();
        }

        public virtual ActionResult Edit(Guid? id)
        {
            ViewData.Model = new ScaffoldViewData() { Scaffolder = Scaffolder, EntityType = typeof(T), Id = id, SaveAction = SaveAction };

            return View(EditView);
        }

        [ValidateInput(false)] 
        public virtual ActionResult Save()
        {
            Scaffolder.Save(typeof(T), Request.Form);

            return List();
        }

        public virtual ActionResult List()
        {
            ViewData.Model = new ScaffoldViewData() { Scaffolder = Scaffolder, EntityType = typeof(T), EditAction = EditAction, DeleteAction = DeleteAction };

            return View(ListView);
        }

        public virtual ActionResult Delete(Guid id)
        {
            try
            {
                Scaffolder.Delete(typeof(T), id);
            }
            catch (UpdateException ex)
            {
                //check integrity
                if (ex.InnerException is SqlException)
                {
                    SqlException sex = (SqlException)ex.InnerException;
                    if (sex.Number == 547)
                    {
                        ViewData["Message"] = "Impossibile eliminare. L'elemento contiene degli oggetti figlio";
                    }
                }                
            }

            return List();
        }
    }
}