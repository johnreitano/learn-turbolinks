#!/usr/bin/env bash

if [[ "$1" = "without-turbolinks" ]]; then
  APP_NAME="demo-code-without-turbolinks"
  RAILS_OPTION="--skip-turbolinks"
  PORT=4000
elif [[ "$1" = "with-turbolinks" ]]; then
  APP_NAME="demo-code-with-turbolinks"
  RAILS_OPTION=""
  PORT=4100
else
  echo "parameter must be 'without-turbolinks' or 'with-turbolinks'"
  exit 1
fi

rails new $APP_NAME $RAILS_OPTION
cd $APP_NAME

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
    sleep(1)
  end

  def dogs
    sleep(1)
  end

  def puppies
    sleep(1)
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
