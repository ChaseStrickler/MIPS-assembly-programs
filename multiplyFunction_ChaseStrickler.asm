#Chase Strickler
#Multiply Function
#6 October 2017

.data
      multiplicand: .word 5
      multiplier: .word 3
      times: .asciiz " times "
      is: .asciiz " is "
      newLine: .asciiz ".\n"

.text

      main:
            addi    $sp, $sp, -4      #move pointer down a register to move ra onto the stack
            sw      $ra, 0($sp)
            lw      $a0, multiplicand #load inputs into arguement registers
            lw      $a1, multiplier
            lw      $t1, multiplicand #store values of inputs to print later
            lw      $t2, multiplier

            jal     multiply          #call function

            addi    $t0, $v0, 0       #store returned value in safe place for later

            #Syscall to print multiplicand
            li      $v0, 1
            addi    $a0, $t1, 0
            syscall

            #Syscall to print "times"
            li      $v0, 4
            la      $a0, times
            syscall

            #Syscall to print multiplier
            li      $v0, 1
            addi    $a0, $t2, 0
            syscall

            #Syscall to print "is"
            li      $v0, 4
            la      $a0, is
            syscall

            #Syscall to print product
            li      $v0, 1
            addi    $a0, $t0, 0
            syscall

            #Syscall to create a new line
            li      $v0, 4
            la      $a0, newLine
            syscall

            #Returns stack pointer to its original place
            lw      $ra, 0($sp)
            addi    $sp, $sp, 4
            jr      $ra

          multiply:
            addi    $sp, $sp, -16     #move stack pointer down 3 registers
            sw      $s2, 12($sp)
            sw      $s0, 8($sp)
            sw      $s1, 4($sp)
            sw      $ra, 0($sp)

            add     $s0, $a0, $zero   #move arguements to saved temp registers
            add     $s1, $a1, $zero
            add     $s2, $zero, $zero #initialize register s2 for the product

          top:
            beq     $s1, $zero, end   #go to end label when a1 register equals 0
            add     $s2, $s2, $s0     #add multiplicand to product
            addi    $s1, $s1, -1      #decrement multiplier
            j top

            end:
            add     $v0, $zero, $zero
            add     $v0, $s2, $zero   #move product to a safe register
            lw      $s2, -12($sp)     #return stack pointer to its original place
            lw      $s0, -8($sp)
            lw      $s1, -4($sp)
            lw      $ra, 0($sp)
            jr      $ra 
