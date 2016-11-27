# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

    config.vm.box = 'zx23/freebsd-11.0-i386'
    config.vm.box_url = 'http://pkg.zx23.net/pub/FreeBSD/vagrant/metadata/freebsd-11-0-i386.json'
    config.vm.hostname = 'alix-build'
    config.ssh.insert_key = false

    config.vm.network :private_network, ip: '10.44.44.10'
    config.vm.synced_folder '.', '/vagrant', type: 'nfs'
    #config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git"

    config.vm.provider "virtualbox" do |vb|
        vb.customize ['modifyvm', :id, '--memory', '1024']
        vb.customize ['modifyvm', :id, '--cpus', '2']
        #vb.customize ['modifyvm', :id, '--ioapic', 'on']
    end


    if (/darwin/ =~ RUBY_PLATFORM).nil?
        vmware_provider = 'vmware_fusion'
    else
        vmware_provider = 'vmware_workstation'
    end

    config.vm.provider vmware_provider do |v|
        v.vmx['memsize']  = '1024'
        v.vmx['numvcpus'] = '3'
    end

end
