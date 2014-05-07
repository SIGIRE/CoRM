namespace :variables do

  desc "Check system variables and valorise if they don't exist"
  task :set do
    file_name = 'config/application.yml'

    # If the file doesn't exist, the script creates it
    FileUtils.touch(file_name) unless File.file?(file_name)

    # If the file is empty, returns an empty hash instead of nil
    variables = YAML.load_file(file_name) || {}

    # Creates the variables for current environment
    variables[Rails.env] ||= {}

    # Here's the variables check, and their default values
    variables[Rails.env]['CORM_SECRET_TOKEN'] ||= SecureRandom.hex(64)

    # Saving into the YAML file
    File.open(file_name, "w"){|f| YAML.dump(variables, f)}
  end

end
