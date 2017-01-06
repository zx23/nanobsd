# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

    config.vm.box = 'freebsd/FreeBSD-11.0-STABLE'
    config.vm.hostname = 'nanobsd-build'
    config.ssh.insert_key = false
    # Set shell to sh to avoid #5888 with tcsh on FreeBSD
    config.ssh.shell = "sh"

    config.vm.network :private_network, ip: '10.44.44.10'
    config.vm.synced_folder '.', '/vagrant', type: 'nfs'
    #config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git"

    # https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=201904
    config.vm.base_mac = "080027D14C66"

    config.vm.provider "virtualbox" do |vb|
        vb.customize ['modifyvm', :id, '--memory', '2048']
        vb.customize ['modifyvm', :id, '--cpus', '3']
        vb.customize ['modifyvm', :id, '--ioapic', 'on']
    end


    if (/darwin/ =~ RUBY_PLATFORM).nil?
        vmware_provider = 'vmware_fusion'
    else
        vmware_provider = 'vmware_workstation'
    end

    config.vm.provider vmware_provider do |v|
        v.vmx['memsize']  = '2048'
        v.vmx['numvcpus'] = '3'
    end

end
