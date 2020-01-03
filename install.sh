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
apt-get install -y ca-certificates curl openssh-server
cd /tmp
curl -LO https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh
bash /tmp/script.deb.sh
apt install gitlab-ce -y
ufw allow http && ufw allow https && ufw allow OpenSSH

#gitlab-ctl reconfigure
#sudo nano /etc/gitlab/gitlab.rb      #external_url 'http://gitlab.example.com'
#Generate ssh key
#echo -en "\ny"| ssh-keygen -P ''