action :create do
  git "#{ node[:vim_config][:bundle_dir] }/#{ new_resource.repository.split("/").last.gsub("\.git", "") }" do
    repository new_resource.repository
    reference new_resource.reference
    user node[:vim_config][:owner]
    group node[:vim_config][:owner_group]
  end

  new_resource.updated_by_last_action(true)
end
