source lc-academy-env/bin/activate

# using a different model running locally
llm = ChatOpenAI(
    model="mistral:latest",  # Use the name of the model you pulled
#     openai_api_base="http://127.0.0.1:11434/v1",
#     openai_api_key="."  # An API key is required but any value will do
# )


mvn clean install \
  -DskipTests -Dgpg.skip \
  -Dmaven.compiler.fork=true \
  -Dmaven.compiler.args="--add-opens java.base/java.lang=ALL-UNNAMED"

curl http://localhost:11434/api/generate -d '{
  "model": "gpt-4o-english:latest",
  "prompt": "what is the capital of India",
  "stream": false
}' | json_pp


response=$(curl http://localhost:11434/api/generate -d '{
  "model": "gpt-oss:20b",
  "prompt": "what is the purpose of life on earth? how did it came into existence?",
  "stream": false
}')

echo $response.response

response_val=$(echo "$response" | jq -r '.response')
echo "$response_val"


# Give a system prompt to the model and ask it to generate a poem about the given topic

create a model file named ModelFileOllama

FROM chevalblanc/gpt-4o-mini
SYSTEM "You are an assistant that always responds in English. Do not use any other language unless explicitly asked."

ollama create gpt-4o-english -f Modelfile
