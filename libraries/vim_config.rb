module VimConfig
  module HashToConfig
    def to_vim_config(indentation_level = 0)
      result = ""

      self.each do |key, value|
        result.add_vim_config_line(key.to_vim_config(indentation_level))
        result.add_vim_config_line(value.to_vim_config(indentation_level + 1))
      end

      result.rstrip
    end
  end
end

class String
  def add_vim_config_line(string)
    self.replace "#{ self }#{ string }\n"

    self
  end

  def to_vim_config(indentation_level = 0)
    "#{ " " * indentation_level * 2 }#{ self }"
  end
end

class Array
  def to_vim_config(indentation_level = 0)
    result = ""

    self.each do |line|
      result.add_vim_config_line(line.to_vim_config(indentation_level))
    end

    result.rstrip
  end
end

class Hash
  include VimConfig::HashToConfig
end

class Mash
  include VimConfig::HashToConfig
end
