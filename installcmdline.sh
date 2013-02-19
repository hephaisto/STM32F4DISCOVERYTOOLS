#!/bin/sh
wget -c https://sourcery.mentor.com/sgpp/lite/arm/portal/package9740/public/arm-none-eabi/arm-2011.09-69-arm-none-eabi-i686-pc-linux-gnu.tar.bz2
tar xvf arm-2011.09-69-arm-none-eabi-i686-pc-linux-gnu.tar.bz2
git clone git://github.com/texane/stlink.git
cd stlink
./autogen.sh
./configure
make
sudo cp 49-stlinkv*.rules /etc/udev/rules.d
sudo udevadm control --reload-rules
cd ..
wget -c http://www.st.com/st-web-ui/static/active/en/st_prod_software_internet/resource/technical/software/firmware/stsw-stm32068.zip
unzip stsw-stm32068.zip

cp ./STM32F4-Discovery_FW_V1.1.0/Libraries/CMSIS/ST/STM32F4xx/Source/Templates/gcc_ride7/startup_stm32f4xx.s sample/
cp ./STM32F4-Discovery_FW_V1.1.0/Libraries/CMSIS/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c sample/
cp ./STM32F4-Discovery_FW_V1.1.0/Project/Demonstration/TrueSTUDIO/STM32F4-Discovery_Demo/stm32_flash.ld sample/
cp ./STM32F4-Discovery_FW_V1.1.0/Project/Demonstration/stm32f4xx_conf.h sample/

echo DISCOVERYPATH="`pwd`" >> ~/.profile
echo 'export DISCOVERYPATH' >> ~/.profile
