// Ashton Tolman
// RCET3373
// Lab8PICpt2
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

rx_byte     EQU 0x20  ; Most recently received byte
tx_byte     EQU 0x21  ; Byte waiting for transmission
rx_ready    EQU 0x22  ; Received byte ready flag
tx_pending  EQU 0x23  ; Transmit byte pending flag
 
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
    CLRF ANSELH		; Set PORTB analog pins to digital
    
    BSF 0x03, 06	;
    BCF 0x03, 5    	; Set bank 2 active
    BSF 0x09, 1		; Turn T1G-not function off
    
    BCF 0x03, 06	;
    BSF 0x03, 05	; Set bank 1 active 
    MOVLW 0b00000100	; asynchronus on with high speed,
    MOVWF TXSTA		; and 8 bit data
    MOVLW 25	
    MOVWF SPBRG		; 9600 baud at FOSC = 4 MHz
    BSF TRISC,6		; set as asynchronous serial output
    BSF TRISC,7		; set as asynchronous serial input
    BCF TRISB,0		; RB0 is an output
		    
    BCF 0x03, 06	;
    BCF 0x03, 05	; Set bank 0 active
    CLRF RCSTA		; Clear receiver/serial port settings
    BSF RCSTA,7		; SPEN = 1, enable serial port
    BCF PORTB,0		; Start diagnostic pin LOW

    ; Initialize General Purpose Registers
    BANKSEL rx_byte
    CLRF rx_byte
    CLRF tx_byte
    CLRF rx_ready
    CLRF tx_pending		 
		    
    BCF 0x03, 06	;
    BSF 0x03, 05	; Set bank 1 active 
    BSF TXSTA,5		; TXEN = 1, enable transmission
    BANKSEL RCSTA
    BSF RCSTA,4		; CREN = 1, enable reception
    goto Main
    

Main:
    CALL ServiceRx	; If there is a byte recieved, begin transmission
    CALL ProcessEcho	; Transition the read byte into byte-to-send
    CALL ServiceTx	; If byte is ready to be loaded, do so and clear flags
    goto Main		; Repeat
    
ServiceRx:
    BANKSEL PORTB	    ;Set diagnostic high then low
    BSF PORTB,0		    ;Set high
    BCF PORTB,0		    ;Set low
    
    ; Check if a byte is waiting 
    BANKSEL rx_ready	    ;If rx_ready is set, return
    BTFSC rx_ready,0	    ;If rx_ready is clear, check received byte
    RETURN
    
    ; Check for receive overrun
    BANKSEL RCSTA
    BTFSC RCSTA,1	    ; OERR = 1 when an error occurs
    goto RxOverrunService
    
    ; Check for framing error
    BANKSEL RCSTA
    BTFSC RCSTA,2	    ; FERR = 1 when an error occurs
    goto RxFramingService
    
    ; Check whether a byte was received
    BANKSEL PIR1
    BTFSS PIR1,5	    ; RCIF = 1 when data is available
    RETURN
    
    ; Read the received byte
    BANKSEL RCREG
    MOVF RCREG,W
    BANKSEL rx_byte
    MOVWF rx_byte
    
    ; Set received byte ready flag
    BSF rx_ready,0
    RETURN
    
    RxOverrunService:
    ; Recover from an overrun error
    BANKSEL RCSTA
    BCF RCSTA,4		    ; Disable receiver
    BSF RCSTA,4		    ; Enable receiver again
    RETURN
    
    RxFramingService:
    ; Discard a byte with a framing error
    BANKSEL RCREG
    MOVF RCREG,W	    ; Read to remove invalid byte
    RETURN
    
ProcessEcho:
    BANKSEL rx_ready	    
    BTFSS rx_ready,0	    ; if rx_ready is clear, return
    RETURN
    BTFSC tx_pending,0	    ; if tx_pending is set, return
    RETURN
    MOVF rx_byte,W	    ; copy rx_byte into tx_byte
    MOVWF tx_byte	    ;
    CLRF rx_ready	    ; clear rx_ready
    BSF tx_pending,0	    ; set tx_pending
    RETURN
    
ServiceTx:
    BANKSEL tx_pending	    
    BTFSS tx_pending,0	    ; if tx_pending is clear, return
    RETURN
    
    BANKSEL PIR1	    ; if the transmit buffer is not available, return
    BTFSS PIR1,4	    ; TXIF = 1 when TXREG is empty
    RETURN
    
    ; Send the stored byte
    BANKSEL tx_byte
    MOVF tx_byte,W
    BANKSEL TXREG
    MOVWF TXREG		    ; transmit tx_byte

    ; Clear transmit pending flag
    BANKSEL tx_pending
    CLRF tx_pending	    ; clear tx_pending
    RETURN
End