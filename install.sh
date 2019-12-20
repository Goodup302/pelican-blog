apt-get update -y
apt-get upgrade -y

apt-get install -y python-virtualenv python-dev python-pip
apt-get install -y pelican markdown

pip install typogrify

apt-get remove -y docker docker-engine docker.io
apt install -y docker.io
systemctl start docker
systemctl enable docker