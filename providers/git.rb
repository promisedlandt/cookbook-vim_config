def initialize *args
  super
  @action = :create
end

action :create do
  git "/etc/vim/bundle/#{ new_resource.repository.split("/").last.gsub("\.git", "") }" do
    repository new_resource.repository
    reference new_resource.reference
  end
end
