# lime_docker
Docker container for [LIME](https://github.com/cirsfid-unibo/lime).

### Instructions: 
* First, get all the files in a folder (either git clone or download the zip)
* Modify `config.lime.json` so it points to your server's URL; if you are running it locally, use `localhost:9006` 
* `cd` to the folder and run `docker build $(pwd) -t lime`
* Once the build process is complete, run `docker-compose -f lime.yml up`
* LIME will be available in `localhost:8008` 

Tested with:
* Docker version 1.13.1
* docker-compose version 1.8.0

Should work using Docker for Windows. If you can confirm this, please tell me.
