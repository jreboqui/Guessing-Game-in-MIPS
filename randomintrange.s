.globl randomintrange

randomintrange:

addiu $sp, $sp, -24
sw    $ra, 20($sp)
sw    $s3, 16($sp)

move  $a0, $zero     # $v0 = time()
  jal   time
  addi  $v0, $v0, 9798 # $v0 = $v0 + offsetConstant
  move  $a0, $v0       # $a0 = offset
  li    $a1, 1         # a1 = low
  li    $a2, 100       # a2 = high
  
  jal   randomint
  
  
  lw    $s3,16($sp)
  lw    $ra, 20($sp)
  addiu $sp, $sp, 24
  jr $ra
  
randomint:
#
# int RandomIntRang(int offestConst, int low, int high) {
  addiu $sp, $sp, -20
  sw    $ra, 16($sp)
  sw    $a2, 28($sp) # #a2 = high
  sw    $a1, 24($sp) # $a1 = low
  sw    $a0, 20($sp) # $a0 = offset
#
# srandom(offset); // $v0 = offset
 jal   srandom
  lw    $a2, 28($sp) # #a2 = high
  lw    $a1, 24($sp) # $a1 = low
  lw    $a0, 20($sp) # $a0 = offset
#
# randomInt = random(); // $v0 = random()
 jal   random
  lw    $a2, 28($sp) # #a2 = high
  lw    $a1, 24($sp) # $a1 = low
  lw    $a0, 20($sp) # $a0 = offset
#
# randomInt = randomInt % high; // %v0 % high
  divu  $v0, $a2     # put remainder in hi
  mfhi  $v0          # move from hi to $v0
#
# randomInt = randomInt + 1; // %v0 = $v0 + 1 
  addi  $v0, $v0, 1
#
# return randomInt; //jra 4ra
  lw    $ra, 16($sp)
 # lw    $a2, 28($sp) 
 # lw    $a1, 24($sp) 
 # lw    $a0, 20($sp) 
  addiu $sp, $sp, 20
  jr    $ra
