LAB 2--------------------------------------------------------------------------------------------------------------------------
1.	Subroutines
  Define a subroutine “count_letters” that would count the number of letters (a-z, A-Z) inside a 
null-terminated string of ASCII characters. The subroutine will receive the address of the string in X and return the count in D. Write a program that would define a string in Flash memory (ROM) and use this subroutine to test it.


2.	Shift and Rotate Instructions
Create a new assembly project and enter the following instructions in main.asm. Single-step through the program and fill in the following table.

3.	Some Applications of Shift/Rotate Instructions
Define a 64-bit constant signed integer in Flash. Then, Write a subroutine count_1s that would count the number of 1s in a byte. The subroutine will receive the input parameter in A and return the result back in A. Use this subroutine to write a program that would count the number of 1s inside the 64-bit constant signed integer. Define a variable that would hold the total count of 1s.

4.	BSET/BCLR Instructions 
Study the following program. 
Rewrite the program to use the BSET/BCLR instructions instead of the logic instructions.

5.	BRSET/BRCLR instructions
The following program counts the number of elements in an array whose bits 3, 4, and 7 are 0s. The array has 10 8-bit elements stored in the Flash. The program uses the logic instruction to do its job. Rewrite the program to use BRSET/BRCLR instructions instead of the logic instructions.



LAB 3-------------------------------------------------------------------------------------------------------------------------

1.	The board has RGB LED. Write a program that cycles through the 8 different colors that you get by mixing the Red, Green, & Blue. Use a delay of 500ms between them.

2.	Write a program that implements an 8 bit up counter on the 8 LEDs.  Increment the counter every second.


3.	Write a program that displays -OU- on the four 7 segment displays repeatedly. You will need to use the multiplexing technique on the 4 displays in this part.

4.	Write a program that generates a noise of 500Hz on the speaker on your board
