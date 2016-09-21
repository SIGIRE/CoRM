class ChangeUrLs < ActiveRecord::Migration
  # Declare a local Model to handle conflicts with future migrations
  class Account < ActiveRecord::Base
  end
  def up
    Account.where("web != ''").each do |a|
      correction = ''
      # dont start with protocol://
      if a.web[/^*:\/\//] == nil
        correction = 'http://'
        # if it is somthing like fr.website.tld
        if a.web[/^www[.]/] == nil and a.web[/^.*.[.].*.[.].*.$/] == nil
          correction += 'www.'
        end
      end
      a.web = correction + a.web
      if !correction.blank?
        logger.info(correction + ' => ' + a.web)
      end
      a.save
    end
  end
end
