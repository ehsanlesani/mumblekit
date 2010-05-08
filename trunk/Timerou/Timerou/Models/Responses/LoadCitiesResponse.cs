using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    public class LoadCitiesResponse : SimpleResponse
    {
        public static LoadCitiesResponse FromList(IEnumerable<GeoInfo> infos)
        {
            LoadCitiesResponse response = new LoadCitiesResponse(false, "Media loaded");           
            
            foreach (var info in infos)
            {
                response.Info.Add(info);
            }
            
            return response;
        }

        public LoadCitiesResponse(bool error, string message)
            :base(error, message)
        {
            Info = new List<GeoInfo>();
        }

        public List<GeoInfo> Info { get; set; }
    }
}
