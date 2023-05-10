#line 1 "F:/MP Lab tutorials/YouTube/Tutorial pic16/MikroC/Final/Temperature/MyProject.c"



sbit LCD_RS at RB5_bit;
sbit LCD_EN at RB4_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB5_bit;
sbit LCD_EN_Direction at TRISB4_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;


sbit GAS at RC0_bit;
sbit LED at RC1_bit;
sbit LED2 at RC5_bit;
sbit SPEAKER at RC2_bit;
sbit FAN at RC3_bit;
sbit FLAME at RC4_bit;

int gas_value;
char text[10];
int voltage, current, power;

unsigned char Check, T_byte1, T_byte2,
 RH_byte1, RH_byte2, Ch ;
 unsigned Temp, RH, Sum ;
 unsigned char _data = 0x1E;


void StartSignal(){
 TRISD.RD7 = 0;
 PORTD.RD7 = 0;
 delay_ms(18);
 PORTD.RD7 = 1;
 delay_us(30);
 TRISD.RD7 = 1;
 }

 void CheckResponse(){
 Check = 0;
 delay_us(40);
 if (PORTD.RD7 == 0){
 delay_us(80);
 if (PORTD.RD7 == 1) Check = 1; delay_us(40);}
 }
char ReadData(){
 char i, j;
 for(j = 0; j < 8; j++){
 while(!PORTD.RD7);
 delay_us(30);
 if(PORTD.RD7 == 0)
 i&= ~(1<<(7 - j));
 else {i|= (1 << (7 - j));
 while(PORTD.RD7);}
 }
 return i;
 }

void main() {

TRISC.RC1 = 0;
TRISC.RC2 = 0;
TRISC.RC3 = 0;
TRISC.RC5 = 0;
TRISD.RD7 = 0;





 TRISD=0x00;
 PORTD = 0X00;






ADCON1 = 0x0E;

TRISA.RA0 = 1;
TRISC.RC0 = 1;
TRISC.RC4 = 1;
TRISC.RC7 = 1;


ADC_Init();

Lcd_Init();
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);


Lcd_Out(1,6, "Welcome!");
Lcd_Out(2,1, "||Team Inferno||");
LED2 = 1;
Delay_ms(1000);
Lcd_Cmd(_LCD_CLEAR);

Lcd_Out(1,1, "Please Wait.... ");
Delay_ms(500);
Lcd_Cmd(_LCD_CLEAR);

 UART1_Init(9600);
 UART1_Write_text("Device Initialized");
 Delay_ms(50);

while(1){
 PORTC.RC1 = 1;
 Delay_ms(1000);
 PORTC.RC1 = 0;
 Delay_ms(1000);


StartSignal();
 CheckResponse();
 if(Check == 1){
 RH_byte1 = ReadData();
 RH_byte2 = ReadData();
 T_byte1 = ReadData();
 T_byte2 = ReadData();
 Sum = ReadData();
 if(Sum == ((RH_byte1+RH_byte2+T_byte1+T_byte2) & 0XFF)){
 Temp = T_byte1;
 RH = RH_byte1;
 Lcd_Cmd(_LCD_CLEAR);

 Lcd_Out(1, 6, "Temp: ");
 LCD_Chr(1, 12, 48 + ((Temp / 10) % 10));
 LCD_Chr(1, 13, 48 + (Temp % 10));
 Lcd_Out(2, 6, "Humid: ");

 LCD_Chr(2, 13, 48 + ((RH / 10) % 10));
 LCD_Chr(2, 14, 48 + (RH % 10));
 delay_ms(1000);


 if(Temp > 100) {

 Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1,2,"High");
Lcd_Out(2,3,"Temperature");
Delay_ms(1000);
Lcd_Cmd(_LCD_CLEAR);
}






 }
 gas_value = ADC_Read(1);
 intToStr(gas_value, Ltrim(text));

if(FLAME==1 && gas_value < 110) {

Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1,2,"No Gas");
Lcd_Out(2,2, "No Flame");

Delay_ms(1000);
Lcd_Cmd(_LCD_CLEAR);
}
if(FLAME==0 && gas_value > 110) {

Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1,4,"!!Warning!!");
Delay_ms(1000);
Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1,2, "Gas & Flame");
Lcd_Out(2,4, "Detected");
UART1_Write_text("Gas & Flame Detected \r\n");
Delay_ms(1000);
Lcd_Cmd(_LCD_CLEAR);
}
if(FLAME==0 && gas_value < 110) {

Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1,4,"!!Warning!!");
Lcd_Out(2,2, "Flame Detected");
UART1_Write_text("Flame Detected \r\n");
LED = 1;
 SPEAKER = 1;
 Delay_ms(500);
 LED= 0;
 SPEAKER = 0;
 Delay_ms(500);
 Lcd_Cmd(_LCD_CLEAR);
}
if(FLAME==1 && gas_value > 110) {

Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1,2,"!!Warning!!");


Lcd_Out(2,2, "Gas Detected");
UART1_Write_text("Gas Detected \r\n");
LED = 1;
 SPEAKER = 1;
 Delay_ms(500);
 LED= 0;
 SPEAKER = 0;
 Delay_ms(500);
 Lcd_Cmd(_LCD_CLEAR);
}


 }

 delay_ms(1000);

}

}
