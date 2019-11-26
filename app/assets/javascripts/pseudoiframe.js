function reset_pseudoiframe(pseudoiframe) {
  pseudoiframe.load( pseudoiframe.attr('reset-src') );
}

$( document ).ready(function() {
  $('.pseudoiframe').on( 'click', 'a', function(e) {
    e.preventDefault();
    $(this).parents('.pseudoiframe').load( $(this).attr('href') );
  });
});
