//function openBlock(a) {
//    var toOpen = jQuery(a).data('view');
//    var v = jQuery(a).hasClass('active');
//    var c = jQuery(".blocks-content div#" + toOpen + "").hasClass("active-block");
//    jQuery(".mobile-blocks-nav a").removeClass("active");
//    jQuery(".sub-nav-pils a").removeClass("active");
//    jQuery(".blocks-content .profile-block-container").removeClass("active-block");
//
//    if(!(jQuery(a).parent().hasClass('mobile-blocks-nav') && v == true  && c == true))
//    {
//        jQuery("a[data-view='" + toOpen + "']").addClass("active");
//        jQuery(".blocks-content div#" + toOpen + "").addClass("active-block");
//
//    }
//
//}

//TODO: check conditions from openBlock
$(function() {
    $('.profile-menu').on('click', function(event) {
        event.preventDefault();

        if ($(this).hasClass('active')) {
            return
        }

        $(".mobile-blocks-nav a").removeClass("active");
        $(".sub-nav-pils a").removeClass("active");
        $(".blocks-content .profile-block-container").removeClass("active-block");

        show_block = $(this).data('view');
        $("a[data-view='" + show_block + "']").addClass("active");
        $(".blocks-content div#" + show_block + "").addClass("active-block");
    })

    $('.input-group .g-pencil').on('click', function(e) {
        e.preventDefault();
        $(e.target).prev().trigger('click');
    })
});
