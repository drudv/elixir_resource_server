mongo:
	docker run --name mongo_resource_server -p 27017:27017 -d mongo

start: install run

run:
	iex -S mix

install:
	mix deps.get