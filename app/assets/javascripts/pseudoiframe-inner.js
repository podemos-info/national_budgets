$(".pseudoiframe a").on( "click", function(e) {
  e.preventDefault();
  $(this).parents(".pseudoiframe").load( $(this).attr("href") );
});