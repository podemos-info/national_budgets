function pseudoiframe_load_src(pseudoiframe) {
  pseudoiframe.load( pseudoiframe.attr('src') );
}

$( document ).ready(function() {
  $( '.pseudoiframe' )
    .on( 'click', 'a.browse_link', function(e) {
      e.preventDefault();
      $(this).parents( '.pseudoiframe' )
        .load( $(this).attr('href') )
        .attr( 'src', $(this).attr('href') );
    })
    .on( 'click', 'a.edit_link', function(e) {
      e.preventDefault();
      var edit_input = $('input[type=text]#edit.edit-'+$(this).attr('object_id'))
      edit_input
        .toggle()
        .focus()
        .select()
        .prev()
          .toggle();
      if( edit_input.is(':visible') )
        $(this).find('i').addClass('fa-undo').removeClass('fa-pencil').attr('title', 'Cancelar edición')
      else
        $(this).find('i').addClass('fa-pencil').removeClass('fa-undo').attr('title', 'Editar');
    })
    .on( 'keypress', 'input[type=text]', function(e) {
      if (e.key === 'Enter') {
        e.preventDefault();
        $(this).val( $(this).val().trim() )
        if( $(this).val().length > 0 ) {
          var action = $(this).attr('id')
          var model = $(this).attr('model')
          var title = encodeURIComponent($(this).val())
          var parent_pseudoiframe = $(this).parents('.pseudoiframe')
          if( parent_pseudoiframe.attr('src').indexOf('?') > -1 )
            var first_params_separator = '&';
          else
            var first_params_separator = '?';
          var pseudoiframe_url = parent_pseudoiframe.attr('src');
          pseudoiframe_url += first_params_separator + action + '=' + title;
          pseudoiframe_url += '&model=' + model;
          if( action == 'edit' ){
            pseudoiframe_url += '&object_id=' + parent_pseudoiframe.find('a.edit_link').attr('object_id')
          }
          parent_pseudoiframe
           .load(pseudoiframe_url)
           .attr('src', pseudoiframe_url)
        }
        else {
          alert('El título no puede estar vacío');
        }
      }
    })
    .on( 'keyup', 'input[type=text]#edit', function(e) {
      if (e.key === 'Escape')
        $(this).parents('.pseudoiframe').find('a.edit_link').click()
    })
});
