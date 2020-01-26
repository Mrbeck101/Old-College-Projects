;*****************************************************************
;* This stationery serves as the framework for a                 *
;* user application (single file, absolute assembly application) *
;* For a more comprehensive program that                         *
;* demonstrates the more advanced functionality of this          *
;* processor, please see the demonstration applications          *
;* located in the examples subdirectory of the                   *
;* Freescale CodeWarrior for the HC12 Program directory          *
;*****************************************************************

; export symbols
            XDEF Entry, _Startup            ; export 'Entry' symbol
            ABSENTRY Entry        ; for absolute assembly: mark this as application entry point



; Include derivative-specific definitions 
		INCLUDE 'derivative.inc' 

ROMStart    EQU  $4000  ; absolute address to place my code/constant data

; variable/data section

            ORG RAMStart
 ; Insert here your data definition.
R1  DS.B 1
R2  DS.B 1
R3  DS.B 1

; code section
            ORG   ROMStart


Entry:
_Startup:
            LDS   #RAMEnd+1       ; initialize the stack pointer

            MOVB #$FF,DDRB
            BSET DDRP,$0F
            
BACK        MOVB #$40,PORTB
            BCLR PTP,%00000001
            BSET PTP,%00001110
            
            JSR Delay_1ms
            
            MOVB #$3F,PORTB
            BCLR PTP,%00000010
            BSET PTP,%00001101
            
            JSR Delay_1ms

            MOVB #$3E,PORTB
            BCLR PTP,%00000100
            BSET PTP,%00001011
            
            JSR Delay_1ms
            
            MOVB #$40,PORTB
            BCLR PTP,%00001000
            BSET PTP,%00000111
            
            JSR Delay_1ms

            BRA BACK


Delay_1ms  MOVB #1,R3
L3         MOVB #10,R2
L2         MOVB #240,R1
L1         NOP
           NOP
           NOP
           DEC R1
           BNE L1
           DEC R2
           BNE L2
           DEC R3
           BNE L3
           RTS


;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector
