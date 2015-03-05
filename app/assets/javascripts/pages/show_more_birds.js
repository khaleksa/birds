$(function() {
    $('#show-more-photo').on('click', function(e) {
        var btn = this;
        btn.text = 'Подождите ...'
        $.ajax({
            url: btn.href,
            type: 'GET',
            data: { count: $(btn).data('count') },
            dataType: 'script',
            success: function(data) {
                btn.text = 'Показать еще фотографии'
            }
        });
        return false;
    });
});
