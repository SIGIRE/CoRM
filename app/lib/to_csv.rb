require 'csv'

module ToCsv

  ##
  # Generates csv file from a list of ActiveRecord objects.

  def to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end

end
