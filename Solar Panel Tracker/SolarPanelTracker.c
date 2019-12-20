#include <hidef.h>    
#include "derivative.h"        


void PWM1_50Hz(void);
void PWM1_duty(int);
void MSDelay(unsigned int);
void dispASCII (unsigned int);
void SerCom0(unsigned char);
void PWM2_duty(int d);



void main (void){
  unsigned int tl, bl, tr, br, deg1, deg2, sens;
  unsigned int cnt;
  unsigned char line[] = "----------------------------------------------------";
  
  SCI0BDL = 0x9C; //set up serial monitor for debugging and reading photoresistor outputs
  SCI0CR1 = 0;                   
  SCI0CR2 = 0x0C;
                            
  PWM1_50Hz(); //create intial PWM signal
  
  ATD0CTL2 = 0x80; // set conditions for A0-A7
  ATD1CTL2 = 0x80; // set conditions for A8-A15  
  MSDelay(2);
  
  ATD0CTL3 = 0x30; //set to scan 6 times (A0 -A7)
  ATD1CTL3 = 0x08; //set to scan 1 time (A8-A15)
      
  ATD0CTL4 = 0xE3; 
  ATD1CTL4 = 0xE3;
                                                                                 
  
  deg1 = 900;
  deg2 = 3000;
  sens = 5; //sets sensitivity of photoresistor readings
  
  for(;;){

    ATD0CTL5 = 0x92; //start at A2 and scan multiple channels all at once (A0 - A7)
    ATD1CTL5 = 0x83; //scan only A11 
    
    while (!(ATD0STAT0 & ATD0STAT0_SCF_MASK)); //reads DigitalToAnalog for pins A2, A3, A6
     
    tl = ATD0DR0; 
    bl = ATD0DR1;
    tr = ATD0DR4;
    
    while (!(ATD1STAT0 & ATD1STAT0_SCF_MASK)); // reads DigitalToAnalog for pin A11
    br = ATD1DR0;
    
    //This was test code to determine the values best for deg1 and deg2
    //if (PTH == 0b11111110) {
      //deg1 += 100;
      //PWM1_duty(deg1);
    //} 
    //else if (PTH == 0b11111101) {
      //deg1 -= 100;
      //PWM1_duty(deg1);
    //}
    //else if (PTH == 0b11111011) {
      //deg2 += 100;
      //PWM2_duty(deg2);
    //} 
    //else if (PTH == 0b11110111) {
      //deg2 -= 100;
      //PWM2_duty(deg2);
    //}  
     
    
 //This if statement checks which corner has the greatest amount of light then alters the PWM signals to move the servos torwards that direction//   
 if ((tl > (bl - sens)) && (tl > (tr - sens)) && (tl > (br - sens))) {
      if (deg1 <= 2200) {
        deg1 = deg1 + 10;
        PWM1_duty(deg1);
        MSDelay(100);
      }
      
      if (deg2 >= 3000) {
        deg2 = deg2 - 10;
        PWM2_duty(deg2);
        MSDelay(100);
      } 
    }
     
    else if ((bl > (tl - sens)) && (bl > (tr - sens)) && (bl > (br - sens))){
      if (deg1 >= 900) {
        deg1 = deg1 - 10;
        PWM1_duty(deg1);
        MSDelay(100);
      }
      
      if (deg2 >= 3000) {
        deg2 = deg2 - 10;
        PWM2_duty(deg2);
        MSDelay(100);
      }
    }
     
    else if ((tr > (tl - sens)) && (tr > (bl - sens)) && (tr > (br - sens))){
      if (deg1 <= 2200) {
        deg1 = deg1 + 10;
        PWM1_duty(deg1);
        MSDelay(100);
      }
      
      if (deg2 <= 6000) {
        deg2 = deg2 + 10;
        PWM2_duty(deg2);
        MSDelay(100);
      }
    }
     
    else if ((br > (tl - sens)) && (br > (bl - sens)) && (br > (tr - sens))){
      if (deg1 >= 900) {
        deg1 = deg1 - 10;
        PWM1_duty(deg1);
        MSDelay(100);
      }
      
      if (deg2 <= 6000) {
        deg2 = deg2 + 10;
        PWM2_duty(deg2);
        MSDelay(100);
      }
    }
 //---------------------------------------------------------------------------------------------------------------------------------------------------//
    
    //writes all values to the serial monitor
    dispASCII(tl);
    dispASCII(bl);
    dispASCII(tr);
    dispASCII(br);
    dispASCII(deg1);
    dispASCII(deg2);

    
    cnt = 0;
    
    //creates dashed line
    while (cnt < 30) {
      SerCom0(line[cnt]);
      cnt++;
    }
    
    SerCom0(13);
    SerCom0(10);
    
  }
  
}



//sets up 8-bit PWM for both PP3 and PP1
void PWM1_50Hz(){
    PWMCTL =0x30;             
    PWMPOL = 0x0A;            
    PWMCAE = 0x00;                  
    PWMCLK = 0x00 ;     
    PWMPRCLK =0x33;
             
    PWMPER01=60000;             
    PWMDTY01= 900;                  
    PWMCNT01 = 0;
    MSDelay(10);
    
    PWMPER23= 60000;             
    PWMDTY23= 3000;                  
    PWMCNT23 = 0 ;
    MSDelay(10);
    
        
    PWME = 0x0F ;       
}

//Changes PWM duty cycles----
void PWM1_duty(int d){
   PWMDTY01 = d;  
}

void PWM2_duty(int d){
   PWMDTY23 = d;  
}
//----------------------------

void MSDelay(unsigned int t){
    unsigned int i; unsigned int j;
      for(i = 0; i < t; i++)
        for (j=0; j <4000; j++);
}

void SerCom0(unsigned char data){
    while(!(SCI0SR1 & 0x80));
      SCI0DRL = data;                  
}


//converts any number up to the thousands to ASCII then writes it to the serial monitor.
void dispASCII (unsigned int j) {
    unsigned char th;
    unsigned char h;
    unsigned char t; 
    unsigned char o;
  

    
    th = (j / 1000) + 48; 
    j = j % 1000; 
    h = (j / 100) + 48;
    j = j % 100;
    t = (j / 10) + 48;
    o = (j % 10) + 48;
  
   
    SerCom0(th);
    SerCom0(h);
    SerCom0(t);
    SerCom0(o);
      
    SerCom0(13);
    SerCom0(10);
                   }

//This code was written entirely by Jamar Beck


