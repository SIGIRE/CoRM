function addFileField(object) {
    var id = document.getElementById("attachment_id").value;
    jQuery.noConflict()
    jQuery("#new_attachments").append("<tr id='attachment_" + id + "' style='width:100%'>");
    jQuery("#attachment_" + id).append("<td><input type='file' name='"+ object +"["+ object +"_attachments_attributes][][attach]'/></td>");
    jQuery("#attachment_" + id).append("<strong>|</strong>");
    jQuery("#attachment_" + id).append("<td>&nbsp;&nbsp<a href='#' onClick='removeFileField(\"#attachment_" + id + "\"); return false;'>Supprimer</a></td>");
    jQuery("#new_attachments").append("</tr>");

    id = (id - 1) + 2;
    document.getElementById("attachment_id").value = id;
}

function removeFileField(id) {
    jQuery(id).remove();
}

