$(function() {
    //*** Add bird's photo ***
    $('.add-photo-container #bird_photo').on('change', function(event) {
        var reader = new FileReader();
        reader.onload = function(file) {
            img_src = file.target.result;
            $('#set-bird-photo-preview').attr('src', img_src);
        }
        var photo = event.target.files[0];
        reader.readAsDataURL(photo);
        $('#set-bird-photo-path').val(photo.name);
    })

    //*** Photo's date ***
    $('#bird-datetime-group').datetimepicker({
        locale: 'ru'
    });

    //*** Bird's species ***
    $('.add-photo-container .species-item').on('click', function(event) {
        $('#bird-species-id').val($(this).data('id'));
        $('.add-photo-container #dropdownMenu').text($(this).text());
        event.preventDefault();
    })

});

