#include <stm32f4xx.h>

void delay(__IO uint32_t time)
{
	while(time--)
		;
}
int main(void)
{
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOD, ENABLE);
	GPIO_InitTypeDef  GPIO_InitStructure;
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_13;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
	GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_100MHz;
	GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
	GPIO_Init(GPIOD, &GPIO_InitStructure);

	while(1)
	{
		GPIO_SetBits(GPIOD, GPIO_Pin_13);
		delay(100000L);
		GPIO_ResetBits(GPIOD, GPIO_Pin_13);
		delay(1000000L);
	}
}
