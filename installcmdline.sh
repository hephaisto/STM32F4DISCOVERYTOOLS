#!/bin/sh
wget https://sourcery.mentor.com/sgpp/lite/arm/portal/package9740/public/arm-none-eabi/arm-2011.09-69-arm-none-eabi-i686-pc-linux-gnu.tar.bz2
tar xvf arm-2011.09-69-arm-none-eabi-i686-pc-linux-gnu.tar.bz2
git clone git://github.com/texane/stlink.git
cd stlink
./autogen.sh
./configure
make
sudo cp 49-stlinkv*.rules /etc/udev/rules.d
sudo udevadm control --reload-rules
cd ..
wget http://www.st.com/internet/com/SOFTWARE_RESOURCES/SW_COMPONENT/FIRMWARE/stm32f4_dsp_stdperiph_lib.zip
unzip stm32f4_dsp_stdperiph_lib.zip

cp ./STM32F4xx_DSP_StdPeriph_Lib_V1.1.0/Libraries/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc_ride7/startup_stm32f40xx.s sample/
cp ./STM32F4xx_DSP_StdPeriph_Lib_V1.1.0/Project/STM32F4xx_StdPeriph_Templates/TrueSTUDIO/STM324xG_EVAL/stm32_flash.ld sample/
cp ./STM32F4xx_DSP_StdPeriph_Lib_V1.1.0/Libraries/CMSIS/Device/ST/STM32F4xx/Include/stm32f4xx.h sample/
cp ./STM32F4xx_DSP_StdPeriph_Lib_V1.1.0/Project/STM32F4xx_StdPeriph_Templates/stm32f4xx_conf.h sample/
cp ./STM32F4xx_DSP_StdPeriph_Lib_V1.1.0/Libraries/CMSIS/Device/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c sample/
