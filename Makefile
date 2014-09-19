# CrazyFlie Fastblink Makefile
# Jeremy Hunt
# Christopher Buck
# 9-17-14
# ELEC 424

# Makefile to flash the provided fast_blinky program and open a GDB session for debugging purposes. 

compile:
	@echo "Nothing to compile!"

flash:
	@openocd -d0 -f interface/busblaster.cfg -f target/stm32f1x.cfg -c init -c targets -c "reset halt" -c "flash write_image erase blinky_fast.elf" -c "verify_image blinky_fast.elf" -c "reset run" -c shutdown

debug:
	@xterm -iconic -e openocd -f interface/busblaster.cfg -f target/stm32f1x.cfg -c 'init; targets; reset halt;' &
	@arm-none-eabi-gdb -ex 'target remote localhost:3333' blinky_fast.elf
	@killall openocd
