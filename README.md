Sulu CMS Vagrant box
====
With this project, you can create a provisioned vagrant box with [Sulu CMS (sulu-minimal)](https://github.com/sulu/sulu-minimal). 
The box and the Sulu CMS are both customizable.

## The LNMP vagrant box
The project is a customized box based on the [vagrant-lnmp-box](https://github.com/sunweiye/vagrant-lnmp-box.git) project. 

The only thing that you need to do before get the box to run, is to create your box configuration file `config.box.json`
in the project root directory. Copy the appropriate configuration example file to `config.box.json` according to your
vagrant provider, and change the values in it.

For more information please refer to the [vagrant-lnmp-box document](https://github.com/sunweiye/vagrant-lnmp-box/blob/master/README.md)

To get access to the Sulu CMS, you need to set the domain and IP address in your `/etc/hosts`, like

`
192.168.100.100	    sulu.dev.box
`

The IP address is the one that you have configured in the `config.box.json`. 
 
The web service is set to be a https server with self signed certificate. After successfully provisioning of the box, the Sulu CMS is available under `https://sulu.dev.box/`. The backend is accessed
by `https://sulu.dev.box/admin` with username `admin` and password `admin`.

Everything is provisioned by the configurations in `.ansible/sulu_cms/var/sulu_dev_box`. You can change them with your wish.
