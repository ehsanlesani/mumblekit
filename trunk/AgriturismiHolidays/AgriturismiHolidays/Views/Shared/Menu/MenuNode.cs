using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Views.Shared.Menu
{
    public class MenuNode 
    {
        public List<MenuNode> Childs { get; set; }
        public List<Node> Nodes { get; set; }

        public MenuNode() 
        {
            Childs = new List<MenuNode>();
            Nodes = new List<Node>();
        }

        public void AddMenuNode(MenuNode m) 
        {
            Childs.Add(m);
        }

        public void AddNode(Node node)
        {
            Nodes.Add(node);
        }

        public void AddNode(string title, string url)
        {
            Node node = new Node(title, url);
            Nodes.Add(node);
        }
    }
}