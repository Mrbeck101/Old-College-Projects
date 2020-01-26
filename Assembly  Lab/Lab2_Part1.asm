       ; export symbols
            XDEF Entry, _Startup            ; export 'Entry' symbol
            ABSENTRY Entry        ; for absolute assembly: mark this as application entry point




ROMStart:  		  EQU  $4000  

; variable data goes in RAM
            ORG $1000    
count: DC.W 2
 

; code section
            ORG   ROMStart
text: DC.B "Hello -poWorld!"

count_letters:LDY #$4000
              LDX #1
              
              Loop2:  LDAA $0,Y
                      BEQ Exit2
                      STAA $2000
                      SUBA #$41
                      BMI Exit1
                      LDAA $2000
                      SUBA #$7A
                      BPL Exit1
                      LDAA $2000
  
                       
                      STX count
                      INX
                      INY
                      BRA Loop2
                      
              Exit1:  INY
                      BRA Loop2
                      
              Exit2:  RTS
              




Entry:
_Startup:

      JSR count_letters
      STD count
      NOP


;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector
   
