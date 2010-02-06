using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.ViewModels
{
    public abstract class CustomViewModel
    {
        public bool ErrorThrown { get; private set; }
        public string ErrorMessage { get; private set; }

        public void SetError(string msg) {
            ErrorThrown = true;
            ErrorMessage = msg;
        }
    }
}
