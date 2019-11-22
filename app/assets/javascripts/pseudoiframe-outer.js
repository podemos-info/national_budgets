function is_detailed_modification( modification_type ) {
  return (JSON.parse( $('#detailed_modification_types').val() ).indexOf(modification_type) != -1)
}

function modification_type_changed( selected_modification_type ) {
  var selected_modification_type = $('#current_type').val()
  var src_attr = (selected_modification_type == current_type) ? 'initial-src' : 'reset-src'

  $('#section.pseudoiframe').load( $('#section.pseudoiframe').attr(src_attr) )
  $('#chapter.pseudoiframe').load( $('#chapter.pseudoiframe').attr(src_attr) )

  if ( is_detailed_modification(selected_modification_type) ) {
    $('#standard_modification_detail').show('fast')
  } else {
    $('#standard_modification_detail').hide('fast')
  }
}

$( document ).ready(function() {
  if ( $('.form-group.type input:checked') )
    var initial_modification_type = $('.form-group.type input:checked').val()
  else
    var initial_modification_type = $('#current_type').val()

  modification_type_changed( initial_modification_type )

  $('.form-group.type input').bind( 'change', function () { modification_type_changed($(this).val()) } )
});

