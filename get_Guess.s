.data
question:   .asciiz "Give me a number between 0 - 0x64"

message4:   .asciiz "Error: Please enter a valid number."
.text
    .globl get_Guess
    
get_Guess:
   
    addiu	$sp,$sp,-124
    sw		$ra,120($sp)
    sw		$s0,116($sp)
    sw          $s1,112($sp)
    sw          $s2,108($sp)
    sw          $s3,104($sp)
    sw          $a0,124($sp)   #homing *question
    sw          $a1,128($sp)   #homing min
    sw          $a2,132($sp)   #homing max
    
    
get_input:
    lw	$t0, 124($sp) #loading *question to t0
    
    move $a0, $t0
    addi	$a1,$sp,16
    li		$a2,32
    jal InputDialogString
    
    
    blt $v0,$zero,done
    
    #tclearing out a0 and a1
    add $a0, $zero, $zero
    add $a1, $zero, $zero
    
    # transfer the hexadecimal num into integer 
   addi $a0,$sp,24   #we're passing a pointer to an address, this is where the converted string will be saved
   addi $a1,$sp,16  # *buff, the input of user is still in *buffer.
   jal axtoi		# axtoi(int *num, char *string) 
  
  # if ( (guess < min) || (guess > max) ) goto error
  #lw $t0,24($sp) #//LOAD 'guess' from where it is saved on the stacked
  #lw $t1,112($sp) #//LOAD 'min'   from where it is saved on the stacked
  #lw $t2,108($sp) #//LOAD 'max'   from where it is saved on the stacked
  #blt $t0,$t1,badOutput     #  branch less than: if guess < min, print error on screen
  #bgt $t0,$t2,badOutput    	#  branch greater than: if guess > max, print error on screen
  
  
  lw $t0, 24($sp)  #this is 'guess'
  lw $t1, 128($sp)     #this is 'min'
  lw $t2, 132($sp)    #this is 'max'
 # lw $t3, 124($sp)	   #this should be the random number they have to guess
  blt $t0,$zero, Luserquit  #if less than zero - meaning negative - the user pressed q
  blt $t0,$t1,badOutput 
  bgt $t0,$t2,badOutput
  
  move $v0, $t0 #if guess was valid, go to done
  b done
  
  
badOutput:	
	la $a0,message4		# there was an error, please enter it again
	la $a1,0
	jal MessageDialog
	b get_input
	
done:  
    lw		$ra,120($sp)
    lw		$s0,116($sp)
    lw          $s1,112($sp)
    lw          $s2,108($sp)
    lw          $s3,104($sp)
    lw          $a1,124($sp)
    lw          $a2,128($sp)
    lw          $a3,132($sp)
    addiu 	$sp,$sp,124
    jr  	$ra
    
Luserquit:
    addi $v0, $zero, -1
    lw		$ra,120($sp)
    lw		$s0,116($sp)
    lw          $s1,112($sp)
    lw          $s2,108($sp)
    lw          $s3,104($sp)
    lw          $a1,124($sp)
    lw          $a2,128($sp)
    lw          $a3,132($sp)
    addiu 	$sp,$sp,124
    jr  	$ra
    
    
  #  .include "/pub/cs/gboyd/cs270/util.s"
#.include "D:\CCSF FALL 2015\CS 270\procedures\util.s"
