#Chase Strickler
#Recursive Fibonacci Assembly Program
#November 3rd. 2017
#C++ Code for Recursive Fibonacci
#int fib(int index)
#	if(index<2)							//This isn't the fastest solution, as the function will run
#		return 0;						//When index = 2 which should just output 1, but I didn't
#int answer = fib(index-1);				//Include this base case.
#answer = answer + fib(index-2);
#return answer;

.data
index: 		.word 10
space: 		.asciiz " "

.text
main:
	addi	$sp, $sp, -16
	sw		$ra, 0($sp)
	sw		$s5, 4($sp)
	sw		$s6, 8($sp)
	sw		$s7, 12($sp)

	addi	$s5, $zero, 0 				#set $s5 to 0 to be used for a check later
top:
	lw 		$a0, index
	addi	$s7, $a0, 0					#Use registers for loops, $s7 is now equal to $a0
	beq		$s7, $zero, end
	jal	fib
	addi	$s6, $v0, 0
	li 		$v0, 1
	addi	$a0, $s6, 0
	syscall
	li		$v0, 4
	la		$a0, space
	syscall

	addi	$s7, $s7, -1				#Decrement the index
	sw		$s7, index 					#Store the arguement back at the index
	j top

end:
	lw		$ra, 0($sp)
	sw		$s5, -4($sp)
	sw		$s6, -8($sp)
	sw		$s7, -12($sp)
	addi	$sp, $sp, 16
	jr		$ra

fib:									#Checks the base case (index<2), and sets $v0 to 0 if true
	slti	$s5, $a0, 2					#Set $s5 to 1 if $a0 < 2
	beq		$s5, $zero, recursiveFib
	addi	$v0, $a0, 0
	jr		$ra


recursiveFib:
	addi	$sp, $sp, -12				#Move things on stack
	sw 		$ra, 0($sp)			
	sw		$a0, 4($sp)					#Move index onto stack
	addi 	$a0, $a0, -1				#Index - 1 then recursiveFib(index -1)
	jal		fib
	lw		$a0, 4($sp)					#Restore index to initial value
	sw		$v0, 8($sp)					#Save $v0 value into address 8($sp)
	addi 	$a0, $a0, -2				#index - 2
	jal		fib
	lw		$s2, 8($sp)					#store return value of recursiveFib(index -2) into $v0
	add 	$v0, $s2, $v0				#Add both return values
	lw		$ra, 0($sp)
	addi 	$sp, $sp, 12
	jr		$ra