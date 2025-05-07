FROM postgres:17

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=adminPostgres
ENV POSTGRES_DB=universegames

COPY initDB.sql /docker-entrypoint-initdb.d/

EXPOSE 5432
