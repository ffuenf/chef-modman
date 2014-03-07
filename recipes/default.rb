# # # # # #
# modman  #
# # # # # #
src_filename = "modman"
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"
remote_file src_filepath do
	source node['modman']['url']
	owner 'root'
	group 'root'
	mode 0755
end
bash 'install modman in #{node["modman"]["install_path"]}' do
	cwd ::File.dirname(src_filepath)
	code <<-EOH
		mv #{src_filepath} #{node["modman"]["install_path"]}/#{src_filename}
		chmod +x #{node["modman"]["install_path"]}/#{src_filename}
	EOH
end