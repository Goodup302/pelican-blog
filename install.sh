apt-get update -y
apt-get upgrade -y

#Pelican
apt-get install -y python-virtualenv python-dev python-pip
apt-get install -y pelican markdown
pip install typogrify
#Faire l'instalation des theme

#Gitlab
apt-get install -y curl openssh-server ca-certificates gitlab-ce
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
apt install gitlab-ce -y