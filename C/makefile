SRC_FILE = main.c
OUTPUT_NAME = program

$(OUTPUT_NAME): $(SRC_FILE)
	gcc $(SRC_FILE) -o $(OUTPUT_NAME)

run: $(OUTPUT_NAME)
	./$(OUTPUT_NAME)

clean:
	rm -f $(OUTPUT_NAME)