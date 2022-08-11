# name of your application
APPLICATION = stm32f767zi-board-test

# If no BOARD is found in the environment, use this default:
BOARD ?= nucleo-f767zi

# This has to be the absolute path to the RIOT base directory:
RIOTBASE ?= $(CURDIR)/../RIOT/

# Uncomment these lines if you want to use platform support from external
# repositories:
#RIOTCPU ?= $(CURDIR)/../../RIOT/thirdparty_cpu
#EXTERNAL_BOARD_DIRS ?= $(CURDIR)/../../RIOT/thirdparty_boards

# Uncomment this to enable scheduler statistics for ps:
#USEMODULE += schedstatistics

# If you want to use native with valgrind, you should recompile native
# with the target all-valgrind instead of all:
# make -B clean all-valgrind

# Comment this out to disable code in RIOT that does safety checking
# which is not needed in a production environment but helps in the
# development process:
DEVELHELP ?= 1

# Change this to 0 show compiler invocation lines by default:
QUIET ?= 1

# Put the compile_commands.json in current directory
COMPILE_COMMANDS_PATH = $(CURDIR)/compile_commands.json

# Modules to include:
USEMODULE += shell
USEMODULE += shell_commands
USEMODULE += ps
# include and auto-initialize all available sensors
USEMODULE += saul_default

# redirect stdio to USB serial
USEMODULE += stdio_cdc_acm

FEATURES_REQUIRED += cpp
FEATURES_REQUIRED += libstdcpp

FEATURES_REQUIRED += periph_i2c
FEATURES_REQUIRED += periph_spi
FEATURES_REQUIRED += periph_uart

FEATURES_OPTIONAL += periph_rtc

ifneq (,$(filter msba2,$(BOARD)))
  USEMODULE += mci
  USEMODULE += random
endif

include $(RIOTBASE)/Makefile.include
