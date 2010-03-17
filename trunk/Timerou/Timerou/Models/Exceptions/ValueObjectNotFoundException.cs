using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Exceptions
{
    public class ValueObjectNotFoundException : Exception
    {
        public ValueObjectNotFoundException(Type valueObjectType)
        {
            ValueObjectType = valueObjectType;
        }

        public Type ValueObjectType { get; set; }
    }
}
