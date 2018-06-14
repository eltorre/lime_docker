# lime_docker
Docker container for [LIME](https://github.com/cirsfid-unibo/lime).

Put all the files in a folder, cd to that folder, edit config.lime.json to point to your server's URL, then run:

```docker build $(pwd) -t lime```

Once the build process is complete, you can run

```docker-compose -f lime.yml up```

LIME will be available in localhost:8008


Tested with:

Docker version 1.13.1, build 092cba3

docker-compose version 1.8.0
