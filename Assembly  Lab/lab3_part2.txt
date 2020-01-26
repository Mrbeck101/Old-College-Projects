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
C   DS.B 2

; code section
            ORG   ROMStart


Entry:
_Startup:
            LDS   #RAMEnd+1       ; initialize the stack pointer

            
            BSET DDRB,$FF
            BSET DDRP,$0F
Begin       MOVB #1,C
            
BACK        MOVB C, PORTB
            LDD C
            SUBD #%11111111
            BEQ Begin
            INC C
            JSR Delay
            


            BRA BACK


Delay      MOVB #25,R3
L3         MOVB #100,R2
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
