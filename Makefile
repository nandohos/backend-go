postgres:
	docker run --name postgres14 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e "TZ=Europe/London" -p 5432:5432 -d postgres:14.2-alpine
createdb:
	docker exec -it postgres14 createdb --username=postgres --owner=postgres simple_bank
dropdb:
	docker exec -it postgres14 dropdb --username=postgres simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5432/simple_bank?sslmode=disable" -verbose down

.PHONY: postgres createdb dropdb migrateup migratedownt