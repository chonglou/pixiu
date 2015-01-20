function click_table_row(id){
    $('table#users > tbody > tr').click(function () {
        window.location.href = $(this).attr('url')
    });
}