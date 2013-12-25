var Note = Class.create(Unit.prototype, {
  init: function(id) {
    this.id = id;
    this.htmlId = 'note_' + id;
  }
});
