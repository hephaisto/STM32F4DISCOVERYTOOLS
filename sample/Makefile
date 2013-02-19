# target application name
TARGET=sample

# other source files in this project
SRC=

# -l (and possible -L) directives for external libraries
LIBS=

# -I directives for external headers
INCLUDES=

# additional dependencies (mostly header files); necessary to track changes in these files
DEPS=

# StdPeriphLib libraries used in this project
# possible values are: adc can crc cryp cryp_aes cryp_des cryp_tdes dac dgbmcu dcmi dma exti flash fsmc gpio hash hash_md5 hash_sha1 i2c iwdg pwr rcc rng rtc sdio spi syscfg tim usart wwdg
# rcc is nearly always necessary to enable clocks for peripheral interfaces
# separate multiple entries by spaces
USESTDLIBS= rcc

# paths for compilers and libraries
# DISCOVERYPATH is set as environment variable
ARMPATH=$(DISCOVERYPATH)/arm-2011.09
STDLIBPATH=$(DISCOVERYPATH)/STM32F4-Discovery_FW_V1.1.0
STLINKPATH=$(DISCOVERYPATH)/stlink

# ----- DONT CHANGE CODE AFTER THIS LINE -----

MCU=cortex-m4

STDLIBSRC=$(STDLIBPATH)/Libraries/STM32F4xx_StdPeriph_Driver/src

STDLIBOBJ=$(patsubst %,stm32f4xx_%.o,$(USESTDLIBS))
OBJ=$(STDLIBOBJ)\
misc.o \
system_stm32f4xx.o \
startup_stm32f4xx.o \
$(SRC:.c=.o)

CC=$(ARMPATH)/bin/arm-none-eabi-gcc
LD=$(ARMPATH)/bin/arm-none-eabi-ld
AS=$(ARMPATH)/bin/arm-none-eabi-as
OBJCOPY=$(ARMPATH)/bin/arm-none-eabi-objcopy
STFLASH=$(STLINKPATH)/st-flash

ARMINCLUDES=-I"$(ARMPATH)/arm-none-eabi/include" -I"$(ARMPATH)/lib/gcc/arm-none-eabi/4.6.1/include" -I"$(ARMPATH)/lib/gcc/arm-none-eabi/4.6.1/include-fixed"
STDLIBINCLUDES=-I"$(STDLIBPATH)/Libraries/CMSIS/Include" -I"$(STDLIBPATH)/Libraries/CMSIS/ST/STM32F4xx/Include" -I"$(STDLIBPATH)/Libraries/STM32F4xx_StdPeriph_Driver/inc"

LIBPATHS= -L$(ARMPATH)/arm-none-eabi/lib -L$(ARMPATH)/lib/gcc/arm-none-eabi/4.6.1/thumb
LDFLAGS= -T stm32_flash.ld $(LIBPATHS) $(LIBS) $(OBJ)
COPTIONS=-D USE_STDPERIPH_DRIVER -D USE_STM32DISCOVERY -D HSE_VALUE=8000000 -D STM32F4XX -mcpu=$(MCU) -mthumb -mlittle-endian
CFLAGS=$(INCLUDES) $(ARMINCLUDES) $(STDLIBINCLUDES) $(COPTIONS) -I.


all: $(TARGET).bin

program: all
	$(STFLASH) write $(TARGET).bin 0x8000000

$(TARGET).elf: $(TARGET).o $(OBJ)
	@echo "===== linking ====="
	@$(LD) -o $@ $(TARGET).o $(LDFLAGS)

$(TARGET).hex: $(TARGET).elf
	@$(OBJCOPY) -O ihex $< $@

$(TARGET).bin: $(TARGET).elf
	@$(OBJCOPY) -O binary $< $@

%.o: %.c $(DEPS)
	@echo "===== $@ ====="
	@$(CC) $(CFLAGS) -c $< -o $@

%.o: $(STDLIBSRC)/%.c
	@echo "===== $@ ====="
	@$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
	@echo "===== $@ ====="
	@$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o *.elf *.hex *.bin

