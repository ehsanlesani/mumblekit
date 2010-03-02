<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<tr>
    <td class="label">
        <div style="position: relative;">
            <span>immagine</span>
            <a href="javascript:;" onclick="addAttachment()" class="topRight"><img src="<%= ResolveUrl("~/Content/Images/addAttachment.png") %>" alt="+" border="0" /></a>
        </div>
    </td>
    <td class="control">
    
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

                $("form")
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
                $("#attachmentsContainer").empty();            
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

                $("#attachmentsContainer").append($("<div />")
                    .addClass("box")
                    .addClass("attachment")
                    .attr("id", attachment.El)
                    .css("width", "350px")
                    .css("position", "relative")
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
                                    .html("Title")
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
                                    .html("Current")
                                )
                                .append($("<td />")
                                    .append($("<a />")
                                        .attr("href", '<%= ResolveUrl("~/Public/") %>' + attachment.Path)
                                        .attr("target", "_blank")
                                        .html(isNullOrUndefined(attachment.Path) ? "" : attachment.Path)
                                    )
                                )
                            )
                            .append($("<tr />")
                                .append($("<td />")
                                    .html("Change...")
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
    
        <div id="attachmentsContainer"></div>
    </td>
</tr>