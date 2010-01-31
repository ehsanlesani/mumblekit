using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mumble.Web.StarterKit.Views.Utilities;
using System.Text;

namespace Mumble.Web.StarterKit.Views.Shared.Menu
{
    public class TreeView : IMenu
    {
        private string NodeSpanClass = "add";
        private List<MenuNode> Nodes { get; set; }
        private UrlHelper Helper { get; set; }

        public TreeView(List<MenuNode> nodes, UrlHelper helper) 
        {
            Nodes = nodes;
            Helper = helper;
        }

        public string Render()
        {
            StringBuilder sbTree = new StringBuilder();

            foreach (MenuNode root in Nodes) 
            {
                sbTree.Append(ReadMenuNodes(root));
            }

            return sbTree.ToString();
        }

        private string ReadMenuNodes(MenuNode menunode) 
        {
            if (menunode.Childs.Count > 0)
            {
                TagBuilder tagUl = new TagBuilder("ul");

                foreach (MenuNode m in menunode.Childs)
                {
                    TagBuilder tagLi = new TagBuilder("li");
                    TagBuilder tagSpan = new TagBuilder("span");
                    //To Do: Set Title
                    //tagSpan.SetInnerText(m.);
                    tagSpan.AddCssClass("folder");

                    if (m.Childs.Count > 0)       
                        tagSpan.InnerHtml = ReadMenuNodes(m);

                    tagLi.InnerHtml = tagSpan.ToString(TagRenderMode.Normal);
                    tagUl.InnerHtml += tagLi.ToString(TagRenderMode.Normal);
                }
                
                return tagUl.ToString(TagRenderMode.Normal);
            }
            else 
            {
                string htmlNodes = LoopThroughNodes(menunode.Nodes);

                return htmlNodes;
            }
        }

        private string LoopThroughNodes(List<Node> nodes) 
        {
            if (nodes.Count > 0)
            {
                TagBuilder tagUl = new TagBuilder("ul");

                foreach (Node n in nodes)
                {
                    tagUl.InnerHtml += RenderNode(n);
                }
                
                return tagUl.ToString(TagRenderMode.Normal);
            }

            return "";
        }

        private string RenderNode(Node node) 
        {
            TagBuilder tagLi = new TagBuilder("li");
            
            TagBuilder tagSpan = new TagBuilder("span");
            tagSpan.AddCssClass(NodeSpanClass);
            
            TagBuilder tagHref = new TagBuilder("a");
            tagHref.MergeAttribute("href", Helper.Content(node.Url));
            tagHref.SetInnerText(node.Title);

            tagSpan.InnerHtml = tagHref.ToString(TagRenderMode.Normal);
            tagLi.InnerHtml = tagSpan.ToString(TagRenderMode.Normal);

            return tagLi.ToString(TagRenderMode.Normal);
        }
    }
}