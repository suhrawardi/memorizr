var Attachment = Class.create(Unit.prototype, {
  init: function(id) {
    this.id = id;
    this.htmlId = 'attachment_' + id;
  }
});

