$(function () {
  $('#slider-range').slider({
    range: true,
    min: 0,
    max: 1000,
    values: [190, 728],
    slide: function (event, ui) {
      $('#amount').val('$' + ui.values[0] + ' - $' + ui.values[1]);
      var mi = ui.values[0];
      var mx = ui.values[1];
      filterSystem(mi, mx);
    },
  });
  $('#amount').val(
    '$' +
      $('#slider-range').slider('values', 0) +
      ' - $' +
      $('#slider-range').slider('values', 1)
  );
});

function filterSystem(minPrice, maxPrice) {
  $('.items div.item')
    .hide()
    .filter(function () {
      var price = parseInt($(this).data('price'), 10);
      return price >= minPrice && price <= maxPrice;
    })
    .show();
}

//   $( "#slider-range" ).on( "slidechange", function( event, ui ) {
//     console.log(ui.value);
// } );
