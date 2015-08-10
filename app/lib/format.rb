#this class offers differents methods to format strings in particular format

class Format

   #format string to correct URL
    def self.to_url(url)
        if !url.nil? and url.length > 0
            correction = nil
            # dont start with protocol://
            if url[/^*:\/\//] == nil
                correction = 'http://'
                # if it is somthing like lang.website.tld
                if url[/^www[.]/] == nil and url[/^.*.[.].*.[.].*.$/] == nil
                    correction.concat('www.')
                end
            end
        end
        return (!correction.nil?() ? correction.concat(url) : url)
    end
end
