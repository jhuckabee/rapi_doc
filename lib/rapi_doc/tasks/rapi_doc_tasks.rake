desc "Generate the API Documentation"
task :rapi_doc do
  begin
    yml = YAML::load(File.open(config_file(:target)))
  rescue
    FileUtils.mkdir(config_dir)
    FileUtils.cp config_file(:template), config_dir
    FileUtils.cp index_layout_file(:template), config_dir
    FileUtils.cp resource_layout_file(:template), config_dir
    puts "Generated config/rapi_doc/config.yml." # TODO Add instructions for users to update the config file
  end

  # Generating documentations
  if yml
    resources = []
    yml.keys.each do |key|
      resources << ResourceDoc.new(key, yml[key]["location"], yml[key]["controller_name"])
    end

    # generate the apidoc
    RAPIDoc.new(resources)
  end
end

