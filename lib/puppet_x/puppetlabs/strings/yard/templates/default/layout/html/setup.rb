# TODO: This should be extendable. However, the re-assignment of
# @objects_by_letter prevents that. Submit a pull request.
def index
  @objects_by_letter = {}
  objects = Registry.all(:class, :module, :type, :puppetnamespace, :hostclass, :definedtype, :provider).sort_by {|o| o.name.to_s }
  objects = run_verifier(objects)
  objects.each {|o| (@objects_by_letter[o.name.to_s[0,1].upcase] ||= []) << o }
  erb(:index)
end

def menu_lists
  [
    {:type => 'puppet_manifest', :title => 'Puppet Manifests', :search_title => "Puppet Manifest List"},
    {:type => 'puppet_plugin', :title => 'Puppet Plugins', :search_title => "Puppet Plugin List"},
    {:type => 'puppet_type', :title => 'Puppet Types', :search_title => "Puppet Type List"},
    {:type => 'puppet_provider', :title => 'Puppet Providers', :search_title => "Puppet Provider List"},
  ] + super
end
