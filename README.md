# ElixirResourceServer

Resource Provider PoC done in Elixir

# Instructions

    mix deps.get
    mix compile

    export MONGO_URL="mongodb://localhost:27017/database"
    iex -S mix

    # get last 5 messages
    curl http://localhost:8080/give-me-five

    # post a new message
    curl -H 'Content-Type: application/json' \
        --request POST \
        --data '{"message": "Hello"}' \
        http://localhost:8080/save-me
