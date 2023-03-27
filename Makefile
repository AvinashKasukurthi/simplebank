postgres:
	docker run --name postgres15 -p 5434:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15.2-alpine

createdb:
	docker exec -it postgres15 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres15 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5434/simple_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5434/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5434/simple_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5434/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go 

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/avinashkasukurthi/simplebank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc test server mock