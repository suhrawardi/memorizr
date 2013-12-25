$(document).ready(function() {
  $('.quote').each(function(i, el) {
    var unit_id = $(el).data('unit_id');
    var quote = new Quote(unit_id);
    $(el).find('a[data-action="edit"]').click(function(event) {
      quote.inEditMode();
    });
    $(el).find('a[data-action="close"]').click(function(event) {
      quote.inViewMode();
    });
    $(el).find('button[data-action="remove"]').click(function(event) {
      quote.removeSelection();
    });
    $(el).find('button[data-action="highlight"]').click(function(event) {
      quote.highlightSelection();
    });
    $(el).find('button[data-action="save"]').click(function(event) {
      quote.ajaxUpdate();
    });
  });
});
