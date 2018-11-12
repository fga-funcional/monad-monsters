#!/bin/bash


cd ../front
sass scss/main.scss:static/main.css --watch &
cd src
../../scripts/watch.sh . elm make App.elm --output ../static/elm.js
