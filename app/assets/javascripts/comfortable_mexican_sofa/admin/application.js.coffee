#=require ckeditor

window.CMS.wysiwyg = ->
  return unless $('textarea[data-rich-text]').length
  CKEDITOR.plugins.basePath = '/javascripts/ckeditor/'
  CKEDITOR.basePath = '/javascripts/ckeditor/'
  CKEDITOR.replace $('textarea[data-rich-text]').get(0), 
    language: 'ru'
    contentsCss: '/javascripts/ckeditor/contents.css'
    toolbar: [
      { name: 'clipboard', groups: [ 'clipboard', 'undo' ], items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] }
      { name: 'insert', items: [ 'Image', 'Table', 'HorizontalRule', 'SpecialChar' ] }
      { name: 'styles', items: [ 'Styles', 'Format' ] }
      { name: 'others', items: [ '-' ] }
      { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Strike' ] }
      { name: 'tools', items: [ 'Maximize' ] }
      { name: 'links', items: [ 'Link', 'Unlink'] }
      { name: 'document', groups: [ 'mode', 'document', 'doctools' ], items: [ 'Source' ] }       
      { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align' ], items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote' ] }
    ]