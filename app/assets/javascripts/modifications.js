function is_detailed_modification( modification_type ) {
  return !modification_type || JSON.parse( $('#detailed_modification_types').val() ).indexOf(modification_type) != -1
}

function modification_type_changed( selected_modification_type ) {
  $('.pseudoiframe').each(function() {
    reset_pseudoiframe( $(this) )
  });
  $('#standard_modification_detail').toggle( is_detailed_modification(selected_modification_type) )
}

$( document ).ready(function() {
  modification_type_changed( $('.form-group.type input:checked').val() )

  $('.form-group.type input').bind( 'change', function () {
    modification_type_changed( $(this).val() )
  } )
});