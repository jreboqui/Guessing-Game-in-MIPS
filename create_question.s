#
#
# create_question.s
# implements a function to assemble a question string from three parts
#
#   char * create_question(char * first, char * second, char * third);
#
# allocates space for a new string on the heap large enough to hold the 
# question, then fills the space by copying first, second and third, creating
# the concatenated question.
#
#  char * create_question( char * first, char * second, char * third) {

    .text
    .globl create_question
create_question:
    addiu  $sp,$sp,-40
    sw  $a0,40($sp)
    sw  $a1,44($sp)
    sw  $a2,48($sp)
    sw  $ra,36($sp)
#  int len1, len2, len3, len ;
#  char * question;
    # question - s0
    # len1 - s1
    # len2 - s2
    # len3 - s3
    # len - s4
    sw  $s4,32($sp)
    sw  $s3,28($sp)
    sw  $s2,24($sp)
    sw  $s1,20($sp)
    sw  $s0,16($sp)

#
#  len1 = strlen(*first);
   lw	$a0,40($sp)
   jal  strlen
   move $s1, $v0 
  #  len2 = strlen(second); 
   lw	$a0,44($sp)
   jal strlen
   move $s2,$v0
   #  len3 = strlen(third);
   lw	$a0,48($sp)
   jal strlen
   move $s3,$v0
 #  len = len1 + len2 + len3;  
   add $s4, $s2, $s3
   add $s4, $s1, $s4 
 #  question = sbrk (len + 1); 
   addi $s4, $s4, 1
   move $a0, $s4
   jal sbrk
   
   move $s0,$v0 
   move $a0,$s0
 #  strcpy(question,first);  
   lw	$a1,40($sp)
   jal strcpy
 
  #  strcpy(question+len1, second); 
   add $a0, $v0,$s1
   lw	$a1,44($sp)
   jal strcpy
 #  strcpy(question+len1+len2,third);  
   add $a0,$v0,$s2
   lw	$a1,48($sp)
   jal strcpy
   
# 




#
#  return(question);
    move $v0,$s0
    lw  $s4,32($sp)
    lw  $s3,28($sp)
    lw  $s2,24($sp)
    lw  $s1,20($sp)
    lw  $s0,16($sp)
    lw  $ra,36($sp)
    addiu  $sp,$sp,40
    jr  $ra
# }
