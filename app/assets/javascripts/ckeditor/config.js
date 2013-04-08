CKEDITOR.editorConfig = function( config )
{
    config.bodyClass = 'contents';
	config.toolbar_MyToolbar =
    [
        { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
        { name: 'editing', items : [ 'Scayt' ] },
        { name: 'colors', items : [ 'TextColor', 'BGColor' ] },
        { name: 'insert', items : [ 'Image','Table','HorizontalRule','Smiley','SpecialChar' ] },
        { name: 'links', items : [ 'Link','Unlink' ] },
                '/',
        { name: 'styles', items : [ 'Font','FontSize' ] },
        { name: 'basicstyles', items : [ 'Bold','Italic','Strike','-','RemoveFormat' ] },
        { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent' ] },
        { name: 'paragraph', items : [ 'JustifyLeft','JustifyCenter','JustifyRight','-','JustifyBlock' ] }
    ];
};