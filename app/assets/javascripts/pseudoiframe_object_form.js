function cancel_edition(input) {
  input.parents('.object_form').find('a.edit_link.cancel').click();
}

function validate_title(input) {
  input.val( input.val().trim() );
  if (input.val().length == 0) return 0;
  if (input.val() == input.prev().html()) return -1;
  return true;
}

function object_form_submit(form) {
  var original_fullpath = form.parents('.pseudoiframe').find('#request_original_fullpath').val();
  original_fullpath += original_fullpath.indexOf('?') > -1 ? '&' : '?';
  form
    .find('input, textarea, select')
    .not(':input[type=button], :input[type=submit], :input[type=reset]')
    .each(function() {
    original_fullpath += $(this).attr('name') + '=' + encodeURIComponent($(this).val()) + '&';
  })
  original_fullpath = original_fullpath.slice(0, -1);
  pseudoiframe_load_src(form.parents('.pseudoiframe'), original_fullpath);
}

$( document ).ready(function() {
  $( '.pseudoiframe' )
    .on( 'keypress', 'input[type=text]#object_title', function(e) {
      if (e.key === 'Enter') {
        e.preventDefault();
        switch (validate_title($(this))) {
          case 0:
            alert('El título no puede estar vacío');
            break;
          case -1:
            cancel_edition($(this));
            break;
          default:
            object_form_submit($(this).parents('.object_form'));
        }
      }
    })
    .on( 'keyup', 'input[type=text]#object_title', function(e) {
      if (e.key === 'Escape')
        cancel_edition($(this));
    })
    .on( 'click', 'div.object_form a.edit_link', function(e) {
      e.preventDefault();
      var object_form = $(this).parents('div.object_form');
      object_form.toggleClass('editing');
      if (object_form.hasClass('editing')) {
        var title_input = object_form.find('input[type=text]#object_title')
        title_input.val(title_input.prev('span').html()).focus().select();
      }
    })
    .on( 'click', 'div.object_form span', function(e) {
      $(this).parents('div.object_form').find('a.edit_link.edit').click();
    })
});
