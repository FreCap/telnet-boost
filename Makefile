AR=ar
AS=as
CC=gcc
CPP=cpp
CXX=g++
LD=ld
OBJCOPY = objcopy
OBJDUMP = objdump
STRIP = strip

INC_DIR = ./include
SRC_DIR = ./src
OBJ_DIR = ./obj
BIN_DIR = ./bin

DEBUG_MODE=TRUE

PKGS = 

ifdef DEBUG_MODE
DEFINES  +=
CFLAGS   += 
#LDFLAGS  += -Wl,-no_pie
else 
CFLAGS   += -O3
endif

INCLUDE  += -I $(INC_DIR)
CFLAGS   +=  -Wall #`pkg-config --cflags $(PKGS)` -L/opt/local/lib
LDFLAGS  +=-Llibs/ -lboost_system -pthread #`pkg-config --libs $(PKGS)` -lpng 
#LDFLAGS += -lgdk_imlib
CPPFLAGS += -std=c++11 
SERVER_NAME = server
CLIENT_NAME = client

SERVER_OBJS = $(OBJ_DIR)/chat_server.o     
CLIENT_OBJS = $(OBJ_DIR)/chat_client.o                   


all: directories $(BIN_DIR)/$(SERVER_NAME)\
		$(BIN_DIR)/$(CLIENT_NAME)

$(BIN_DIR)/$(SERVER_NAME): $(SERVER_OBJS)
	$(CXX) $(SERVER_OBJS) -o $(BIN_DIR)/$(SERVER_NAME) $(CFLAGS) $(CPPFLAGS) $(DEFINES) $(LDFLAGS) 


$(BIN_DIR)/$(CLIENT_NAME): $(CLIENT_OBJS)
	$(CXX) $(CLIENT_OBJS) -o $(BIN_DIR)/$(CLIENT_NAME) $(CFLAGS) $(CPPFLAGS) $(DEFINES) $(LDFLAGS) 
	
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CFLAGS) $(CPPFLAGS) $(DEFINES) $(INCLUDE) -c $< -o $@
	
	
.PHONY: directories
directories:
	mkdir -p $(OBJ_DIR)
	
clean::
	-rm $(CLIENT_OBJS) $(INC_DIR)/*.*~ $(SRC_DIR)/*.*~
	
.PHONY: clean

