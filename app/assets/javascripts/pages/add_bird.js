$(function() {
    $('#datetimepicker5').datetimepicker({
        pickTime: false
    });

    $('#bird_photo').on('change', function(event) {
        var reader = new FileReader();
        reader.onload = function(file) {
            img_src = file.target.result;
            $(".bird_photo_preview").attr("src", img_src);
        }
        var photo = event.target.files[0];
        reader.readAsDataURL(photo);
    });

    $('#show_bird_timestamp').on('click', function(event) {
        $('.date_block').show();
        $('.map_block').hide();
        $('.species_block').hide();
        event.preventDefault();
    });

    $('#show_bird_map').on('click', function(event) {
        $('.date_block').hide();
        $('.map_block').show();
        $('.species_block').hide();
        event.preventDefault();
    });

    $('#show_bird_species').on('click', function(event) {
        $('.date_block').hide();
        $('.map_block').hide();
        $('.species_block').show();
        event.preventDefault();
    });

    $(document).bind("ajaxSuccess", "form#bird_edit_form", function(event, xhr, settings) {
        alert('success');
    });

    $(document).bind("ajaxError", "form#bird_edit_form", function(event, jqxhr, settings, exception) {
        alert('error');
    });
    //$("#submit_bird_timestamp").on('click', function(event){
    //    alert('click on submit_bird_timestamp');
    //    event.preventDefault();
    //    //var dataSet = $(this).serialize();
    //    $.ajax({
    //        type: "POST",
    //        url: $('.bird_edit_form').attr("action"),
    //        //data: dataSet,
    //        complete: function(){
    //            alert("Sent!");
    //        },
    //        error: function(){
    //            alert("Something went wrong!");
    //        }
    //    });
    //    return false;
    //});
});

