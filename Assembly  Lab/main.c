#include <hidef.h>
#include "derivative.h"      /* derivative-specific definitions */



void MSDelay(unsigned int);
void IRQ_Enable(void);
void Enable_Interrupts(void);
void Disable_Interrupts(void);
void display7seg (void);
void count(void);
unsigned int conv7seg(unsigned int);

unsigned int cnt[4];
unsigned int seg[4];


                                                
void main(void){        
  DDRP = 0b01111111;
  DDRB = 0xFF;
  DDRH = 0x00;
  IRQ_Enable();
  Enable_Interrupts();

 


  cnt[0]= 0;
  cnt[1]= 0;
  cnt[2]= 0;
  cnt[3]= 0;
  

        
  for (;;) {
    PTP = PTP | 0b01000000;                                 
    count();
    display7seg();
  }
}


interrupt (((0x10000 - Virq)/2) - 1) void IRQ_ISR(void){
  unsigned int n;
  
  
    if (PTP >= 64){
      PTP = PTP ^ 0b01010000;
    } 
    else{
      PTP = PTP | 0b00010000;
    }
    
    display7seg();
    PTP = PTP ^ 0b00010000;

} 


void MSDelay(unsigned int t){
    unsigned int i; unsigned int j;
     for(i = 0; i < t; i++)
      for (j=0; j <4000; j++);
}



unsigned int conv7seg(unsigned int n){
    unsigned int i;
    switch(n){
      case 0:
        i = 0b0111111;
        break;
      case 1:
        i = 0b0000110;
        break;
      case 2:
        i = 0b1011011;
        break;
      case 3:
        i = 0b1001111;
        break;
      case 4:
        i = 0b1100110;
        break;
      case 5:
        i = 0b1101101;
        break;
      case 6:
        i = 0b1111101;
        break;
      case 7:
        i = 0b0000111;
        break;
      case 8:
        i = 0b1111111;
        break;
      default:
        i = 0b1101111;
        break;
    }
    return(i);
}

void display7seg(void){
      unsigned int m;
      m = 0;
      
      seg[0] = conv7seg(cnt[0]);
      seg[1] = conv7seg(cnt[1]);
      seg[2] = conv7seg(cnt[2]);
      seg[3] = conv7seg(cnt[3]);
      
      
      while(m < 20){
      PTP = PTP ^ 0x01;
      PORTB = seg[3];
      MSDelay(2);
      PTP = PTP ^ 0x03;
      PORTB = seg[2];
      MSDelay(2);
      PTP = PTP ^ 0x06;
      PORTB = seg[1];
      MSDelay(2);
      PTP = PTP ^ 0x0C;
      PORTB = seg[0];
      MSDelay(2);
      PTP = PTP ^ 0x08;
      m++;
    }
}

void count(void){
  if ((cnt [0] == 9) && (cnt[1] != 9)) {
      cnt[0] = 0;
      cnt[1]++;
    } 
    else if ((cnt[1] == 9) && (cnt[0] == 9) && (cnt[2] != 9)) {
      cnt[0] = 0;
      cnt[1] = 0;
      cnt[2]++;
    } 
    else if ((cnt[2] == 9) && (cnt[1] == 9) && (cnt[0] == 9) && (cnt[3] != 9)) {
      cnt[0] = 0;
      cnt[1] = 0;
      cnt[2] = 0;
      cnt[3]++;
    } 
    else if ((cnt[2] == 9) && (cnt[1] == 9) && (cnt[0] == 9) && (cnt[3] == 9)) {
      cnt[0] = 0;
      cnt[1] = 0;
      cnt[2] = 0;
      cnt[3] = 0;
    } 
    else {
      cnt[0]++;
    }
}

void IRQ_Enable(void){
  INTCR = 0b11000000;
}

void Enable_Interrupts(void){
    _asm CLI; 
}

void Disable_Interrupts(void){
    _asm SEI;
}