#!/bin/bash

npm install gulp-cli -g

dir="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd "$dir"

# Profile theme.
cd "$dir"
cd ../web/profiles/contrib/droopler/themes/custom/droopler_theme
nvm use 12
npm install
gulp compile
git add js/* -f
git add css/* -f

# Droopler subtheme theme.
cd "$dir"
cd ../web/themes/custom/droopler_subtheme
nvm use 12
npm install
gulp compile
git add js/* -f
git add css/* -f

# AMS theme.
cd "$dir"
cd ../web/themes/custom/ams
nvm use 12
npm install
gulp compile
git add js/* -f
git add css/* -f
