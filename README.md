# lime_docker
Docker container for [LIME](https://github.com/cirsfid-unibo/lime).

### Instructions: 
* First, get all the files in a folder (either git clone or download the zip)
* Modify services>lime>envirnoment>NODE: in `lime.yml` so it points to your server's URL; if you are running it locally, use `http://localhost:9006` 
* `cd` to the folder and run `docker build $(pwd) -t lime`
* Once the build process is complete, run `docker-compose -f lime.yml up`
* LIME will be available in `localhost:8008` 

### Tested with:
#### Ubuntu 16.04 && 14.04
* Docker version 1.13.1
* docker-compose version 1.8.0

#### Docker Toolbox on Windows 7
* Be sure to checkout without forcing CRLF (e.g. ` git clone ... core.autocrlf false`)
  * You can also use dos2unix in the Docker Quickstart Terminal to revert the CRLF 
* If you make changes to any file (such as `config.lime.json`), either
  * Use vim from the Docker Quickstart Terminal
  * Use notepad (or other Windows based tool) then dos2unix in the Docker Quickstart Terminal to revert the CRLF
* `localhost` will not work if using Docker Toolbox. Instead, you should use `192.168.99.100` both in `config.lime.json` and in the browser.

#### Docker for Windows
Untested, but I expect it to work. If you can confirm this, please tell me.
