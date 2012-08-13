from fabric.api import cd, prefix, run, sudo

def restart():
    sudo('/etc/init.d/nginx restart')
    sudo('supervisorctl reload')

def provision():
    sudo('apt-get update')
    #sudo('apt-get install -y git-core puppet')
    run('git clone https://github.com/praekelt/holodeck-deploy.git')
    with cd('holodeck-deploy'):
        sudo('puppet apply ./manifests/holodeck.pp --modulepath ./manifests/modules')
    with cd('/var/praekelt/holodeck'):
        with prefix('. ve/bin/activate'):
            sudo('holodeck syncdb')
            sudo('holodeck syncsharddbs')
            sudo('holodeck collectstatic')
    restart()
    run('rm -rf ~/holodeck-deploy')
