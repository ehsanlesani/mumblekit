using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Web.StarterKit.Models.ExtPartial;

namespace Mumble.Web.StarterKit.Models.Common
{
    public class LocalityHelper
    {
        public static StarterKitContainer Container { get { return new StarterKitContainer(); } }

        public static IQueryable<JsonSelection> GetRegions() 
        {
            var regions = (from r in LocalityHelper.Container.Regions orderby r.Description select new JsonSelection { Id = r.Id, Value = r.Description });

            return regions;
        }

        public static IQueryable<JsonSelection> GetProvinces(Guid regionId)
        {
            var provinces = (from p in LocalityHelper.Container.Provinces where p.Region.Id == regionId orderby p.Name select new JsonSelection { Id = p.Id, Value = p.Name });

            return provinces;
        }

        public static IQueryable<JsonSelection> GetMunicipalities(Guid provinceId)
        {
            var municipalities = (from m in LocalityHelper.Container.Municipalities where m.Provinces.Id == provinceId orderby m.Name select new JsonSelection { Id = m.Id, Value = m.Name });

            return municipalities;
        }
    }
}
