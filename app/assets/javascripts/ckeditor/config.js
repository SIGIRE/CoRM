CKEDITOR.editorConfig = function( config )
{
   

	config.extraPlugins = 'autogrow';
	config.autoGrow_onStartup = true;
	/*config.bodyClass = 'contents';
	config.contentsCss = CKEDITOR.basePath + 'contents.css';*/
	
	config.toolbar_MyToolbar =
    [
        { name: 'colors', items : [ 'FontSize', 'TextColor', 'HorizontalRule','Smiley','SpecialChar' ] },
        { name: 'basicstyles', items : [ 'Bold','Italic','Strike','-','RemoveFormat' ] },
        { name: 'links', items : [ 'Link','Unlink' ] },
        { name: 'paragraph', items : [ 'NumberedList','BulletedList'] }
	];

};

