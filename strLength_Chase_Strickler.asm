#Chase Strickler
#String Length Assembly Program
#November 29,2017
#strlen function in C:
#int strlen( char *string) {
#  int length = 0;
#  while( *(string + length) != NULL) {
#    length++;
#  }
#  return( length);
#}

.data
	string: 	.asciiz "Hello World!"
	string2:	.asciiz "Bedtime"
	space:		.asciiz " "

.text
	main:
		addi	$sp, $sp, -8		#Move things onto stack
		sw		$ra, 0($sp)
		sw		$s3, 4($sp)
		la		$a0, string 		#Load base address of string into $a0

		jal 	strlen
		addi	$t0, $v0, 0			#Move result from $v0 to temporary register

		li		$v0, 1				#Print string length
		addi	$a0, $t0, 0
		syscall

		li		$v0, 4
		la		$a0, space
		syscall

		la 		$a0, string2		#Load second string into argument, and do it all again!

		jal 	strlen
		addi	$t0, $v0, 0			#Move result from $v0 to temporary register

		li		$v0, 1				#Print string length
		addi	$a0, $t0, 0
		syscall

		li		$v0, 4
		la		$a0, space
		syscall

		lw		$s3, -4($sp)
		lw		$ra, 0($sp)
		addi	$sp, $sp, 4
		jr		$ra

	strlen:
		addi	$sp, $sp, -16
		sw		$ra, 0($sp)
		sw		$s0, 4($sp)			#Counter
		sw		$s1, 8($sp)			#Base address
		sw		$s2, 12($sp)		#Current Address
		addi	$s0, $zero, 0		#Initialize counter to 0
		addi	$s1, $a0, 0			#Copy base address of string

		top:
			lb		$s2, 0($s1)		#Load current address of string
			beq		$s2, 0, end		#Break when current address is NULL
			addi	$s1, $s1, 1		#Move to the next value in the string (array)
			addi	$s0, $s0, 1		#increment counter
			j 		top

		end:		
			addi	$v0, $s0, 0		#Move counter to $v0
			lw		$s2, -12($sp)
			lw		$s1, -8($sp)
			lw		$s0, -4($sp)
			lw		$ra, 0($sp)
			addi	$sp, $sp, 16
			jr		$ra