$(function() {
    $('.profile-menu, .mobile-blocks-nav a').on('click', function(event) {
        event.preventDefault();

        var is_active_block = $(this).hasClass('active');
        var is_mobile_block = $(this).parent().hasClass('mobile-blocks-nav');

        if (is_active_block && !is_mobile_block) {
            return;
        }

        $(".mobile-blocks-nav a").removeClass("active");
        $(".sub-nav-pils a").removeClass("active");
        $(".blocks-content .profile-block-container").removeClass("active-block");

        if (!is_active_block) {
            show_block = $(this).data('view');
            $("a[data-view='" + show_block + "']").addClass("active");
            $(".blocks-content div#" + show_block + "").addClass("active-block");
        }
    })

    $('.input-group .g-pencil').on('click', function(e) {
        e.preventDefault();
        $(e.target).prev().trigger('click');
    })

    $('#change-avatar').on('click', function() {
        $('#avatar-file-field').trigger('click');
    })

    $('#avatar-file-field').on('change', function(event) {
        $(this).closest('form').submit();
    })
});
