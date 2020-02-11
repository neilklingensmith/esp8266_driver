
OUTPUT=esp8266drv

CFLAGS=-Isrc/

CC=gcc
LD=ld
SIZE=size

ODIR=obj
SDIR=src

OBJS +=  \
    esp8266drv.o \

OBJ = $(patsubst %,$(ODIR)/%,$(OBJS))

$(ODIR)/%.o: $(SDIR)/%.c
	$(CC) $(CFLAGS) -c -g -o $@ $^

$(ODIR)/%.o: $(SDIR)/%.s
	nasm -f elf32 -g -o $@ $^


all: bin

bin: $(OBJ)
	$(CC)  $(CFLAGS) obj/* -o $(OUTPUT)
#	$(CC)  $(CFLAGS) obj/* --specs=nano.specs -Tsamd51g18a_flash.ld -specs=nosys.specs -L/usr/local/gcc-arm-none-eabi-9-2019-q4-major/arm-none-eabi/lib/thumb/v7e-m+fp/hard -L/usr/local/gcc-arm-none-eabi-9-2019-q4-major/lib/gcc/arm-none-eabi/9.2.1/thumb/v7e-m+fp/hard -lc -lgcc -lm -static -e Reset_Handler -o voltkey.elf
	$(SIZE) $(OUTPUT)


