var Unit = Class.create({
  init: function(id) {
    this.id = id;
    this.htmlId = 'unit_' + id;
  },

  handleError: function(error) {
    $('#' + this.htmlId + ' .error').html(error);
    $('#' + this.htmlId + ' .error').fadeIn('fast').fadeOut(5000);
  },

  handleMessage: function(msg) {
    $('#' + this.htmlId + ' .message').html(msg);
    $('#' + this.htmlId + ' .message').fadeIn('fast').fadeOut(5000);
  }
});
