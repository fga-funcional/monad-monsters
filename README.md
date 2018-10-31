## How to run the development server

Set sass to watch compile:
```shell
    $ cd front
    $ sass scss/main.scss:main.css --watch
```

To compile elm:
```shell
    $ elm make App.elm --output elm.js
```

To run haskell api:
```shell
    $ cd api
    $ runghc Main.hs
```