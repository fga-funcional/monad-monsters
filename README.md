## How to run the development server

Set sass to watch compile:
```shell
    $ cd front
    $ sass scss/main.scss:static/main.css --watch
```

To run elm compile watcher:
```shell
    $ cd scripts
    $ ./run-elm.sh
```

To run haskell api:
```shell
    $ cd api
    $ runghc Main.hs
```