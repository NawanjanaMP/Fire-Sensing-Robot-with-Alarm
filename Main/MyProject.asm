
_StartSignal:

;MyProject.c,36 :: 		void StartSignal(){
;MyProject.c,37 :: 		TRISD.RD7 = 0; //Configure RD7 as output
	BCF        TRISD+0, 7
;MyProject.c,38 :: 		PORTD.RD7 = 0; //RD0 sends 0 to the sensor
	BCF        PORTD+0, 7
;MyProject.c,39 :: 		delay_ms(18);
	MOVLW      94
	MOVWF      R12+0
	MOVLW      128
	MOVWF      R13+0
L_StartSignal0:
	DECFSZ     R13+0, 1
	GOTO       L_StartSignal0
	DECFSZ     R12+0, 1
	GOTO       L_StartSignal0
	NOP
;MyProject.c,40 :: 		PORTD.RD7 = 1; //RD0 sends 1 to the sensor
	BSF        PORTD+0, 7
;MyProject.c,41 :: 		delay_us(30);
	MOVLW      39
	MOVWF      R13+0
L_StartSignal1:
	DECFSZ     R13+0, 1
	GOTO       L_StartSignal1
	NOP
	NOP
;MyProject.c,42 :: 		TRISD.RD7 = 1; //Configure RD0 as input
	BSF        TRISD+0, 7
;MyProject.c,43 :: 		}
L_end_StartSignal:
	RETURN
; end of _StartSignal

_CheckResponse:

;MyProject.c,45 :: 		void CheckResponse(){
;MyProject.c,46 :: 		Check = 0;
	CLRF       _Check+0
;MyProject.c,47 :: 		delay_us(40);
	MOVLW      53
	MOVWF      R13+0
L_CheckResponse2:
	DECFSZ     R13+0, 1
	GOTO       L_CheckResponse2
;MyProject.c,48 :: 		if (PORTD.RD7 == 0){
	BTFSC      PORTD+0, 7
	GOTO       L_CheckResponse3
;MyProject.c,49 :: 		delay_us(80);
	MOVLW      106
	MOVWF      R13+0
L_CheckResponse4:
	DECFSZ     R13+0, 1
	GOTO       L_CheckResponse4
	NOP
;MyProject.c,50 :: 		if (PORTD.RD7 == 1) Check = 1; delay_us(40);}
	BTFSS      PORTD+0, 7
	GOTO       L_CheckResponse5
	MOVLW      1
	MOVWF      _Check+0
L_CheckResponse5:
	MOVLW      53
	MOVWF      R13+0
L_CheckResponse6:
	DECFSZ     R13+0, 1
	GOTO       L_CheckResponse6
L_CheckResponse3:
;MyProject.c,51 :: 		}
L_end_CheckResponse:
	RETURN
; end of _CheckResponse

_ReadData:

;MyProject.c,52 :: 		char ReadData(){
;MyProject.c,54 :: 		for(j = 0; j < 8; j++){
	CLRF       R3+0
L_ReadData7:
	MOVLW      8
	SUBWF      R3+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ReadData8
;MyProject.c,55 :: 		while(!PORTD.RD7); //Wait until PORTD.F0 goes HIGH
L_ReadData10:
	BTFSC      PORTD+0, 7
	GOTO       L_ReadData11
	GOTO       L_ReadData10
L_ReadData11:
;MyProject.c,56 :: 		delay_us(30);
	MOVLW      39
	MOVWF      R13+0
L_ReadData12:
	DECFSZ     R13+0, 1
	GOTO       L_ReadData12
	NOP
	NOP
;MyProject.c,57 :: 		if(PORTD.RD7 == 0)
	BTFSC      PORTD+0, 7
	GOTO       L_ReadData13
;MyProject.c,58 :: 		i&= ~(1<<(7 - j)); //Clear bit (7-b)
	MOVF       R3+0, 0
	SUBLW      7
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__ReadData56:
	BTFSC      STATUS+0, 2
	GOTO       L__ReadData57
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__ReadData56
L__ReadData57:
	COMF       R0+0, 1
	MOVF       R0+0, 0
	ANDWF      R2+0, 1
	GOTO       L_ReadData14
L_ReadData13:
;MyProject.c,59 :: 		else {i|= (1 << (7 - j)); //Set bit (7-b)
	MOVF       R3+0, 0
	SUBLW      7
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__ReadData58:
	BTFSC      STATUS+0, 2
	GOTO       L__ReadData59
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__ReadData58
L__ReadData59:
	MOVF       R0+0, 0
	IORWF      R2+0, 1
;MyProject.c,60 :: 		while(PORTD.RD7);} //Wait until PORTD.F0 goes LOW
L_ReadData15:
	BTFSS      PORTD+0, 7
	GOTO       L_ReadData16
	GOTO       L_ReadData15
L_ReadData16:
L_ReadData14:
;MyProject.c,54 :: 		for(j = 0; j < 8; j++){
	INCF       R3+0, 1
;MyProject.c,61 :: 		}
	GOTO       L_ReadData7
L_ReadData8:
;MyProject.c,62 :: 		return i;
	MOVF       R2+0, 0
	MOVWF      R0+0
;MyProject.c,63 :: 		}
L_end_ReadData:
	RETURN
; end of _ReadData

_main:

;MyProject.c,65 :: 		void main() {
;MyProject.c,67 :: 		TRISC.RC1 = 0;
	BCF        TRISC+0, 1
;MyProject.c,68 :: 		TRISC.RC2 = 0;
	BCF        TRISC+0, 2
;MyProject.c,69 :: 		TRISC.RC3 = 0;
	BCF        TRISC+0, 3
;MyProject.c,70 :: 		TRISC.RC5 = 0;
	BCF        TRISC+0, 5
;MyProject.c,71 :: 		TRISD.RD7 = 0;
	BCF        TRISD+0, 7
;MyProject.c,77 :: 		TRISD=0x00;
	CLRF       TRISD+0
;MyProject.c,78 :: 		PORTD = 0X00;
	CLRF       PORTD+0
;MyProject.c,85 :: 		ADCON1 = 0x0E;
	MOVLW      14
	MOVWF      ADCON1+0
;MyProject.c,87 :: 		TRISA.RA0 = 1;
	BSF        TRISA+0, 0
;MyProject.c,88 :: 		TRISC.RC0 = 1;
	BSF        TRISC+0, 0
;MyProject.c,89 :: 		TRISC.RC4 = 1;
	BSF        TRISC+0, 4
;MyProject.c,90 :: 		TRISC.RC7 = 1;
	BSF        TRISC+0, 7
;MyProject.c,93 :: 		ADC_Init();
	CALL       _ADC_Init+0
;MyProject.c,95 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProject.c,96 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,97 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,100 :: 		Lcd_Out(1,6, "Welcome!");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,101 :: 		Lcd_Out(2,1, "||Team Inferno||");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,102 :: 		LED2 = 1;
	BSF        RC5_bit+0, BitPos(RC5_bit+0)
;MyProject.c,103 :: 		Delay_ms(1000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main17:
	DECFSZ     R13+0, 1
	GOTO       L_main17
	DECFSZ     R12+0, 1
	GOTO       L_main17
	DECFSZ     R11+0, 1
	GOTO       L_main17
	NOP
;MyProject.c,104 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,106 :: 		Lcd_Out(1,1, "Please Wait.... ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,107 :: 		Delay_ms(500);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	DECFSZ     R11+0, 1
	GOTO       L_main18
	NOP
	NOP
;MyProject.c,108 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,110 :: 		UART1_Init(9600); // Initialize UART module at 9600 bps
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;MyProject.c,111 :: 		UART1_Write_text("Device Initialized");
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,112 :: 		Delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	DECFSZ     R11+0, 1
	GOTO       L_main19
	NOP
;MyProject.c,114 :: 		while(1){
L_main20:
;MyProject.c,115 :: 		PORTC.RC1 = 1; //LED ON
	BSF        PORTC+0, 1
;MyProject.c,116 :: 		Delay_ms(1000); //1 Second Delay
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main22:
	DECFSZ     R13+0, 1
	GOTO       L_main22
	DECFSZ     R12+0, 1
	GOTO       L_main22
	DECFSZ     R11+0, 1
	GOTO       L_main22
	NOP
;MyProject.c,117 :: 		PORTC.RC1 = 0; //LED OFF
	BCF        PORTC+0, 1
;MyProject.c,118 :: 		Delay_ms(1000); //1 Second Delay
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main23:
	DECFSZ     R13+0, 1
	GOTO       L_main23
	DECFSZ     R12+0, 1
	GOTO       L_main23
	DECFSZ     R11+0, 1
	GOTO       L_main23
	NOP
;MyProject.c,121 :: 		StartSignal();
	CALL       _StartSignal+0
;MyProject.c,122 :: 		CheckResponse();
	CALL       _CheckResponse+0
;MyProject.c,123 :: 		if(Check == 1){
	MOVF       _Check+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main24
;MyProject.c,124 :: 		RH_byte1 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _RH_byte1+0
;MyProject.c,125 :: 		RH_byte2 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _RH_byte2+0
;MyProject.c,126 :: 		T_byte1 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _T_byte1+0
;MyProject.c,127 :: 		T_byte2 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _T_byte2+0
;MyProject.c,128 :: 		Sum = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _Sum+0
	CLRF       _Sum+1
;MyProject.c,129 :: 		if(Sum == ((RH_byte1+RH_byte2+T_byte1+T_byte2) & 0XFF)){
	MOVF       _RH_byte2+0, 0
	ADDWF      _RH_byte1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       _T_byte1+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       _T_byte2+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      255
	ANDWF      R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	MOVLW      0
	ANDWF      R2+1, 1
	MOVF       _Sum+1, 0
	XORWF      R2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVF       R2+0, 0
	XORWF      _Sum+0, 0
L__main61:
	BTFSS      STATUS+0, 2
	GOTO       L_main25
;MyProject.c,130 :: 		Temp = T_byte1;
	MOVF       _T_byte1+0, 0
	MOVWF      _Temp+0
	CLRF       _Temp+1
;MyProject.c,131 :: 		RH = RH_byte1;
	MOVF       _RH_byte1+0, 0
	MOVWF      _RH+0
	CLRF       _RH+1
;MyProject.c,132 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,134 :: 		Lcd_Out(1, 6, "Temp: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,135 :: 		LCD_Chr(1, 12, 48 + ((Temp / 10) % 10));
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _Temp+0, 0
	MOVWF      R0+0
	MOVF       _Temp+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,136 :: 		LCD_Chr(1, 13, 48 + (Temp % 10));
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _Temp+0, 0
	MOVWF      R0+0
	MOVF       _Temp+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,137 :: 		Lcd_Out(2, 6, "Humid: ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,139 :: 		LCD_Chr(2, 13, 48 + ((RH / 10) % 10));
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _RH+0, 0
	MOVWF      R0+0
	MOVF       _RH+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,140 :: 		LCD_Chr(2, 14, 48 + (RH % 10));
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _RH+0, 0
	MOVWF      R0+0
	MOVF       _RH+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,141 :: 		delay_ms(1000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main26:
	DECFSZ     R13+0, 1
	GOTO       L_main26
	DECFSZ     R12+0, 1
	GOTO       L_main26
	DECFSZ     R11+0, 1
	GOTO       L_main26
	NOP
;MyProject.c,144 :: 		if(Temp > 100) {
	MOVF       _Temp+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main62
	MOVF       _Temp+0, 0
	SUBLW      100
L__main62:
	BTFSC      STATUS+0, 0
	GOTO       L_main27
;MyProject.c,146 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,147 :: 		Lcd_Out(1,2,"High");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,148 :: 		Lcd_Out(2,3,"Temperature");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,149 :: 		Delay_ms(1000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main28:
	DECFSZ     R13+0, 1
	GOTO       L_main28
	DECFSZ     R12+0, 1
	GOTO       L_main28
	DECFSZ     R11+0, 1
	GOTO       L_main28
	NOP
;MyProject.c,150 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,151 :: 		}
L_main27:
;MyProject.c,158 :: 		}
L_main25:
;MyProject.c,159 :: 		gas_value = ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _gas_value+0
	MOVF       R0+1, 0
	MOVWF      _gas_value+1
;MyProject.c,160 :: 		intToStr(gas_value, Ltrim(text));
	MOVLW      _text+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_output+0
	MOVF       _gas_value+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _gas_value+1, 0
	MOVWF      FARG_IntToStr_input+1
	CALL       _IntToStr+0
;MyProject.c,162 :: 		if(FLAME==1 && gas_value < 110) {
	BTFSS      RC4_bit+0, BitPos(RC4_bit+0)
	GOTO       L_main31
	MOVLW      128
	XORWF      _gas_value+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main63
	MOVLW      110
	SUBWF      _gas_value+0, 0
L__main63:
	BTFSC      STATUS+0, 0
	GOTO       L_main31
L__main52:
;MyProject.c,164 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,165 :: 		Lcd_Out(1,2,"No Gas");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,166 :: 		Lcd_Out(2,2, "No Flame");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,168 :: 		Delay_ms(1000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main32:
	DECFSZ     R13+0, 1
	GOTO       L_main32
	DECFSZ     R12+0, 1
	GOTO       L_main32
	DECFSZ     R11+0, 1
	GOTO       L_main32
	NOP
;MyProject.c,169 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,170 :: 		}
L_main31:
;MyProject.c,171 :: 		if(FLAME==0 && gas_value > 110) {
	BTFSC      RC4_bit+0, BitPos(RC4_bit+0)
	GOTO       L_main35
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _gas_value+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main64
	MOVF       _gas_value+0, 0
	SUBLW      110
L__main64:
	BTFSC      STATUS+0, 0
	GOTO       L_main35
L__main51:
;MyProject.c,173 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,174 :: 		Lcd_Out(1,4,"!!Warning!!");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,175 :: 		Delay_ms(1000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main36:
	DECFSZ     R13+0, 1
	GOTO       L_main36
	DECFSZ     R12+0, 1
	GOTO       L_main36
	DECFSZ     R11+0, 1
	GOTO       L_main36
	NOP
;MyProject.c,176 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,177 :: 		Lcd_Out(1,2, "Gas & Flame");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,178 :: 		Lcd_Out(2,4, "Detected");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr13_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,179 :: 		UART1_Write_text("Gas & Flame Detected \r\n");
	MOVLW      ?lstr14_MyProject+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,180 :: 		Delay_ms(1000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main37:
	DECFSZ     R13+0, 1
	GOTO       L_main37
	DECFSZ     R12+0, 1
	GOTO       L_main37
	DECFSZ     R11+0, 1
	GOTO       L_main37
	NOP
;MyProject.c,181 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,182 :: 		}
L_main35:
;MyProject.c,183 :: 		if(FLAME==0 && gas_value < 110) {
	BTFSC      RC4_bit+0, BitPos(RC4_bit+0)
	GOTO       L_main40
	MOVLW      128
	XORWF      _gas_value+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main65
	MOVLW      110
	SUBWF      _gas_value+0, 0
L__main65:
	BTFSC      STATUS+0, 0
	GOTO       L_main40
L__main50:
;MyProject.c,185 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,186 :: 		Lcd_Out(1,4,"!!Warning!!");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr15_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,187 :: 		Lcd_Out(2,2, "Flame Detected");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr16_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,188 :: 		UART1_Write_text("Flame Detected \r\n");
	MOVLW      ?lstr17_MyProject+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,189 :: 		LED = 1;
	BSF        RC1_bit+0, BitPos(RC1_bit+0)
;MyProject.c,190 :: 		SPEAKER = 1;
	BSF        RC2_bit+0, BitPos(RC2_bit+0)
;MyProject.c,191 :: 		Delay_ms(500);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main41:
	DECFSZ     R13+0, 1
	GOTO       L_main41
	DECFSZ     R12+0, 1
	GOTO       L_main41
	DECFSZ     R11+0, 1
	GOTO       L_main41
	NOP
	NOP
;MyProject.c,192 :: 		LED= 0;
	BCF        RC1_bit+0, BitPos(RC1_bit+0)
;MyProject.c,193 :: 		SPEAKER = 0;
	BCF        RC2_bit+0, BitPos(RC2_bit+0)
;MyProject.c,194 :: 		Delay_ms(500);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main42:
	DECFSZ     R13+0, 1
	GOTO       L_main42
	DECFSZ     R12+0, 1
	GOTO       L_main42
	DECFSZ     R11+0, 1
	GOTO       L_main42
	NOP
	NOP
;MyProject.c,195 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,196 :: 		}
L_main40:
;MyProject.c,197 :: 		if(FLAME==1 && gas_value > 110) {
	BTFSS      RC4_bit+0, BitPos(RC4_bit+0)
	GOTO       L_main45
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _gas_value+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main66
	MOVF       _gas_value+0, 0
	SUBLW      110
L__main66:
	BTFSC      STATUS+0, 0
	GOTO       L_main45
L__main49:
;MyProject.c,199 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,200 :: 		Lcd_Out(1,2,"!!Warning!!");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr18_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,203 :: 		Lcd_Out(2,2, "Gas Detected");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr19_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,204 :: 		UART1_Write_text("Gas Detected \r\n");
	MOVLW      ?lstr20_MyProject+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,205 :: 		LED = 1;
	BSF        RC1_bit+0, BitPos(RC1_bit+0)
;MyProject.c,206 :: 		SPEAKER = 1;
	BSF        RC2_bit+0, BitPos(RC2_bit+0)
;MyProject.c,207 :: 		Delay_ms(500);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main46:
	DECFSZ     R13+0, 1
	GOTO       L_main46
	DECFSZ     R12+0, 1
	GOTO       L_main46
	DECFSZ     R11+0, 1
	GOTO       L_main46
	NOP
	NOP
;MyProject.c,208 :: 		LED= 0;
	BCF        RC1_bit+0, BitPos(RC1_bit+0)
;MyProject.c,209 :: 		SPEAKER = 0;
	BCF        RC2_bit+0, BitPos(RC2_bit+0)
;MyProject.c,210 :: 		Delay_ms(500);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main47:
	DECFSZ     R13+0, 1
	GOTO       L_main47
	DECFSZ     R12+0, 1
	GOTO       L_main47
	DECFSZ     R11+0, 1
	GOTO       L_main47
	NOP
	NOP
;MyProject.c,211 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,212 :: 		}
L_main45:
;MyProject.c,215 :: 		}
L_main24:
;MyProject.c,217 :: 		delay_ms(1000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main48:
	DECFSZ     R13+0, 1
	GOTO       L_main48
	DECFSZ     R12+0, 1
	GOTO       L_main48
	DECFSZ     R11+0, 1
	GOTO       L_main48
	NOP
;MyProject.c,219 :: 		}
	GOTO       L_main20
;MyProject.c,221 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
