CXX = g++
BIN = bin
LIB = lib
LIB_NAME = autodiff

all : gradient_descent ann gradient speed simple

gradient_descent : $(BIN) root/include/vectmath.h root/include/mor.h root/include/dor.h root/include/por.h
	$(MAKE) -C root obj obj/node.o obj/graph.o
	$(CXX) -o $(BIN)/gradient_descent $(OBJS_GRADIENT_DESCENT) $(LIBS)

ann : $(BIN) root/include/vectmath.h root/include/mor.h root/include/dor.h root/include/por.h
	$(MAKE) -C root obj obj/node.o obj/graph.o
	$(CXX) -o $(BIN)/ann $(OBJS_ANN) $(LIBS)

gradient : $(BIN) root/include/vectmath.h root/include/mor.h root/include/dor.h root/include/por.h
	$(MAKE) -C root obj obj/node.o obj/graph.o
	$(CXX) -o $(BIN)/gradient $(OBJS_GRADIENT) $(LIBS)

speed : $(BIN) root/include/vectmath.h root/include/mor.h root/include/dor.h root/include/por.h
	$(MAKE) -C root obj obj/node.o obj/graph.o
	$(CXX) -o $(BIN)/speed $(OBJS_SPEED) $(LIBS)

simple : $(BIN) root/include/mor.h root/include/dor.h root/include/por.h
	$(MAKE) -C root obj obj/node.o obj/graph.o
	$(CXX) -o $(BIN)/simple $(OBJS_SIMPLE) $(LIBS)

$(BIN) :
	if [ ! -d $(BIN) ]; then mkdir $(BIN); fi

$(LIB) :
	if [ ! -d $(LIB) ]; then mkdir $(LIB); fi

clean :
	$(MAKE) -C root clean
	if [ -d $(BIN) ]; then rm $(BIN) -r; fi

install : $(LIB)
	ar rcs $(LIB)/lib$(LIB_NAME).a root/obj/graph.o root/obj/node.o
	if [ ! -d /usr/local/include/$(LIB_NAME) ]; then sudo mkdir /usr/local/include/$(LIB_NAME); fi
	sudo cp $(LIB)/lib$(LIB_NAME).a /usr/local/lib
	sudo cp root/include/*.h /usr/local/include/$(LIB_NAME)

.PHONY : all
.PHONY : gradient_descent
.PHONY : ann
.PHONY : gradient
.PHONY : speed
.PHONY : simple
.PHONY : clean
.PHONY : install
