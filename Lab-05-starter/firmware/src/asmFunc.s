/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */

.global dividend,divisor,quotient,mod,we_have_a_problem
.type dividend,%gnu_unique_object
.type divisor,%gnu_unique_object
.type quotient,%gnu_unique_object
.type mod,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
dividend:          .word     0  
divisor:           .word     0  
quotient:          .word     0  
mod:               .word     0 
we_have_a_problem: .word     0

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    LDR r1,=balance
    LDR r2,[r1]
    ADD r0,r0,r2
.endif
    
    /** note to profs: asmFunc.s solution using MUL and UDIV is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 5 Division
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
	
     LDR r6, =dividend/*Load the address of the 'dividend' variable into r6*/
     LDR r7, =divisor/*Load the address of the 'divisor' variable into r7*/
     STR r0,[r6]/*Store the value in r0 in the memory location pointed to dividend*/
     STR r1,[r7]/*Store the value in r1 in the memory location pointed to divisor*/
     
     LDR r11,=we_have_a_problem/*Load the address of the 'we_have_a_problem' variable into r11*/
     LDR r2,=1/*Load the address of the 1 into r11*/
     
     LDR r8, =quotient/*Load the address of the 'quotient' variable into r8*/
     LDR r9, =mod/*Load the address of the 'mod' variable into r9*/
     LDR r10, =0/*Load the address of the 0 into r10*/
     LDR r3, =0/*Load the address of the 0 into r3*/
     
     STR r10,[r8]/*Store the value in r10 in the memory location pointed to quotient*/
     STR r10,[r9]/*Store the value in r10 in the memory location pointed to mod*/
     
     CMP r0,0/*Compare the value in dividend with 0*/
     BEQ error/*Branch to 'error' if 'dividend' is EQUAL to 0*/
     CMP r1,0/*Compare the value in divisor with 0*/
     BEQ error/*Branch to 'error' if 'divisor' is EQUAL to 0*/
     
     do_it:/*Start the loop*/
 	CMP r0,r1/*Compare r0 (dividend) with r1 (divisor)*/
 	BLO final_step/*Branch to "final_step" if r0 is less than r1*/
 	ADD r10,r10,r2/*Add r2 (1) to r10 (quotient)*/
 	SUBS r0,r0,r1/* Subtract r1 (divisor) from r0 (dividend)*/
 	B do_it /*Branch to "do_it"*/
     
     error:
 	STR r2,[r11]/*Store r2 (1) into the memory location pointed to by r11(we_have_a_problem)*/
 	LDR r0,=quotient/*Load the address of the "quotient" label into r0*/
 	B done/*Branch to "done"*/
 
     final_step:
 	STR r10,[r8]/*Store r10 (quotient) into the memory location pointed to by r8*/
 	STR r0,[r9]/*Store r0 (dividend) into the memory location pointed to by r9 (mod)*/
 	STR r3,[r11]/*Store r3 (0) into the memory location pointed to by r11(we_have_a_problem)*/
 	LDR r0,=quotient/*Load the address of the "quotient" label into r0*/
 	B done/*Branch to "done"*/
 
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 /* this is a do-nothing line to deal with IDE mem display bug */

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




