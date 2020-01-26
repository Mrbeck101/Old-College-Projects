       ; export symbols
            XDEF Entry, _Startup            ; export 'Entry' symbol
            ABSENTRY Entry        ; for absolute assembly: mark this as application entry point




ROMStart:  		  EQU  $4000  

; variable data goes in RAM
            ORG $1000    
c: DC.W 2

; code section
            ORG   ROMStart            

Num: DC.B %01100111,%01111111,%01100000,%01101111,%01100111
     DC.B %01111111,%01101111,%01100111,%01100111,%01101111

count_1s: LDX #$0
          LDX #$0

          Shift:LSLA
                BCS Add1
          
          
          Comp: INX
                TFR X, B
                SUBB #$8
                BEQ Leave
                BRA Shift
          
          Leave:LDX $2000
                INX 
                RTS 
                   
          Add1: INY
                STY c
                BRA Comp
 
Entry:
_Startup:


  LDY #0
  LDX #$4000
  

  
  Loop: LDAA $0,X
        STX $2000
        JSR count_1s
        STD $2020
        TFR X, D
        SUBD #$400A
        BEQ Done
        LDD $2020
        BRA Loop
        
  
  Done: LDAA c
        NOP 
   
   
