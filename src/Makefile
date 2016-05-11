CC ?= gcc
RM ?= rm -rf

CFLAGS += -Os -std=c99 -D_BSD_SOURCE
# CFLAGS += -D_DEBUG_IN_OUT_
CFLAGS += -Wall $(shell pkg-config --cflags libusb-1.0)/..
LDFLAGS += $(shell pkg-config --libs-only-other --libs-only-L libusb-1.0)
LIBS += $(shell pkg-config --libs-only-l libusb-1.0) -lpthread -lm

SRC= up3dload.c 
SRC+=up3d.c 
SRC+=up3dcomm.c 
SRC+=up3ddata.c 

OBJ=$(subst .c,.o,$(SRC))

all: up3dload

up3dload: $(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o up3dload $(OBJ) $(LIBS)

clean:
	$(RM) $(OBJ)
	$(RM) up3dload

dist-clean: clean
