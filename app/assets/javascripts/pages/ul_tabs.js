$(function() {
    $('#main-page-birds-tabs a').click(function(e) {
        e.preventDefault();
        $(this).tab('show');
    });

    $("ul.nav-tabs > li > a").on("shown.bs.tab", function(e) {
        var id = $(e.target).attr("href").substr(1);
        window.location.hash = id;
    });

    var hash = window.location.hash;
    $('#main-page-birds-tabs a[href="' + hash + '"]').tab('show');
});
