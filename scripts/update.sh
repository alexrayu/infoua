#!/bin/bash

dir="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd "$dir"
cd ../web

# Backup.
drush cr
drush cex sync -y
drush sql-dump > ../dumps/dump.sql

# Update.
composer update --with-dependencies
drush updb -y

# Compile assets.
cd "$dir"
cd ../web/profiles/contrib/droopler/themes/custom/droopler_theme
nvm use 12
rm -rf node_modules
npm install
gulp compile
git add js/* -f
git add css/* -f

cd "$dir"
cd ../web/themes/custom/droopler_subtheme
nvm use 12
rm -rf node_modules
npm install
gulp compile

cd "$dir"
cd ../web/themes/custom/ams
nvm use 12
rm -rf node_modules
npm install
gulp compile

# Add to git.
cd "$dir"
cd ../web
drush sql-dump > ../dumps/dump.sql
cd ..
git add .
# git commit -m "Automatic Update."
# git push origin d9

