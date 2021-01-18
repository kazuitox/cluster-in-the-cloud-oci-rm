#!/bin/bash
ansible_branch=4

date

${custom_block}

sudo yum-config-manager --enable ol7_developer_EPEL

sudo yum install -y ansible git
sudo sh -c "cat > /root/hosts <<EOF
[management]
$(hostname -f)
EOF"

sudo mkdir /etc/ansible/facts.d/
echo "{\"csp\":\"oracle\", \"fileserver_ip\":\"${fileserver-ip}\"}" | sudo tee /etc/ansible/facts.d/citc.fact

sudo python -u /usr/bin/ansible-pull --url=https://github.com/kazuitox/slurm-ansible-playbook.git --checkout=${ansible_branch} --inventory=/root/hosts management.yml | sudo tee -a /root/ansible-pull.log

date
