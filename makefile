
CC= gcc -Wall
HEADER_FILES_DIR = #./headerfiles
INCLUDES = -I $(HEADER_FILES_DIR)
MAIN= ejecutable
SRCS = $(filter-out lex.yy.c, $(wildcard *.c))
DEPS = $(HEADER_FILES_DIR)/$(wildcard *.h)
OBJS = $(SRCS:.c=.o) 
LIBS = -lfl
FLEXP = flex expresiones.l

$(MAIN): $(OBJS)
	$(CC) -o $(MAIN) $(OBJS) $(LIBS) 

%.o: %.c $(DEPS)
	$(CC) -c $< $(INCLUDES)

cleanall: clean
	rm -f $(MAIN)
clean:
	rm -f *.o *~
	
