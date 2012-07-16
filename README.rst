Holodeck Deploy
===============

Simple Fabric and Puppet scripts provisioning Holodeck on a remote host or local `Vagrant <http://http://vagrantup.com/>`_ instance.

Remote Host Fabric Deploy
-------------------------

Provisioning
++++++++++++
To provision a new Holodeck instance on a remote host run the following command with a user having superuser priviliges on the remote host:: 
    
    $ fab -H hostname:port -u user provision

After the provision access the Holodeck dashboard by hitting the hostname in your browser.

Restart
+++++++
To restart a remote Holodeck instance previously provisioned run the following command with a user having superuser priviliges on the remote host:: 
    
    $ fab -H hostname:port -u user restart

This will restart `Nginx <http://wiki.nginx.org/Main>`_ and reload `Supervisor <http://supervisord.org/>`_, thus restarting Holodeck.


Local Vagrant Deploy
--------------------
Deploy a local Vagrant instance like so::
    
    you@host$ git clone https://github.com/praekelt/holodeck-deploy.git
    you@host$ cd holodeck-deploy
    you@host$ vagrant up
    you@host$ vagrant ssh
    vagrant@precise64$ sudo su ubuntu
    ubuntu@precise64$ cd /var/praekelt/holodeck
    ubuntu@precise64$ . ve/bin/activate
    (ve)ubuntu@precise64$ holodeck syncdb
    (ve)ubuntu@precise64$ holodeck syncsharddbs
    (ve)ubuntu@precise64$ holodeck collectstatic
    (ve)ubuntu@precise64$ exit
    vagrant@precise64$ sudo -i
    root@precise64:~# /etc/init.d/nginx restart
    root@precise64:~# supervisorctl reload

Then access the Holodeck dashboard on `localhost port 4567 <http://localhost:4567/>`_.

