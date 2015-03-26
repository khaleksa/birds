$(function() {
    $('.thumb_container .img-responsive').on('click', function(event) {
        image = $(event.target)
        main_image = $('.bird-photo-img .img-responsive')
        main_image.attr('src', image.data('src-small'));

        main_image_parent = main_image.parent()
        main_image_parent.attr('href', image.data('src-large'))
        main_image_parent.attr('title', image.data('description'))

        $('#photo_descr_text').text(image.data('description'));
        $('#photo_author').text(image.data('author'));
        $('#photo_date').text(image.data('date'));
        $('#photo_place').text(image.data('place'));
    });

    //Init fancybox, ref - http://fancyapps.com/fancybox/
    $("#fancybox_single_image").fancybox({
        helpers: {
            title : {
                type : 'float'
            }
        }
    });
});
