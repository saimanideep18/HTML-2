// Initialize the counter for screen memory positions.
(INIT)
    @8192       // Load the total number of screen memory addresses (8192 pixels).
    D=A         // Store the value in the D register.
    @n          // Use variable n to hold the counter.
    M=D         // Set n = 8192.

(LOOP)
    @n          // Access the counter n.
    M=M-1       // Decrement n by 1.
    D=M         // Load the updated value of n into D.
    @INIT       // Check if the loop should restart.
    D;JLT       // If n < 0, jump back to INIT to reset.

    @KBD        // Read the keyboard memory-mapped register (RAM[24576]).
    D=M         // Store the keyboard value in D.
    @CLEAR      // Check if no key is pressed (D = 0).
    D;JEQ       // If keyboard value is zero, jump to CLEAR.
    @FILL       // Otherwise, jump to FILL if a key is pressed.
    0;JGT       // Unconditional jump to the FILL routine.

(FILL)
    @SCREEN     // Load the base address of the screen memory (RAM[16384]).
    D=A         // Store the base address in D.
    @n          // Access the current value of n (screen pixel index).
    A=D+M       // Calculate the current screen pixel's address (SCREEN + n).
    M=-1        // Set the current pixel value to -1 (all bits 1, black).
    @LOOP       // Return to the main loop to process the next pixel.
    0;JMP       // Unconditional jump to LOOP.

(CLEAR)
    @SCREEN     // Load the base address of the screen memory (RAM[16384]).
    D=A         // Store the base address in D.
    @n          // Access the current value of n (screen pixel index).
    A=D+M       // Calculate the current screen pixel's address (SCREEN + n).
    M=0         // Set the current pixel value to 0 (all bits 0, white).
    @LOOP       // Return to the main loop to process the next pixel.
    0;JMP       // Unconditional jump to LOOP.
