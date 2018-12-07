mongo:
	docker run --name mongo_resource_server -p 27017:27017 -d mongo

start:
	iex -S mix