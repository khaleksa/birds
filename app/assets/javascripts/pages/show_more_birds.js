$(function() {
    $('#new-show-more, #commentable-show-more, #unknown-show-more').on('click', 'a',  function(e) {
        var btn = this;
        btn.text = 'Подождите ...'
        $.ajax({
            url: btn.href,
            type: 'GET',
            dataType: 'script'
        });
        return false;
    });
});
