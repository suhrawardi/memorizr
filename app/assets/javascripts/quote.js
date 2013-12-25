var Quote = Class.create(Unit.prototype, {
  init: function(id) {
    this.id = id;
    this.htmlId = 'quote_' + id;
    this.mode = 'view';
  },

  getSelectedRange: function() {
    try {
      var range;
      if (document.selection) {
        range = document.selection.createRange();
      }
      else  {
        range = window.getSelection();
        if (range.rangeCount > 0) {
          range = range.getRangeAt(0);
        }
      };
      var parentNode = range.commonAncestorContainer.parentNode;
      if ($(parentNode).parents().index($('#' + this.htmlId)) == 0) {
        throw new Error('Selection is outside the quote');
      }
      return range;
    }
    catch(e) {
      if (e.name == 'Error') {
        throw new Error(e.message);
      }
      else {
        throw new Error('Selection is missing');
      }
    }
  },

  removeSelection: function() {
    try {
      range = this.getSelectedRange();
      dupRange = range.cloneContents();
      range.deleteContents();
      if (dupRange.textContent.length > 1) {
        range.insertNode(document.createTextNode(' […] '));
      }
    }
    catch (e) {
      this.handleError(e.message);
    }
  },

  highlightSelection: function() {
    try {
      range = this.getSelectedRange();
      dupRange = range.cloneContents();
      if (dupRange.childNodes.length > 1) {
        throw new Error('Way too much content selected');
      }
      if (dupRange.textContent.split(' ').length > 3) {
        throw new Error('Too many words selected');
      }
      if (dupRange.textContent.length < 1) {
        throw new Error('Nothing to highlight');
      }
      var span = document.createElement('span');
      span.setAttribute('class', 'highlight');
      range.surroundContents(span);
    }
    catch (e) {
      this.handleError(e.message);
    }
  },

  ajaxUpdate: function() {
    this.enableLinks();
    try {
      var body = $('#' + this.htmlId + ' .body').html();
      $.ajax({
        type: 'PUT',
        data: {body: body},
        url: '/quotes/' + this.id,
        error: function() {
          throw new Error('Failed to save this quote!');
        }
      });
      this.inViewMode();
      this.handleMessage('saved!');
    }
    catch (e) {
      this.handleError(e.message);
    }
  },

  inViewMode: function() {
    this.enableLinks();
    $('#' + this.htmlId + ' .menu .view').show();
    $('#' + this.htmlId + ' .menu .edit').hide();
    $('#' + this.htmlId).removeClass('in-edit-mode');
    this.mode = 'edit';
  },

  inEditMode: function() {
    this.disableLinks();
    $('#' + this.htmlId + ' .menu .view').hide();
    $('#' + this.htmlId + ' .menu .edit').show();
    $('#' + this.htmlId).addClass('in-edit-mode');
    this.mode = 'view';
  },

  enableLinks: function() {
    try {
      $('#' + this.htmlId + ' .body span.is-a-link').replaceWith(function() {
        newEl = $('<a>' + $(this).html() + '</a>');
        $(newEl).attr('href', $(this).attr('href'));
        $(newEl).attr('rel', 'nofollow');
        return $(newEl);
      });
    }
    catch (e) {
      //this.handleError(e.message);
    }
  },

  disableLinks: function() {
    try {
      $('#' + this.htmlId + ' .body a').replaceWith(function() {
        newEl = $('<span>' + $(this).html() + '</span>');
        $(newEl).attr('href', $(this).attr('href'));
        $(newEl).attr('rel', 'nofollow');
        $(newEl).addClass('is-a-link');
        return $(newEl);
      });
    }
    catch (e) {
      //this.handleError(e.message);
    }
  }
});
