require 'fileutils'

class Aspen

  # Aspen.run("roman numerals -s")
  # Aspen.run("roman_numerals -s")

  def self.method_missing(method, *args, &block)
    puts "Invalid command - try again."
  end

  def self.run(*args)
    @@root_name = sterilize_project_name(args[0])
    return if @@root_name == nil
    FileUtils.mkdir_p("#{@@root_name}", :verbose => true)
    FileUtils.mkdir_p("#{@@root_name}/lib/models", :verbose => true) # models go here!
    FileUtils.mkdir_p("#{@@root_name}/lib/concerns", :verbose => true) # modules go here!
    FileUtils.mkdir_p("#{@@root_name}/bin", :verbose => true)
    #FileUtils.mkdir_p("#{@@root_name}/spec", :verbose => true)
    FileUtils.mkdir_p("#{@@root_name}/config", :verbose => true)
    rspec_init
    make_files
  end

  def self.rspec_init
    current = FileUtils.pwd()
    FileUtils.cd("#{@@root_name}")
    system('rspec --init')
    FileUtils.cd(current)
  end

  def self.make_files
    FileUtils.touch("#{@@root_name}/README.md") #README
    FileUtils.touch("#{@@root_name}/config/environment.rb") #environment
  end

  def self.sterilize_project_name(string)
    if string.match(/[^\w|\s|\-|.]|\d/)
      puts "Invalid project name"
    else
      string.strip.downcase.gsub(" ", "-").gsub("_", "-")
    end
  end
end