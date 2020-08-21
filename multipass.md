
## Demo

multipass is simple to install on windows, mac and linux, instructions are on the readme for this demo.

if we run the multipass command with no arguments we can see all of the available options

    multipass

multipass also provides a set of bash completions that can be installed, these
are very useful for remembering commands by pressing the tab key. The instructions for setting up auto-completions
can also be found in the accompanying readme.

lets see how simple it is to create a new VM;

    multipass launch -n dataops

I already have the Ubuntu image cached locally so the new VM is created quite
quickly. The first time you run this command, it will download the image and
take a while longer depending on your network connection.

Let&rsquo;s take a look at the details of our new VM

    multipass info dataops

You can see the default settings have provisioned a machine

next we can use `ssh` to login to the vm

    multipass shell dataops

It is often useful to share files from your guest machine with the VM, multipass provides a command for this.
First we will create a new directory containing a file to share with the VM, then mount it

    mkdir /temp/dataops
    echo "data is fun!" > /tmp/dataops/data.txt
    mutipass mount

We can check the file is available on the VM using the `exec` command

    multipass exec cat /tmp/dataops/data.txt

Notice that the directory on the VM is mounted using the same directory as your guest which makes it easy to remember.

We saw earlier that by default, multipass uses an Ubuntu 20.04 image. It&rsquo;s great to be on the bleeding edge but 20.04 is still
quite new and you might want to use Ubuntu 18.04 for compatability reasons. Lets rebuild our VM on Ubuntu 18.04 and whilst we&rsquo;re at it
increase the memory and cpu.

We can see what images are available

    multipass find

now we will delete the old VM

    multipass delete dataops
    multipass purge

Now we will create another VM, overriding the default settings

    multipass launch -n dataops-1804 -c 2 -m 2G 18.04
    multipass info
    multipass exec dataops-1804 cat /etc/lsb-release

We saw earlier how the `multipass shell` command lets us access the VM. If we want to use the `ssh` command in a standalone
way, we will need to provision the VM with our own SSH public key as an authorized key. Multipass lets you customize
the installation using [cloud-init](https://cloudinit.readthedocs.io/en/latest/)

We will use the [yq](https://mikefarah.github.io/yq) tool to create the cloud-init configuration file as it is YAML format.
yq is very useful for processing YAML on the command line and within scripts

    export SSH_PUB=$(cat ~/.ssh/id_rsa.pub)
    yq new 'ssh_authorized_keys[+]' "${SSH_PUB}" > cloud-init.yaml
    cat cloud-init.yaml

Cloud init has many other parameters such as network and user configurations. Now lets create a new VM with our SSH keys included

    multipass launch -n dataops-cloudinit --cloud-init cloud-init.yaml
    multipass info dataops-cloudinit --format yaml | yq r - "dataops-cloudinit.[*].ipv4[0]"
    ssh ubuntu@[IP]

Finally lets delete and purge all of the VMs ready for the next exercise

    multipass delete --all && multipass purge

