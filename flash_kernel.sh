# Tailoring the script to your particular device's recovery partition's location:
# - Compile rkflashtool by typing in a terminal: make
# - Type in the terminal the command: lsusb
# - Connect one end of the USB cable to your PC
# - Press the reset button using a paperclip, and while pressed, connect the USB cable to the OTG USB port
# - Release the reset button
# - To make sure the above steps were done right, type in a terminal: lsusb
# - You can flash if you see a new device (compare with previous lsusb) with ID: 2207:300a
# - Run the following (root) command:  sudo ./rkflashtool r 0x0 0x2000 > parm.bin
# - And then this command: cat parm.bin
# - In the output look for "(recovery)" and note well the numbers that precede it. In my case it was: ",0x00008000@0x00010000(recovery),"  (notice the @ character separating the two hex numbers)
# - Modify the flash_kernel.sh script's first line ("rkflashtool w 0x... 0x... < recovery.img) to use the two numbers above, BUT SWAPPED (first the hex number after the @, followed by the one before it). In my case that meant leaving the line as:
#       sudo ./rkflashtool w 0x10000 0x8000 < recovery.img
# - Make the script executable by typing in the terminal: chmod +x flash_kernel.sh
if [ -f recovery.img ]; 
	then
		echo "WARNING: You MUST modify this script to flash to the right address or else you WILL BRICK your device."
		read -p "Press Enter if you want to proceed, CTRL-C to exit"
		sudo ./rkflashtool w 0x10000 0x8000 < recovery.img 
		sudo ./rkflashtool b
	else
		echo "You must compile the kernel and generate a valid recovery.img to use this tool!"
fi