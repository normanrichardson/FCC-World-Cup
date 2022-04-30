# [FCC World Cup Database](https://www.freecodecamp.org/learn/relational-database/build-a-world-cup-database-project/build-a-world-cup-database)

This was put together for the Relational Database (Beta) course on [FCC](https://www.freecodecamp.org/learn/relational-database/). The aim was to create, populate, and query a PostgreSQL rational database. 

## Project Improvements
I have extended this project in the following ways:
* local development with Docker

## Setup

Clone the Repository

```
$ git clone 
$ cd FCC-World-Cup
```
### Running postgres with Docker:
Using the standard postgres docker image create the container:
```
$ docker run --name=world-cup-proj \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASSWORD=1234 \
-e POSTGRES_DB=postgres \
-v "$(pwd)"/.:/home/src \
-d \
--rm \
postgres:latest
```
This will:
* launch a new container named world-cup-proj in the background (see `$ docker ps`). 
* remove the container after stopping it.
* map the `./` directory onto the container's directory `home/src`. 
The mapped files are accessible within the container and the host.

Launch psql in the world-cup-proj container and run the sql file
```
$ docker exec -it -w /home/src/sqlFiles world-cup-proj \
psql -U postgres -d postgres -f createDb.sql
```
This will set up the sql database and tables.

Run the `insert_data.sh` bash script in the world-cup-proj container
```
$ docker exec -it -w /home/src/ world-cup-proj \
./insert_data.sh
```
This will populate the worldcup database with the data in `games.csv`.

Run the `queries.sh` bash script in the world-cup-proj container
```
$ docker exec -it -w /home/src/ world-cup-proj \
./queries.sh
```
This will run queries against the information in the worldcup database.

Dump the file as required by the project description
```
$ docker exec -it -w /home/src/ world-cup-proj \
pg_dump -cC --inserts -U freecodecamp worldcup > worldcup.sql
```

Stop the container
```
docker stop world-cup-proj
```
