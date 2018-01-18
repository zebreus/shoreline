CC=gcc
CCFLAGS=-O3 -Wall -ggdb
RM=rm -f

all: clean shoreline

shoreline:
	$(CC) $(CCFLAGS) ring.c llist.c framebuffer.c sdl.c network.c main.c -lpthread `pkg-config --libs --cflags sdl2` -D_GNU_SOURCE -o shoreline

clean:
	$(RM) shoreline
