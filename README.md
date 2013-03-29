rkflashtool_rk3066
==================

rkflashtool with RK3066 support. To backup the system and flash images from Linux.





flash_kernel tool
=================

WARNING: you MUST follow these instructions to tailor the script BEFORE executing it or you may BRICK YOUR DEVICE.
In any case, use at your own risk!


Tailoring the script to your particular device's recovery partition's location:
- Compile rkflashtool by typing in a terminal: make
- Type in the terminal the command: lsusb
- Connect one end of the USB cable to your PC
- Press the reset button using a paperclip, and while pressed, connect the USB cable to the OTG USB port
- Release the reset button
- To make sure the above steps were done right, type in a terminal: lsusb
- You can flash if you see a new device (compare with previous lsusb) with ID: 2207:300a
- Run the following (root) command:  sudo ./rkflashtool r 0x0 0x2000 > parm.bin
- And then this command: cat parm.bin
- In the output look for "(recovery)" and note well the numbers that precede it. In my case it was: ",0x00008000@0x00010000(recovery),"  (notice the @ character separating the two hex numbers)
- Modify the flash_kernel.sh script's first line ("rkflashtool w 0x... 0x... < recovery.img) to use the two numbers above, BUT SWAPPED (first the hex number after the @, followed by the one before it). In my case that meant leaving the line as: sudo ./rkflashtool w 0x10000 0x8000 < recovery.img
- Make the script executable by typing in the terminal: chmod +x flash_kernel.sh


Once you have compiled a kernel (see http://hwswbits.blogspot.com.es/2013/03/compiling-picuntu-kernel-ubuntu-linux.html) and used mkbootimg to generate a recovery.img file, these are the flashing instructions using a Linux PC (use at own risk!):

- Connect one end of the USB cable to your PC
- Press the reset button using a paperclip, and while pressed, connect the USB cable to the OTG USB port
- Release the reset button
- Run "./flash_kernel.sh" to flash the kernel to the recovery partition
- When ready, the stick will be rebooted automatically

These steps are from Omegamoon's work. You can see more at: https://github.com/omegamoon/rockchip-rk30xx-mk808