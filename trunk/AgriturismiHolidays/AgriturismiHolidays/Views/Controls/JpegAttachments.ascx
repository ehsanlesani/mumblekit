<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<tr>
    <td class="alignment valignTop">
            <span>Immagini</span>
            <a href="javascript:;" onclick="addAttachment()" class="topRight"><img class="addOneMore" src="<%= ResolveUrl("~/Content/Images/add.png") %>" alt="+" border="0" /></a>        
    </td>
    <td class="control">
        <script src="<%=ResolveUrl("~/Content/JS/jquery/jquery.json.js") %>"></script>
        <script type="text/javascript">
        
        
            var attachments = [];
            var attachmentCounter = 0;

            function Attachment() {
                this.Id = null;
                this.Title = null;
                this.Path = null;
                this.FileInput = null;
                this.Delete = false;
            }

            
            $(document).ready(function() {
                
                jQuery.fn.appendIf = function(condition, el) {
                    if (condition)
                        return jQuery(this).append(el);
                    return jQuery(this);
                };

                //$("form#registerAccommodationFrm").attr("enctype", "multipart/form-data");

                $("form#registerAccommodationFrm")
                    .attr("enctype", "multipart/form-data")
                    .submit(function() {
                        $("#attachmentsJson").val($.toJSON(attachments));
                    });

                var json = $("#attachmentsJson").val();
                if (json.length > 0) {
                    attachments = $.parseJSON(json);
                }

                loadAttachments();
            });

            function loadAttachments() {
                $("#attachmentsContainerPublic").empty();            
                attachmentCounter = 0;
                $(attachments).each(function(i, attachment) {
                    createAttachment(attachment);
                });
            }

            function addAttachment() {
                var attachment = new Attachment();
                attachment.Title = "Nuova Immagine";
                attachments.push(attachment);

                createAttachment(attachment);
            }

            function deleteAttachment(attachment) {
                $("#" + attachment.El).remove();
                attachment.Delete = true;
            }

            function isNullOrUndefined(check) {
                if (check == undefined)
                    return true;

                if (check == null)
                    return true;

                return false;
            }

            function createAttachment(attachment) {
                attachment.FileInput = "file_" + attachmentCounter;
                attachment.El = "attachment_" + attachmentCounter;

                $("#attachmentsContainerPublic").append($("<div />")
                    .addClass("box")
                    .addClass("attachment")
                    .attr("id", attachment.El)
                    .css("position", "relative")
                    .css("background-color", "white")
                    .css("border", "1px dotted #4F2925")
                    .append($("<a />")
                        .attr("href", "javascript:;")
                        .addClass("topRight")
                        .append($("<img />")
                            .attr("src", '<%= ResolveUrl("~/Content/Images/delete.png") %>')
                            .css("border", "0")
                        )
                        .click(function() { deleteAttachment(attachment); })
                    )
                    .append($("<table />")
                        .attr("cellpadding", 2)
                        .attr("cellspacing", 1)
                        .attr("border", 0)
                        .append($("<tbody />")
                            .append($("<tr />")
                                .append($("<td />")
                                    .html("Titolo")
                                )
                                .append($("<td />")
                                    .append($("<input />")
                                        .attr("type", "text")
                                        .val(isNullOrUndefined(attachment.Title) ? "" : attachment.Title)
                                        .change(function() { attachment.Title = $(this).val(); })
                                    )
                                )
                            )
                            .appendIf(!isNullOrUndefined(attachment.Path), $("<tr />")
                                .append($("<td />")
                                    .html("Link Foto")
                                )
                                .append($("<td />")
                                    .append($("<a />")
                                        .attr("href", '<%= ResolveUrl("~/Public/") %>' + attachment.Path +".jpg")
                                        .attr("target", "_blank")
                                        .html(isNullOrUndefined(attachment.Path) ? "" : attachment.Path + ".jpg")
                                    )
                                )
                            )
                            .append($("<tr />")
                                .append($("<td />")
                                    .html("Seleziona/Cambia...")
                                )
                                .append($("<td />")
                                    .append($("<input />")
                                        .attr("type", "file")
                                        .attr("name", attachment.FileInput)
                                    )
                                )
                            )
                        )
                    )
                );

                attachmentCounter++;
            }
        </script>
        
        <input type="hidden" id="attachmentsJson" name="jpegAttachments" value="<%= Server.HtmlEncode(ViewData["JsonValue"].ToString()) %>" />
    
        <div id="attachmentsContainerPublic"></div>
    </td>
</tr>