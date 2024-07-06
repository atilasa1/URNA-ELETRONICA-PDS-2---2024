# cc and flags
CC = g++
CXXFLAGS = -std=c++11 -g -Wall
#CXXFLAGS = -std=c++11 -O3 -Wall

# folders
INCLUDE_FOLDER = ./include/
BIN_FOLDER = ./bin/
OBJ_FOLDER = ./obj/
SRC_FOLDER = ./src/
DATE_FILE = data.txt

# all sources, objs, and header files
MAIN = Main
TARGET = run.out
SRC = $(wildcard $(SRC_FOLDER)*.cpp)
OBJ = $(patsubst $(SRC_FOLDER)%.cpp, $(OBJ_FOLDER)%.o, $(SRC))

# Ensure directories exist
$(OBJ_FOLDER):
	@mkdir -p $(OBJ_FOLDER)

$(BIN_FOLDER):
	@mkdir -p $(BIN_FOLDER)

# Rule to compile source files into object files
$(OBJ_FOLDER)%.o: $(SRC_FOLDER)%.cpp | $(OBJ_FOLDER)
	$(CC) $(CXXFLAGS) -c $< -o $@ -I$(INCLUDE_FOLDER)

# Rule to link object files into the final executable
all: $(OBJ) | $(BIN_FOLDER)
	$(CC) $(CXXFLAGS) -o $(BIN_FOLDER)$(TARGET) $(OBJ)
	$(MAKE) copy_data_file

# Clean rule
clean:
	@rm -rf $(OBJ_FOLDER)* $(BIN_FOLDER)*

# Rule to copy the data file
copy_data_file:
	copy $(DATE_FILE) $(BIN_FOLDER)$(DATE_FILE)
