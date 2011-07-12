$(function() {
  $('#tab-links').tabs('#tabs > .tab', {
    history: true
  });

  $('.file').each(function() {
    processFile(this, $(this).attr('data-file'));
  });
});

function processFile(o, fn) {
  $(o).prepend('<img class="loading" src="loading.gif" />');
  $.ajax({
    url: 'file.php?file=' + fn,
    cache: false,
    type: 'GET',
    success: function(d) {
      $(o).html(d);
    },
    error: function(xhr, status, e) {
      $(o).html('Error updating: ' + status);
    },
    complete: function(xhr, status) {
      setTimeout(function() {
        processFile(o, fn);
      }, 10000);
    }
  });
}
