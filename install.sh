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


#Docker
apt-get remove -y docker docker-engine docker.io
apt install -y docker.io
systemctl start docker
systemctl enable docker


#Gitlab
apt-get install -y curl openssh-server ca-certificates letsencrypt
debconf-set-selections <<< "postfix postfix/mailname string gitlab.goodup302.local"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
apt-get install --assume-yes postfix
ufw allow http && ufw allow https && ufw allow OpenSSH && ufw enable

curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
apt-get install gitlab-ce -y
gitlab-ctl reconfigure


#Gitlab Runners
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
sudo apt-get install gitlab-runner
apt-cache madison gitlab-runner

docker run -d --name gitlab-runner --restart always \
  -v /srv/gitlab-runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest
docker run -d --name gitlab-runner-config \
    -v /etc/gitlab-runner \
    busybox:latest \
    /bin/true
docker run -d --name gitlab-runner --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --volumes-from gitlab-runner-config \
    gitlab/gitlab-runner:latest

gitlab-ci-multi-runner register

#letsencrypt certonly --standalone --agree-tos --no-eff-email --agree-tos --email j.f0471430704@gmail.com -d gitlab.goodup302.local
#mkdir -p /etc/gitlab/ssl/
#openssl dhparam -out /etc/gitlab/ssl/dhparams.pem 2048
#chmod 600 /etc/gitlab/ssl/*


#sudo gitlab-ctl restart
#Generate ssh key
#echo -en "\ny"| ssh-keygen -P ''
