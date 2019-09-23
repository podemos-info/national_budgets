  $( document ).ready(function() {
    $( '.pseudoiframe' ).each(function() {
      $( this ).load( $( this ).attr('src') );
    });
  });