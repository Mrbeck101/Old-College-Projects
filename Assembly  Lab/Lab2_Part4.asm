       ; export symbols
            XDEF Entry, _Startup            ; export 'Entry' symbol
            ABSENTRY Entry        ; for absolute assembly: mark this as application entry point




ROMStart:  		  EQU  $4000  

; variable data goes in RAM
          ORG $1000
b1:    DS.B 1
b2:    DS.B 1
         ORG  $4000
Entry:
_Startup:
              MOVB #$0F, b1
              MOVB #$F0, b2              

              BCLR b1,%00000101;      //clear even-number bit
              BSET b2,%11111010 ;       //set odd-number bits
              
L:            BRA L

   
      
                                                                                         




;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector
