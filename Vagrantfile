Vagrant.configure(2) do |config|  
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"  
  config.ssh.insert_key = false
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"
      
  config.vm.network "forwarded_port", guest: 8787, host: 8787
  config.vm.network "forwarded_port", guest: 3001, host: 3001
  config.vm.network "forwarded_port", guest: 3000, host: 3000
    
  config.vm.provision "shell", inline: <<-SHELL
    cd /home/onesc/socialcare
    sudo wget https://raw.githubusercontent.com/shinujohn/osc-dev-linux-desktop/master/setup.sh
  SHELL
end
