$(document).ready(function () {
  if (!$('body').hasClass('erb')) { return false; }

  var token = $( 'meta[name="csrf-token"]' ).attr( 'content' );

  $.ajaxSetup( {
    beforeSend: function ( xhr ) {
      xhr.setRequestHeader( 'X-CSRF-Token', token );
    }
  });

  $('#logout').on('click', function (e) {
    e.preventDefault();

    $.ajax({
      url: '/users/sign_out',
      method: "DELETE",
      complete: function (resp) {
        location.href = "/";
      },
    });
  });
});
