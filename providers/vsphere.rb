def config_vm(vm, config)
  vm.provider "vsphere" do |vs|
    vs.host = config['vsphere']['vcenter']
    vs.compute_resource_name = config['vsphere']['host']
    vs.data_center_name = config['vsphere']['data_center']
    vs.resource_pool_name = config['vsphere']['resource_pool']
    vs.data_store_name = config['vsphere']['storage']
    vs.template_name = config['vsphere']['template']
    vs.vm_base_path = config['vsphere']['base_path']
    vs.name = "#{config['name']}@#{config['project']}.#{vm.box}"
    vs.user = config['vsphere']['user']
    vs.password = config['vsphere']['passwd']
    vs.memory_mb = config['vm']['memory'] ? config['vm']['memory'] : "2048"
    vs.cpu_count = config['vm']['cpu_count'] ? config['vm']['cpu_count'] : "1"
    if config['vm'].has_key?('vlan')
      vs.vlan = config['vm']['vlan']
    end
    vs.insecure = true
  end
end
