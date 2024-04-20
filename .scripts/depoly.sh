#!bin/bash
set -e
echo "Development started..."
git pull origin master
echo "New changes to the server !"
echo "Installing Dependencies..."
npm install --yes
echo "Creating production build"
npm run build
echo "Depolyment Finished!"
serve -s build