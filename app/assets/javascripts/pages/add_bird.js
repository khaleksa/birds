$(function() {
    //*** Add bird's photo ***

    $('#set-bird-photo').on('click', function() {
        $('#bird-photo-field').trigger('click');
    })

    $('#bird-photo-field').on('change', function(event) {
        var reader = new FileReader();
        reader.onload = function(file) {
            img_src = file.target.result;
            $('#set-bird-photo-preview').attr('src', img_src);
        }
        var photo = event.target.files[0];
        reader.readAsDataURL(photo);
        $('#set-bird-photo-path').val(photo.name);
    })

    //*** Edit photo's date ***
    $('#bird-datetime-group').datetimepicker(function() {
        pickTime: false;
    })

});

