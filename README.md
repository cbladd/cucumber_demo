# README #

### What is this repository for? ###

* I'm using Ruby to run the Selenium webdriver to open gmail and read a message.  I use cucumber to run the tests.  It's all containerized with Docker.  


### How do I get set up? ###

* You must have docker and docker-compose.  https://docs.docker.com/
* Clone the repo.
* cd to the repo's root directory 
* run > docker-compose up -d  
* run > docker exec -it yesmailruby_ruby_test_runner_1 /bin/bash
* run > cd data
* run > cucumber DRIVER=firefox