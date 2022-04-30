--create users
CREATE USER freecodecamp WITH SUPERUSER;

--create databases
CREATE DATABASE worldcup;
CREATE DATABASE worldcuptest;

--create tables in worldcup
\connect worldcup
\i createTables.sql

--create tables in worldcuptest
\connect worldcuptest
\i createTables.sql

\connect postgres
