function pseudoiframe_load_src(pseudoiframe) {
  pseudoiframe.load( pseudoiframe.attr('src') );
}

$( document ).ready(function() {
  $('.pseudoiframe').on( 'click', 'a', function(e) {
    e.preventDefault();
    $(this)
      .parents('.pseudoiframe')
      .load( $(this).attr('href') );
  });
});
