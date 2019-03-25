. .env
function install_node {
  curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
  sudo bash nodesource_setup.sh 
  sudo apt-get install -y nodejs
}
function clone_repository {
  git clone ${github_repo}
}
function install_application_dependencies {
  cd ${repo_name}
  sudo npm install node-pre-gyp -ES --unsafe-perm=true
  sudo npm i -ES --unsafe-perm=true
}
function build_webpack {
  sudo npm run build
}
configuration_server="
  server {
   server_name storeman.ga www.storeman.ga;
    location / {
      proxy_pass http://127.0.0.1:5000;
    }
  }
"
function nginx_configuration {
  sudo apt-get install nginx -y
  sudo chmod 777 /etc/nginx
  sudo rm -r /etc/nginx/sites-enabled/default
  sudo rm -r /etc/nginx/sites-available/default
  sudo echo ${configuration_server} > /etc/nginx/sites-available/${repo_name}
  sudo ln -s /etc/nginx/sites-available/${repo_name} /etc/nginx/sites-enabled/${repo_name}
  sudo service nginx start
}
function ssl_configuration {
  sudo apt-get update
  sudo apt-get install software-properties-common
  sudo add-apt-repository ppa:certbot/certbot -y
  sudo apt-get update
  sudo apt-get install certbot python-certbot-nginx -y
  sudo certbot --nginx --expand -d storeman.ga -d www.storeman.ga -m ${email} --agree-tos --non-interactive
}
start_script='
  {
    "apps": [
      {
        "name": "authors-haven",
        "script": "npm",
        "args": "start"
      }
    ]
  }
'
function process_manager {
  sudo npm install pm2 -g
  sudo echo ${start_script} > ./start_script.config.json
  pm2 start start_script.config.json
}
install_node
clone_repository
install_application_dependencies
build_webpack
nginx_configuration
ssl_configuration
process_manager
