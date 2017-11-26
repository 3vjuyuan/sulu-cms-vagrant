def config_vm(vm, config)
  vm.network 'private_network', ip: config['vm']['ipv4']
  vm.provider "virtualbox" do |vb|
    vb.memory = config['vm']['memory'] ? config['vm']['memory'] : "2048"
    vb.cpus = config['vm']['cpu_count'] ? config['vm']['cpu_count'] : "1"
    vb.name = "#{config['name']}@#{config['project']}"
  end
end
