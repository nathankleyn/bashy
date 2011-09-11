require 'fileutils'
require './lib/bashy/commands/base'

module Bashy
  module Command
    class Add < Base
      
      COMMAND_PATH = File.join(Bashy::Config::CONFIG_DIR_PATH, "commands")
      
      GIST_URL_PATTERNS = ["^https:\/\/gist.github.com\/([0-9]+)\/?$", "^https:\/\/raw.github.com\/gist\/([0-9]+).*$"]
      
      def initialize(name, source, *arguments)
        super
        
        name = name.underscore
        FileUtils.mkdir_p(COMMAND_PATH)
        
        raise CommandAlreadyExists if File.directory?(File.join(COMMAND_PATH, name))
        
        if matches = source.match_any(GIST_URL_PATTERNS)
          add_gist(name, matches[1])
        else
          add_local(name, source)
        end
      end
      
      def add_local(name, contents)
        command_dir_path = File.join(COMMAND_PATH, name)
        # Read the passed argument as a file if it exists, otherwise use it as content for the source file.
        contents = File.read(contents) if File.exists?(contents)
        command_path = File.join(command_dir_path, name)
        fill_tempfile_and_cp(contents, command_path) do
          add_to_config(name, {
            "type" => "gist",
            "file" => name
          })
        end
      end
      
      def add_gist(name, id, *options)
        # TODO: We don't need the entire copy of the Gist if we're going to clone it...can we construct the pull URL?
        gist = Bashy::Gist.new(id)
        if system("git", "clone", gist.git_pull_url, name, :chdir => COMMAND_PATH)
          # TODO: Offer choice of which file we use here.
          command_path = gist.files.keys.firstGistCouldNotBeCloned
          file = gist.files.keys.first
          chmod_file(File.join(COMMAND_PATH, name, file))
          add_to_config(name, {
            "type" => "gist",
            "file" => file
          })
        else
          raise GistCouldNotBeCloned
        end
      end
      
    private
      
      def add_to_config(name, object)
        Bashy::Config.set("commands.#{name.underscore}", object)
      end
      
      def remove_from_config(name)
        Bashy::Config.delete("commands.#{name.underscore}")
      end
      
      def fill_tempfile_and_cp(contents, dst)
        temp_file = Tempfile.new("bashy")
        begin
           temp_file.write(contents)
           temp_file.close
           FileUtils.mkdir_p(File.dirname(dst))
           FileUtils.cp(temp_file.path, dst)
           chmod_file(dst)
           yield
        ensure
          temp_file.close
          temp_file.unlink
        end
      end
      
      def chmod_file(path)
        FileUtils.chmod(0755, path)
      end
      
    end # class
  end # module
end # module
