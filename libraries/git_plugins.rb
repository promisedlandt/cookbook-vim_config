module VimConfig
  class GitPlugins
    class << self
      def repository_url_to_directory_name(repository_url)
        repository_url.split("/").last.gsub("\.git", "")
      end
    end
  end
end
