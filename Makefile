CC=g++
CFLAGS=-Wall -O2
IFLAGS=
LFLAGS=

DEP=.deps
DEPFLAGS=-MT $@ -MMD -MP -MF $(DEP)/$*.d

OBJ=.obj
SRC=src
SRCS=$(wildcard $(SRC)/*.cpp)
OBJS=$(patsubst $(SRC)/%.cpp, $(OBJ)/%.o, $(SRCS))

BINDIR=bin
BIN=$(BINDIR)/main


all: $(BIN)

$(BIN): $(OBJS) | $(BINDIR)
	$(CC) $(CFLAGS) $(OBJS) $(LFLAGS) -o $@

$(OBJ)/%.o: $(SRC)/%.cpp $(DEP)/%.d | $(DEP) $(OBJ)
	$(CC) $(CFLAGS) $(IFLAGS) $(DEPFLAGS) $< -c -o $@

$(DEP): ; @mkdir -p $@

$(OBJ): ; @mkdir -p $@

$(BINDIR): ; @mkdir -p $@

DEPFILES=$(patsubst $(SRC)/%.cpp, $(DEP)/%.d, $(SRCS))
$(DEPFILES):
include $(wildcard $(DEPFILES))

clean:
	rm -f $(BINDIR)/* $(OBJ)/*.o $(DEP)/*.d
