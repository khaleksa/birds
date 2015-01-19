$(function() {
    $('.thumb_container .img-responsive').on('click', function(event) {
        image = $(event.target)
        $('.bird-photo-img .img-responsive').attr('src', image.data('src'));
        $('#photo_descr_text').text(image.data('description'));
        $('#photo_profile_lnk').text(image.data('author'));
        $('#photo_date').text(image.data('date'));
        $('#photo_place').text(image.data('place'));
    });
});
