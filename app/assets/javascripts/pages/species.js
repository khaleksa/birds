$(function() {
    $('#thumb_container .img-responsive').on('click', function(e) {
        alert('hi');
    });
});

jQuery(function($) {
    $('.goods-img .image_link').on('click', function() {
        $('.goods-img .image_link').removeClass('state-selected');
        $(this).addClass('state-selected');

        $('.goods-img .product_image').attr('src', $(this).data('url'));
    });
});

