## How to run the development server

Set sass to watch compile:
```shell
    $ cd front
    $ sass scss/main.scss:static/main.css --watch
```

To compile elm:
```shell
    $ cd front/src
    $ elm make App.elm --output ../static/elm.js
```

To run haskell api:
```shell
    $ cd api
    $ runghc Main.hs
```