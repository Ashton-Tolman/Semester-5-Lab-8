// Ashton Tolman
// RCET3373
// Lab8PICpt1
// https://github.com/Ashton-Tolman/Semester-5-Lab-8.git
// linker code:-Wl,-presetVect=0000h,-pisrVect=0004h,-pcode=0008h

; PIC16F883 Configuration Bit Settings

; Assembly source line config statements

//; CONFIG1
  CONFIG  FOSC = XT             ; Oscillator Selection bits (XT oscillator: Crystal/resonator on RA6/OSC2/CLKOUT and RA7/OSC1/CLKIN)
  CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled and can be enabled by SWDTEN bit of the WDTCON register)
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  MCLRE = ON            ; RE3/MCLR pin function select bit (RE3/MCLR pin function is MCLR)
  CONFIG  CP = OFF              ; Code Protection bit (Program memory code protection is disabled)
  CONFIG  CPD = OFF             ; Data Code Protection bit (Data memory code protection is disabled)
  CONFIG  BOREN = OFF           ; Brown Out Reset Selection bits (BOR disabled)
  CONFIG  IESO = OFF            ; Internal External Switchover bit (Internal/External Switchover mode is disabled)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enabled bit (Fail-Safe Clock Monitor is disabled)
  CONFIG  LVP = OFF             ; Low Voltage Programming Enable bit (RB3 pin has digital I/O, HV on MCLR must be used for programming)

; CONFIG2
  CONFIG  BOR4V = BOR40V        ; Brown-out Reset Selection bit (Brown-out Reset set to 4.0V)
  CONFIG  WRT = OFF             ; Flash Program Memory Self Write Enable bits (Write protection off)

// config statements should precede project file includes.
#include <xc.inc>

W_TEMP EQU 0x70		; Temporary W register in global GR
STATUS_TEMP EQU 0x71	; Temporary Status register in global GR
 
; Reset Vector at 000h. Execution starts here after reset 
PSECT resetVect,class=CODE,delta=2
ResetVector:
    goto Setup
    
    
; Interrupt Vector at 0004h. Execution starts here after an interrupt.
PSECT isrVect,class=CODE,delta=2
InterruptVector:
    goto Main
    
; Main code section starts at 0008h. User code goes here
PSECT code,class=CODE,delta=2

Setup:
    ; add device setup here
    BSF 0x03, 06	;
    BSF 0x03, 05	; Set bank 3 active
    CLRF BAUDCTL	; Clear baud rate control settings
    BCF BAUDCTL,3	; BRG16 = 0, 8-bit baud generator
    
    BSF 0x03, 06	;
    BCF 0x03, 5    	; Set bank 2 active
    BSF 0x09, 1		; Turn T1G-not function off
    
    BCF 0x03, 06	;
    BSF 0x03, 05	; Set bank 1 active 
    MOVLW 0b00100100	;turn transmitter on, and asynchronus on with high speed,
    MOVWF TXSTA		; and 8 bit data
    MOVLW 25	
    MOVWF SPBRG		; 9600 baud at FOSC = 4 MHz
    BSF TRISC,6		;set as asynchronous serial output
    BSF TRISC,7		;set as asynchronous serial input
		    
    BCF 0x03, 06	;
    BCF 0x03, 05	; Set bank 0 active
    CLRF RCSTA		; Clear receiver/serial port settings
    BSF RCSTA,7		; SPEN = 1, enable serial port
		 
		    
    BCF 0x03, 06	;
    BSF 0x03, 05	; Set bank 1 active 
    BSF TXSTA,5		; TXEN = 1, enable transmission
    goto Main
    

Main:
    ; Check EUSART transmit buffer
    BANKSEL PIR1
    BTFSS PIR1,4     ; TXIF = 1 when TXREG is empty
    goto $-1
    ; Send ASCII '$'
    BANKSEL TXREG
    MOVLW 0x55
    MOVWF TXREG
    goto Main
End