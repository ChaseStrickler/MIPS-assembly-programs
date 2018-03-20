#Chase Strickler
#Assembly Function to find Largest Value in Array
#November 12, 2017
#Largest value is printed to console
#int largest( int* array, int arrayLength) {
#    int largest = array[0];
#    int index = 1;
#    while( index < arrayLength) {
#        if( array[index] > largest {
#            largest = array[index];
#        }
#        index++;
#    }
#    return( largest);
#}

.data
	array:		.word 24, -1, 7, 92, 23, 2342, 3
	arrayLength:	.word 7

.text
	main:
		addi	$sp, $sp, -4		#Move values on to stack
		sw	$ra, 0($sp)	

		la	$a0, array 					
		lw	$a1, arrayLength

		jal	largest
		addi	$t1, $v0, 0

		li	$v0, 1
		addi	$a0, $t1, 0
		syscall

		lw	$ra, 0($sp)
		addi	$sp, $sp, 4
		jr	$ra

	largest:
		addi	$sp, $sp, -40
		sw	$ra, 0($sp)
		sw	$s4, 20($sp)		#allocate space for array
		sw	$s5, 24($sp)		#arrayLength
		sw	$s6, 28($sp)		#counter
		sw	$s7, 32($sp)		#max
		sw	$s1, 36($sp)		#store temp value of array[index]


		addi 	$s4, $a0, 0		#load base address of the array into $s4
		addi	$s5, $a1, 1		#copy arrayLength +1 ($a1) into $s5
		addi	$s6, $zero, 0		#initialize counter
		lw	$s7, 0($s4)		#initialize max register
		addi	$s1, $zero, 0		#initialize temp register

	top:
		addi	$t0, $zero, 0		#use $t0 temporarily as the slt check
		lw	$s1, 0($s4)		#store array[index] in $s1
		slt 	$t0, $s7, $s1		#if $s7<$s1, set $t0=1
		beq	$t0, $zero, next	#if $s0 equals 0, max > array[index],go to next 
		lw	$s7, 0($s4) 		#updating $s7 to the max value
		j	next
	next:
		addi	$s6, $s6, 1		#increase counter
		addi	$s4, $s4, 4		#update the array's base address
		bne	$s6, $s5, top
		
		addi	$v0, $s7, 0
		lw	$ra, 0($sp)
		lw	$s4, -20($sp)		#restore stack pointer
		lw	$s5, -24($sp)		
		lw	$s6, -28($sp)		
		lw	$s7, -32($sp)		
		lw	$s1, -36($sp)		
		addi	$sp, $sp, 40
		jr	$ra
			
