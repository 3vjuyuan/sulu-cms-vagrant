# -*- mode: ruby -*-
# vi: set ft=ruby :

require "json"
require "fileutils"
require "digest/md5"
require 'time'

# define deep merge for two hash map
def deep_merge!(target, data)
  merger = proc{|key, v1, v2|
    Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
  target.merge! data, &merger
end

def createVagrantLink()
    FileUtils.rm_rf("./.vagrant")
    projectHomePath = ENV["HOME"]+"/projects/" + File.basename(File.expand_path("..", Dir.pwd)) + '_' + Digest::MD5.hexdigest(Dir.pwd + Time.now.utc.iso8601)[rand(22), 10] + "/.vagrant"
    if !File.directory?(projectHomePath)
        FileUtils.mkpath projectHomePath
    end
    FileUtils.ln_s projectHomePath, ".vagrant"
end

# Load configuration from extenal JSON file
config_data = Hash.new
begin
  deep_merge!(config_data, JSON.parse(File.read(File.join(Dir.pwd, "config.box.json"), encoding:'utf-8')))
rescue Errno::ENOENT
  puts "The configuration file 'config.box.json' under #{Dir.pwd} can not be found. The default configuration and provider will be used. For more details please see the README of the project."
  config_data = {
    "provider" => "virtualbox",
    "box" => {"name" => "ubuntu/xenial64"}
  }
end

if not config_data['provider']
  abort("The provider is not specified. You must set it in the config.box.json")
end

if config_data['provider'] == "vsphere"
  required_plugins = %w(vagrant-triggers vagrant-vsphere)
  required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin} && vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
  end

  if !File.symlink?("./.vagrant")
    createVagrantLink
  end
end

Vagrant.configure(2) do |config|
  if config_data['box'] && config_data['box']['name']
    config.vm.box = config_data['box']['name']
  else
    config.vm.box = "ubuntu/xenial64"
  end

  if config_data['box'] && config_data['box']['url']
    config.vm.box_url = config_data['box']['url']
  end

  config.vm.synced_folder '.', '/vagrant', disabled: true

  require_relative "./providers/#{config_data['provider']}.rb"
  config_vm(config.vm, config_data)

  config.vm.provision "ansible" do |ansible|
    if config_data['provision'] && config_data['provision']['tags'].any?
      ansible.tags = config_data['provision']['tags']
    end
    ansible.config_file = ".ansible/ansible.cfg"
    ansible.playbook = ".ansible/lnmp.yml"
  end
end
