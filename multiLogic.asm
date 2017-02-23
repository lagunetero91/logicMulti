.data
result: .asciiz "Result of: "
x:	.asciiz " x "
is:	.asciiz " is "

.text
Main:
li $s0,3	#This is the first number to multiply. Note that Iw will change this to test your program.
li $s1,4	#This is the second number to multiply. Same as above applies. These values should be placed in appropiate registers before calling.
#insert some code here:

la $a0, result	#Print "Result of " string
li $v0,4
syscall
add $a0, $s0,$0	#Print first number
li $v0,1
syscall
la $a0, x	#Print "x " string
li $v0,4
syscall
add $a0, $s1,$0	#Print second number
li $v0,1
syscall
la $a0, is	#Print "is " string
li $v0,4
syscall

jal multiply
add $s0, $zero, $v0	#Store the result of multiply in $s0. DON'T OVERWRITE $s0 in yout floatError method!!!

add $a0, $s0,$0	#Print multiplication result.
li $v0,1
syscall



li $v0, 10	#This line and the following line exit the program cleary.
syscall

#This method should multiply two numbers. See assigment description for details.
multiply:
#your code here:
addi $sp,$sp, -4	#allocate stack space for one word.
sw $ra, 0($sp)		#save $ra
li $v0,0		#Here is the result register
li $t0,1
li $t1,0
loop:
	beq $s1, $zero, end
	and $t1,$t0, $s1
	beq $t1,1,increase
	beq $t1,0,shift
	
	 increase:
	 	addu $v0,$v0,$s0
	 	
	 shift:
	 	sll $s0,$s0,1
	 	srl $s1,$s1,1
	 
	 j loop
end:
lw $ra,0($sp)		#reload return address
addi $sp,$sp,4		#restore stack space
jr $ra

