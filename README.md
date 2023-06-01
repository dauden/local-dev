# Information

## GetCode

Repo URL:  https://github.com/dauden/local-dev

Clone code from repo.

Open local-stack.yml un-comment service which you want to run in local, and you can change your owner user and password for each service.

> ⚠️ Default just turn 3 services 
    - Postgres
    - Redis 
    - pgadmin4
> 

eg: 

```yaml
MYSQL_ROOT_PASSWORD: "admin"
MYSQL_DATABASE: "test"
```

create data directory for local stack. 

```bash
$ sh ./setup.sh
```

then deploy you local stack

```bash
$ docker stack deploy -c ./stack-mysql.yml [your_stack_name]
$ #Eg: docker stack deploy -c ./stack-mysql.yml LOCAL_DEV
```

DONE: 

PGAdmin4 work on port: 8081, at [http://localhost:8081](http://localhost:8081/)

Redis work on port: 6379

Postgres work on port: 5432

# References

https://docs.docker.com/engine/reference/commandline/stack/