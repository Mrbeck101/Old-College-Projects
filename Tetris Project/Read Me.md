The way this code works is by storing the STD_LOGIC_VECTORS for each sprit in 7 blocks of PROM. 
Using a program counter you can go through each position of the sprite
The first value always sent is 0x0017 which is one of the L shaped blocks
after this, each block is based on when the block collides with an object or reaches the bottom of the array sending the stop signal to low passing the value f the rnd_counter
next the game rules are set in RAM_CTRL
Collision is detected using a bitwise & but could in the same way work with a logical &
the block falls through the array by  adjusting its location address based on the psh signal from the PSH_CNT
until pshs is <= 16
The test bench shows two blocks falling to the bottom of the array while being shifted left and right
as well as collison and game over state
