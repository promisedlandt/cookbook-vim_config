action :create do
  mercurial ::File.join(node[:vim_config][:bundle_dir], new_resource.repository.split("/").last) do
    repository new_resource.repository
    reference new_resource.reference
    owner node[:vim_config][:owner]
    group node[:vim_config][:owner_group]
    action :sync
  end

  new_resource.updated_by_last_action(true)
end
