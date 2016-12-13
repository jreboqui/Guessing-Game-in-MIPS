.data
testprompt: .asciiz "What's the int: "

min: .word  1    #lowest number
max:  .word 0x64  #highest number
maxStr: .space 100
.align 2
offsetConst: .word 6700

firstHalf: .asciiz "Guess must be a hexa decimal number between 1 and 0x" 
secHalf:   .asciiz "\nEnter your guess or q to quit "
message1:   .asciiz "Guess is too low"
message2:   .asciiz "Guess is too high"
message3:   .asciiz "Correct!"
.text
.globl main

main:

addiu $sp, $sp, -20
sw    $ra, 16($sp)

#maxStr = itoax(int max, char maxStr)
	lw  $a0, max
	la  $a1, maxStr
	jal itoax 
	
	#create_question(char * firstHalf, char max ,char * secHalf)
	la $a0,firstHalf
	la $a1,maxStr
	la $a2,secHalf
    	
	jal create_question
	
la $s3, 0($v0)  #saves the string question to $s3 
jal PrintString


jal randomintrange
#$v0 holds random number
#save it to $s0
move $s0, $v0
#temporarily saving the random int number to $s0
#move $s0, $v0

#testprinting the random integer that we generated, we can always take this out.
#la $a0, testprompt
#move $a1, $v0
#jal MessageDialogInt



#before calling get_guess, have the secret number moved to $a0
#pass the random integer to get_Guess

#get_guess(int secretNumber, char *question)
#move $a0, $v0
#la $a1,0($s3)

#jal get_Guess

#get_guess(char *question, int min, int max)
LguessLoop:
la $a0, 0($s3)   #question to $a0
lw $a1, min
lw $a2, max
jal get_Guess
#$v0 should hold guess now


#now we have to compare it to 
 blt $v0,$zero, superdone  #the user gave up 
 blt $v0,$s0,toolow	# guess less than random, then too low
 bgt $v0,$s0,toohigh	# guess greater than random, then too high 
 beq $v0,$s0,correct	# guess	equals, correct

  
toolow:	 la $a0,message1
	 la $a1,1
	 jal MessageDialog
	 b LguessLoop
toohigh: la $a0,message2
	 la $a1,1
	 jal MessageDialog
	 b LguessLoop
correct: la $a0,message3
	 la $a1,1
	 jal MessageDialog	
	
superdone:
 lw $ra, 16($sp)
 addiu $sp, $sp, 20
 jr $ra
  #  .include "/pub/cs/gboyd/cs270/util.s"  <<<----use this and comment out my util.s
 .include "D:\CCSF FALL 2015\CS 270\procedures\util.s"
