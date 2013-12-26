module VimConfig
  class MercurialPlugins
    class << self
      def repository_url_to_directory_name(repository_url)
        repository_url.split("/").last
      end
    end
  end
end
