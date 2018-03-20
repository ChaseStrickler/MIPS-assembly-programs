.data
index: 	.word 3
answer: .word 0
space: 	.asciiz " "

.text

main:
addi 	$sp, $sp, -4
sw 		$ra, 0($sp)

lw 		$a0, index
addi 	$t0, $zero, 1
lw		$t1, index
addi 	$t1, $t1, 1

top:
beq 	$t0, $t1, end
jal fib
sw 		$v0, answer

#Print Answer
add 	$a0, $v0, $zero
li 		$v0, 1
syscall

#Print Space
li 		$v0, 4
la 		$a0, space
syscall

addi	$t1, $t1, -1
addi	$a0, $t1, 0
j top


#Returns stack pointer to its original place
end:
lw 		$ra, 0($sp)
addi 	$sp, $sp, 4
jr 		$ra

fib:
addi 	$sp, $sp, -20				#Move things onto the stack
sw		$s5, 16($sp)
sw 		$s4, 12($sp)
sw		$s3, 8($sp)
sw		$s0, 4($sp)
sw		$ra, 0($sp)

addi	$s3, $zero, 0				#Zero out $s3
addi	$s4, $zero, 1				#Set $s4 equal to one, this register will be used as a check
addi	$s5, $zero, 0				#Zero out $s5 register, this will be used later to temporarily store an answer
add 	$s0, $a0, $zero 			#Put arguement in safe register $s0

slt 	$s3, $s0, $s4
beq 	$s3, $s4, basecase			#Break when $s0 is equal to one, or when index < 1

slti	$s3, $s0, 3
beq		$s3, $s4, basecaseTwo		#Break when $s0 is less than three, or when index < 3 

#set answer equal to fib(index - 1)
addi 	$a0, $s0, -1				#Index - 1
jal fib
#answer is now in $v0

add 	$s5, $v0, $zero 			#store $v0 in $s5 to add to 

#set answer equal to fib(index - 2)
addi	$a0, $s0, -1
jal fib
add 	$v0, $v0, $s5

j restoreAndReturn

basecase:
addi	$v0, $zero, 0
j restoreAndReturn

basecaseTwo:
addi	$v0, $zero, 1

restoreAndReturn:
lw		$ra, 0($sp)
lw		$s0, -4($sp)
lw		$s3, -8($sp)
lw		$s4, -12($sp)
lw		$s5, -16($sp)
addi	$sp, $sp, 24
jr $ra