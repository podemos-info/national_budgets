function pseudoiframe_load_src(pseudoiframe, src=false) {
  if (src) src = pseudoiframe.attr('src', src);
  pseudoiframe.load(pseudoiframe.attr('src'), pseudoiframe.sync_src);
}

$( document ).ready(function() {
  $( '.pseudoiframe' ).sync_src = function(response, status, xhr){
                                    if(status == "success") {
                                      var original_fullpath = $(this).find("input#original_fullpath").val()
                                      $(this).attr('src', original_fullpath)
                                    }
                                  }
  $( '.pseudoiframe' )
    .on( 'click', 'a', function(e) {
      e.preventDefault();
      $(this).parents( '.pseudoiframe' )
        .load( $(this).attr('href') )
    })
    .each(function() {
      pseudoiframe_load_src($(this));
    })
});
