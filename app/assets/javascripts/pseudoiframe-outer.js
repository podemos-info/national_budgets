$( document ).ready(function() {
  function modification_type_changed( type ) {
    var current_type = $('#current_type').val();
    var sufix = (type == current_type) ? '_initial' : '_reset';
    console.log($('#section'+sufix).val());
    $('#section.pseudoiframe').load( $('#section'+sufix).val() );
    console.log($('#chapter'+sufix).val());
    $('#chapter.pseudoiframe').load( $('#chapter'+sufix).val() );

    console.log(sufix);
    if (type.indexOf('Modifications::OrganismBudget') == 0) {
      $('#standard_modification_detail').hide();
    } else {
      $('#standard_modification_detail').show();
    }
  }

  $('.form-group.type input').change( function () { modification_type_changed($(this).val()) } )

  console.log($('.form-group.type input:checked').val());
  modification_type_changed( $('.form-group.type input:checked').val() );
});

