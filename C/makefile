F = main.c
OUTPUT_NAME = program

$(OUTPUT_NAME): $(F)
	gcc $(F) -o $(OUTPUT_NAME)

run: $(OUTPUT_NAME)
	./$(OUTPUT_NAME)

clean:
	rm -f $(OUTPUT_NAME)