apt-get update -y
apt-get upgrade -y

apt-get install -y python-virtualenv python-dev python-pip
apt-get install -y nano vim pelican

pip install pelican Markdown typogrify

apt-get remove -y docker docker-engine docker.io
apt install -y docker.io
systemctl start docker
systemctl enable docker