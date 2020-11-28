#!/usr/bin/env bash

set -x

RAILS_NEW_COMMAND="$RAILS_NEW_COMMAND rails new --skip-bundle --skip-webpack-install"
if [[ "$1" = "without-turbolinks" ]]; then
  PORT=4000
  $RAILS_NEW_COMMAND demo-code-without-turbolinks --skip-turbolinks 
  cd demo-code-without-turbolinks
elif [[ "$1" = "with-turbolinks" ]]; then
  PORT=4100
  $RAILS_NEW_COMMAND demo-code-with-turbolinks
  cd demo-code-with-turbolinks
  yarn add turbolinks-prefetch
  mkdir -p app/javascript/packs
  cat > app/javascript/packs/application.js <<"DONE"
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import TurbolinksPrefetch from 'turbolinks-prefetch';
TurbolinksPrefetch.start();

DONE
else
  echo "Usage: ./setup.sh <option> (where option is 'without-turbolinks' or 'with-turbolinks')"
  exit 1
fi
bundle remove tzinfo-data
bundle install
rails webpacker:install

mkdir -p app/views/pages
cat > app/views/pages/home.html.erb <<"DONE"
<h5>Home</h6>

<h1>Home</h1>

<ul>
  <li><a href="/">Home</a></li>
  <li><a href="/dogs">Dogs</a></li>
  <li><a href="/puppies">Puppies</a></li>
</ul>

DONE

cat > app/views/pages/dogs.html.erb <<"DONE"
<h5>Home > Dogs</h6>

<h1>Dogs</h1>

<ul>
  <li><a href="/">Home</a></li>
  <li><a href="/dogs">Dogs</a></li>
  <li><a href="/puppies">Puppies</a></li>
</ul>

DONE

cat > app/views/pages/puppies.html.erb <<"DONE"
<h5>Home > Dogs > Puppies</h6>

<h1>Puppies</h1>

<ul>
  <li><a href="/">Home</a></li>
  <li><a href="/dogs">Dogs</a></li>
  <li><a href="/puppies">Puppies</a></li>
</ul>

DONE



cat > app/controllers/pages_controller.rb <<"DONE"
class PagesController < ApplicationController
  def home
    sleep(0.5)
  end

  def dogs
    sleep(0.5)
  end

  def puppies
    sleep(0.5)
  end
end

DONE

cat > config/routes.rb <<"DONE"
Rails.application.routes.draw do
  get 'home' => 'pages#home'
  get 'dogs' => 'pages#dogs'
  get 'puppies' => 'pages#puppies'
  root 'pages#home'
end

DONE

rails server -p $PORT -b 0.0.0.0
