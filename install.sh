dpkg --configure -a
apt-get update -y
apt-get upgrade -y
apt autoremove -y

#Pelican
apt-get install -y python-virtualenv python-dev python-pip
apt-get install -y pelican markdown
pip install typogrify
#instal pelican theme
git clone --recursive https://github.com/nasskach/pelican-blueidea.git ~/pelican-themes/blueidea
pelican-themes --install ~/pelican-themes/blueidea --verbose
#build pelican
cd pelican-test
make clean && make html
#start server
#rm nohup.out
#nohup sudo make serve-global &

#Gitlab
apt-get install -y curl openssh-server ca-certificates
debconf-set-selections <<< "postfix postfix/mailname string gitlab.local"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
apt-get install --assume-yes postfix
ufw allow http

curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
apt-get install gitlab-ce -y
gitlab-ctl reconfigure

#sudo gitlab-ctl restart
#ufw allow https && ufw allow OpenSSH
#Generate ssh key
#echo -en "\ny"| ssh-keygen -P ''