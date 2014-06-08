CKEDITOR.editorConfig = (config) ->
  config.language = 'en'
  config.height = 450
  config.toolbar = [
    ['Styles','Format','Font','FontSize','-','Bold','Italic','Underline','StrikeThrough','-','Undo','Redo','Cut','Copy','Paste','Find','Replace','-','Outdent','Indent','-','Print'],
    '/',
    ['NumberedList','BulletedList','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
    ['Table','-','Link','TextColor','BGColor','Source']
     # 'Image'
  ];