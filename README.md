# Information

## GetCode

Repo URL:  https://github.com/dauden/local-dev

Clone code from repo.


Run shell script and select your options to deply service in your local with docker stack.

```bash
$ sh ./setup.sh
```

If you got error with `docker swarm init` please try init swarm first.

```bash
$ docker swarm init 
```
then try again with command
```bash
$ docker stack deploy -c ./stack-mysql.yml [your_stack_name]
$ #Eg: docker stack deploy -c ./stack-mysql.yml LOCAL_DEV
```

DONE: 

Hasura work on port: 8083, at [http://localhost:8083](http://localhost:8083/)

PGAdmin4 work on port: 8081, at [http://localhost:8081](http://localhost:8081/)

Redis work on port: 6379

Postgres work on port: 5432

# References

https://docs.docker.com/engine/reference/commandline/stack/