(function() {
    
    corm = {
        /**
         * Create a HTMLElement
         * @param {String} localName as name of tag html|body|tr|div|span
         * @param {Object} attr is attributes of the HTML tag
         * @param {String| HTMLElement|HTMLCollection} attr.content is the content of the HTML tag
         * @param {String} attr.value is the value attribute of the HTMLElement
         * @return {HTMLElement} return <localName attr1="" attr2="">attr_content</localName>
         */
        createHTML: function(localName, attr) {
            HTML = document.createElement(localName);
            for (var key in attr) {
                if (key === 'content') {
                    /* if content is a String */
                    if (typeof(attr[key]) == 'string') {
                        HTML.appendChild(document.createTextNode(attr[key]));
                    } else { /* Else it is a HTMLElement | HTMLCollection */
                        HTML.appendChild(attr[key]);
                    }
                } else {
                    HTML.setAttribute(key, attr[key]);
                }
            }
            return HTML;
        },
        getContactsByAccount: function(account) {
          $.get('/tasks/update_contact_select/' + account, 
            function(data){
                var option; var that = document.getElementById('task_contact_id');
                that.innerHTML = '';
                
                option = corm.createHTML('option');
                that.appendChild(option);
                
                for (var i in data) {
                  option = corm.createHTML('option', {
                    value: data[i].id,
                    content: data[i].title + ' ' + data[i].forename + ' ' + data[i].surname
                  });
                  that.appendChild(option);
                }
            }
          );
          if(account != "0"){
            $(document.getElementById('task_notice')).show();
          } else{
            $(document.getElementById('task_notice')).hide();
          }
        }
    
    };
    
})();