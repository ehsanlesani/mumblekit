using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Exceptions
{
    public class ResourceNotFoundException : Exception
    {
        public ResourceNotFoundException(string resource)
            : base(String.Format("Resource '{0}' not found", resource))
        {
            Resource = resource;
        }
        
        public string Resource { get; set; }
    }
}