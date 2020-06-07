//Perihelion language - high level language with subroutines and abstracted memory
//
// * Semicolons ignored
// * Whitespace (mostly ignored - used to distinguish words, not commands)
// * ^ means next word is name of subroutines
// * All contents (separated by comma) in parentheses replace the contents of the
//   parenthesis in the subroutine definition
// * #SUBROUTINE used to indicate subroutine is about to be defined
// * & (variable memory location) used to indicate next word is name of
//		abstracted memory location (assigned by compiler)
// * @ (code memory location) used to indicate a jump position - the location of
//		an instruction to jump to.
// * = and : can be used interchangably for readability
// * Comments made with dual forward slash
// * conditional jump instructions:
//		* IFZERO executes block that follows iff REGC contains all 0s
//		* IFCARRY executes block that follows iff REGC contains all 1s
//		* ELSE follows an IF... block and executes the block after ELSE if the IF
//			block did not execute
// * #HERE tells the compiler to make the abstract memory location which must
//		follow on the same line (ie. an @ location) to refer to the line number
//		of the next assembly instruction.


//Define initial variables
&f = 1e3;
&C = 1e-12;
&pi = 3.1415926535;

&val_1 = 1;
&val_2 = 2;

//************* Main Program body **************
//	calculate: print 1/(2*pi*f*c)

//Multiply 2*pi*f*C
RAM_REGA &val_2
RAM_REGB &pi
MULT
^CHAIN_MULT(&f);
^CHAIN_MULT(&C);

//Calculate inverse
REGC_RAM &temp
RAM_REGB &temp
RAM_REGA &val_1

//Display result
REGC_DISPA

IFZERO{
	RPLAN 0 //Reprogrammable light on
}ELSE{
	RPAUS 0 //Reprogrammable light off
}

IFZERO @CLAUSE_IF
//else stuff
SUB
JUMP @END_IF
#HERE @CLAUSE_IF
//if stuff
ADD
#HERE @END_IF

IFCARRY{
	RPLAN 1 //Reprogrammable light on
}ELSE{
	RPAUS 1 //Reprogrammable light off
}

WHILEZERO{
	//things
	ADD
}

#HERE @start_loop
ADD //address @start_loop refers to this add instruction. This is for jump instructions
//things
IFZERO{
	JUMP @start_loop
}

//*************** Define Subroutines *************

//DEFINE SUBROUTINE
#SUBROUTINE CHAIN_MULT(x){
	REGC_REGA
	RAM_REGB x
	MULT
}