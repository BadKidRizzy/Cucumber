class WebUrlFactory
	def self.web_url_factory
 		env_type = environment_variables_values()
	  web_url = env_type_factory(env_type)
	  # p "This is the web_url value: #{web_url}"
  	return web_url
  end
end

def environment_variables_values
  # p "This is the ARGV value: #{ARGV}"
  env_type = ""
  ARGV.each do|argument|

    if argument.upcase.include? "ENV"
      env_type = argument.split('=')
      env_type = env_type[1].downcase
    end

  end
  # p "This is the env_type value: #{env_type}"
  return env_type
end

def env_type_factory(env_type)
	urls = {}
	urls = urls.merge({"stage"        => "https://stage.pathevoprep.com"})
	urls = urls.merge({"production"  => "https://www.pathevoprep.com"})
	urls = urls.merge({"test"        => "https://qaprep.pathevo.com"})

  if urls[env_type] == nil
    puts "**** The #{env_type} environment does NOT define in the code. ****" unless env_type == ''
    puts "**** Running in the QA environment by default*****"
    urls = urls["test"]
  else
    puts "**** Running the test in #{env_type.upcase} environment *****"
    urls = urls[env_type]
  end

	return urls
end
