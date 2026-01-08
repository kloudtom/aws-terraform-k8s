#!/bin/bash
set -e

SSH_USER=ubuntu
SSH_DIR="/home/$${SSH_USER}/.ssh"

mkdir -p "$${SSH_DIR}"
chmod 700 "$${SSH_DIR}"

cat <<'EOF' > "$${SSH_DIR}/id_rsa"
${private_key}
EOF

chmod 600 "$${SSH_DIR}/id_rsa"
chown -R "$${SSH_USER}:$${SSH_USER}" "$${SSH_DIR}"

apt update
apt install -y git python3-venv  

cd /home/ubuntu

git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray
python3 -m venv myvirtualpythonenv

source myvirtualpythonenv/bin/activate

pip3 install -r requirements.txt

cp -rfp inventory/sample inventory/mycluster

cat <<EOF > inventory/mycluster/inventory.ini
[all]
%{ for h in master_hosts ~}
${h}
%{ endfor ~}
%{ for h in worker_hosts ~}
${h}
%{ endfor ~}

[kube_control_plane]
%{ for h in master_hosts ~}
${h}
%{ endfor ~}

[etcd]
%{ for h in master_hosts ~}
${h}
%{ endfor ~}

[kube_node]
%{ for h in worker_hosts ~}
${h}
%{ endfor ~}

[calico_rr]

[k8s_cluster:children]
kube_control_plane
kube_node
EOF

ansible-playbook -i inventory/mycluster/inventory.ini cluster.yml --become
until scp -o StrictHostKeyChecking=no ubuntu@$MASTER_IP:/etc/kubernetes/admin.conf /home/$SSH_USER/.kube/config; do
    echo "Kubernetes not ready yet... retrying in 30s"
    sleep 30
done

chown $SSH_USER:$SSH_USER /home/$SSH_USER/.kube/config

chown -R ubuntu:ubuntu /home/ubuntu/kubespray
