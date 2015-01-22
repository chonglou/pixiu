//= require editor.config
//= require jquery-file-upload/js/vendor/jquery.ui.widget
//= require jquery-file-upload/js/jquery.iframe-transport
//= require jquery-file-upload/js/jquery.fileupload

function click_table_row(id) {
    $('table#' + id + ' > tbody > tr').click(function () {
        window.location.href = $(this).attr('url')
    });
}