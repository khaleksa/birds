$(function() {
    $('a.confirm-species').on('click', function(event) {
        var $this = $(this);
        event.preventDefault();
        $.post(
            '/birds/' + $this.data('id') + '/approve',
            function(response) {
                if (response.success) {
                    $this.hide();
                }
            }
        );
    });
});
