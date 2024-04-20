#!/bin/bash
set -e
sudo -i echo "Development started..."
sudo -i git stash
sudo -i git pull origin master
sudo -i echo "New changes to the server !"
sudo -i echo "Installing Dependencies..."
sudo -i npm install --yes
sudo -i echo "Creating production build"
sudo -i npm run build
sudo -i echo "Depolyment Finished!"
