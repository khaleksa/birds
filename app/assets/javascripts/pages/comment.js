$(function() {
    $("#add-comment").on( "click", function(event) {
        event.preventDefault();
        var $this = $(this);

        form = $(this).closest('#form-add-comment')
        tag_input = $(this).parent().find('.comment-text');
        comment_text = tag_input.val();
        tag_input.val('');

        $.post(
            form.attr('action'),
            { comment: comment_text, bird: form.data('bird-id') },
            function(response) {
                if (response.success) {
                    comment_html =
                        "<div class='row comment-row'>" +
                            "<div class='col-md-1 image-holder'>" +
                                "<img src='" + form.data('user-avatar') + "' class='img-circle' />" +
                            "</div>" +
                            "<div class='col-md-10 comment-holder'>" +
                                "<p class='row-link'><a href='" +form.data('user-profile') + "'>" + form.data('user-name') + "</a></p>" +
                                "<p class='row-comment'>" + comment_text + "</p>" +
                            "</div>"
                        "</div>";
                    $this.closest('.bird-photo-comments').find('.comments-container').append($(comment_html));
                }
            }
        );
    });

    $('.delete-comment-lnk').on('click', function(event) {
        event.preventDefault();
        var $this = $(this);
        var comment_id = $this.data('id');

        $.ajax({
            url: '/comments/' + comment_id,
            type: 'DELETE',
            success: function(result) {
                $this.closest('.row .comment-row').remove();
                $('.profile-comments-count').html('[' + result['count'] + ']');
            }
        });
    });
});
