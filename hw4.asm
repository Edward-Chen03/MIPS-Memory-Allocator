############################ Edward Chen ####################################
############################ 114525150 ####################################
############################ edwchen ####################################

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
.text:

.globl create_network
create_network:

	blt $a0, $zero, Error
	blt $a1, $zero, Error
	j Continue
Error:
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0
	li $s6, 0
	li $s7, 0
	li $v0, -1
	jr $ra

Continue:
	move  $s0, $a0
	li $t1, 4
	mult $a0, $t1
	mflo $t0
	
	mult $a1, $t1
	mflo $t1
	
	add $t0, $t0, $t1
	addi $t0, $t0, 16
	
	move $a0, $t0
	li $v0, 9
	syscall
	
	move $s1, $v0
	addi $s2, $zero, 0
	move $t0, $s0 
	sb $t0, 0($s1)

	
	move $t0, $a1
	sb $t0, 4($s1)
	move $v0, $s1
	
	
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0
	li $s6, 0
	li $s7, 0
 	jr $ra

.globl add_person
add_person:

	lbu $t0, 8($a0)
	addi $t0, $t0, 1
	sb $t0, 8($a0)
	move $t8, $t0
	move $v0, $a0
	li $v1, 1
	li $t7, 0
	li $t1, 0
	li $t2, 0
	move $s0, $a1
	move $s5, $a0
	move $s7, $a1
	addi $s5, $s5, 16
checkExist:
	lw $t7, 0($s5)
	beqz $t7, continueAdd
	lw $t7, 4($t7)
checkExistLoop:
	lbu $t0, 0($t7)
	beqz $t0, checkExistContinue
	add $t1, $t1, $t0
	lbu $t0, 0($a1)
	add $t2, $t2, $t0
	addi $t7, $t7, 1
	addi $a1, $a1, 1
	j checkExistLoop
checkExistContinue:
	beq $t1, $t2, networkError
	addi $s5, $s5, 4
	li $t1, 0
	li $t2, 0
	move $a1, $s7
	j checkExist
	
	
continueAdd:
	move $a1, $s7
	move $s0, $a1
	move $s5, $a0
	lb $t1, 0($a1)
	beqz $t1, networkError
	li $t0, 0
nameLoop:
	lbu $t1, 0($a1)
	beqz $t1, checkFullNetwork
	addi $t0, $t0, 1
	addi $a1, $a1, 1
	j nameLoop

checkFullNetwork:
	lbu $t2, 0($a0)
	bgt  $t8, $t2, networkError
	
part2M:
	move $a1, $s0
	move $s1, $a0
	
	move $t9, $t0
	addi $t0, $t0, 5
	move $a0, $t0
	move $t0, $t9
	
	li $v0, 9
	syscall
	
	move $s4, $s5
	addi $s4, $s4, 16
	li $t1, 0
saveNode:
	lbu $t2, 0($s4)
	beqz $t2, addNode
	addi $s4, $s4, 4
	j saveNode
		
addNode:
	sw $v0, 0($s4)
	sb $t0, 0($v0)
	addi $v0, $v0, 4
	sw  $a1, 0($v0)

	
	#reset address
	move $s1, $s5
	move $v0, $s1
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0
	li $s6, 0
	li $s7, 0
 	jr $ra
 
networkError:
	lb $t0, 8($a0)
	addi $t0, $t0, -1
	sb $t0, 8($a0)
 	
 	li $v0, -1
 	li $v1, -1
 	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0
	li $s6, 0
	li $s7, 0       
 	jr $ra

.globl get_person
get_person:
	move $s0, $a0
	move $s1, $a1
	
	addi $s0, $s0, 16
checkLoop:
	lbu $t0, 0($s0)
	beqz $t0, existError
	lw $t0, 0($s0)
	lw $t0, 4($t0)
	beqz $t0, existError
	beq $t0, $s1, nameRef
	addi $s0, $s0, 4
	j checkLoop
	
nameRef:
	lw $t0, 0($s0)
	move $v0, $t0
	li $v1, 1
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0
	li $s6, 0
	li $s7, 0
	jr $ra
	
	
existError:
	li $v0, -1
	li $v1, -1
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0
	li $s6, 0
	li $s7, 0
 	jr $ra

.globl add_relation
add_relation:
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	
checkRelationExists:
	lbu $t0, 12($a0)
	beqz $t0, relationContinue #change to relationContinue
	lbu $t0, 0($a0)
	li $t1, 4
	mult $t0, $t1
	mflo $t0
	addi $t0, $t0, 16
relationExistsLoop:
	addi $s0, $s0, 1
	addi $t0, $t0, -1
	beqz $t0, checkRelationExistsTwo
	j relationExistsLoop

checkRelationExistsTwo:
	lw $t2, 0($s0)
	lw $t2, 0($t2)
	lw $t2, 4($t2)
	
	lw $t0, 0($s0)
	lw $t0, 4($t0)
	lw $t0, 4($t0)
	
	seq $t1, $t2, $a1
	seq $t3, $t0, $a2
	
	seq $t5, $t1, $0
	seq $t6, $t3, $0
	beqz $t5, checkBothRZero
	j skipRelationConditional
checkBothRZero:
	beqz $t6, skipNextRelation

skipRelationConditional:

	beq $t5, $t6, skipFirstRelation

skipNextRelation:
	seq $t4, $t1, $t3
	li $t5, 1
	beq $t4, $t5, relationError

skipFirstRelation:
	seq $t1, $t0, $a1
	seq $t3, $t2, $a2
	
	seq $t5, $t1, $0
	seq $t6, $t3, $0
	beq $t5, $t6, endRelationCheckLoop
	
	seq $t4, $t1, $t3
	li $t5, 1
	beq $t4, $t5, relationError

endRelationCheckLoop:
	addi $s0, $s0, 4
	lbu $t0, 0($s0)
	beqz $t0, relationContinue
	j checkRelationExistsTwo
	
relationContinue:
	move $s0, $a0
	beq $a1, $a2, relationError
	bltz $a3, relationError
	li $t0, 3
	bgt $a3, $t0, relationError
	
	lbu $t0, 4($a0)
	lbu $t1, 12($a0)
	bge $t1, $t0, relationError
	
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	jal get_person
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	addi $sp, $sp, 20
	
	li $t0, -1
	move $t1, $v0
	beq $v0, $t0, relationError
	beq $v1, $t0, relationError
	
	li $t3, 0
	li $t4, 0
	li $t5, 0
	li $t6, 0
	move $t4, $t1
	addi $t4, $t4, 4
	lw $t5, 0($t4)
firstNode:
	lbu $t6, 0($t5)
	beqz $t6, relationFirst
	addi $t3, $t3, 1
	addi $t5, $t5, 1
	j firstNode
	
relationFirst:
	move $t7, $t3
	move $a1, $a2
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	jal get_person
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	addi $sp, $sp, 20
	move $a1, $s2
	
	li $t0, -1
	move $t2, $v0
	beq $v0, $t0, relationError
	beq $v1, $t0, relationError
	li $t3, 0
	li $t4, 0
	li $t5, 0
	li $t6, 0
	move $t4, $t2
	addi $t4, $t4, 4
	lw $t5, 0($t4)
secondNode:
	lbu $t6, 0($t5)
	beqz $t6, relationSecond
	addi $t3, $t3, 1
	addi $t5, $t5, 1
	j secondNode

relationSecond:
	move $t8, $t3
	addi $t7, $t7, 5 #full length of node including 1 for null and 4 for their integers
	addi $t8, $t8, 5
	add $t3, $t7, $t8  #check
	addi $t3, $t3, 4   # heap space allocated 4 for int relation
	addi $t3, $t3, -8
	move $a0, $t3 #create edge heap space
	li $v0 9
	syscall
	
	
	move $a0, $s0
	lbu $t3, 0($a0)
	li $t4, 4
	mult $t3, $t4
	mflo $t3
	addi $t3, $t3, 16
	lbu $t0, 12($a0)
	addi $t0, $t0, 1
	sb $t0, 12($a0)
	
edgeArrayLoop:
	beqz $t3, edgeArray
	addi $a0, $a0, 1
	addi $t3, $t3, -1
	j edgeArrayLoop

edgeArray:
	lw $t9, 0($a0)
	beqz $t9, edgeArrayContinue
	addi $a0, $a0, 4
	j edgeArray
edgeArrayContinue:
	sw $v0, 0($a0)
	sw $t1, 0($v0)
	addi $v0, $v0, 4

	
edgeArraySecond:
	sw $t2, 0($v0)
	addi $v0, $v0, 4
	sb $a3, 0($v0)
	
	move $v0, $s0
	li $v1, 1
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0
	li $s6, 0
	li $s7, 0
	jr $ra
relationError:
	li $v0, -1
	li $v1, -1
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0
	li $s6, 0
	li $s7, 0
 	jr $ra
 	
 	
 

.globl get_distant_friends
get_distant_friends:
	move $s0, $a0
	move $s1, $a1
	li $s2, 0
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	jal get_person
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	addi $sp, $sp, 20
	
	li $t0, -1
	beq $v0, $t0, distantError2
	
	lbu $t0, 0($a0)
	li $t1, 4
	mult $t0, $t1
	mflo $t0
	addi $t0, $t0, 16

distantEdgeLoop:
	addi $t0, $t0, -1
	addi $a0, $a0, 1
	beqz $t0, distantContinueBefore
	j distantEdgeLoop
	
distantContinueBefore:
	move $s5, $a0
distantContinue:
	lw $t0, 0($a0)    
	lbu $t1, 8($t0)
	lw $t0, 0($t0)
	lw $t0, 4($t0)
	li $t2, 3
	beq $t1, $t2, distantContinue2
	li $t2, 2
	beq $t1, $t2, distantContinue2
	beq $t0, $a1, distantSameName1
	
	lw $t0, 0($a0) #heap address
	lw $t0, 4($t0) #node address
	lw $t0, 4($t0) #string address
	beq $t0, $a1, distantSameName2
	
distantContinue2:

	addi $a0, $a0, 4
	lbu $t0, 0($a0)
	beqz $t0, distantError1
	j distantContinue
distantSameName1:
	lw $a1, 0($a0)
	lw $a1, 4($a1)
	lw $a1, 4($a1)
	j distantSameName
distantSameName2:
	lw $a1, 0($a0)
	lw $a1, 0($a1)
	lw $a1, 4($a1)
distantSameName:
	move $s6, $a0
	move $a0, $s0
	lbu $t0, 0($a0)
	li $t1, 4
	mult $t0, $t1
	mflo $t0
	addi $t0, $t0, 16

distantSameNameLoop:
	addi $t0, $t0, -1
	addi $a0, $a0, 1
	beqz $t0, distantSameNameContinue
	j distantSameNameLoop

distantSameNameContinue:
	move $s4, $a0
	beq $a0, $s6, distantContinue3
	lw $t0, 0($a0)
	lbu $t1, 8($t0)
	lw $t0, 0($t0)
	lw $t0, 4($t0)
	li $t2, 2
	beq $t1, $t2, distantContinue3
	li $t2, 3
	beq $t1, $t2, distantContinue3
	beq $t0, $a1, createFriendNode1
	
	lw $t0, 0($a0) #heap address
	lw $t0, 4($t0) #node address
	lw $t0, 4($t0) #string address
	beq $t0, $a1, createFriendNode2
	
distantContinue3:
	addi $a0, $a0, 4
	lbu $t0, 0($a0)
	beqz $t0, distantError1
	j distantSameNameContinue
	
	
createFriendNode1:
	move $t0, $a1
	lw $a1, 0($a0)
	lw $a1, 4($a1)
	lw $a1, 4($a1)
	j createFriendNode
createFriendNode2:
	move $t0, $a1
	lw $a1, 0($a0)
	lw $a1, 0($a1)
	lw $a1, 4($a1)
createFriendNode:
	
	li $t2, 0
friendNodeK:
	lbu $t1, 0($t0)
	beqz $t1, createFriendNodeContinue

	addi $t2, $t2, 1

createFriendNodeContinue:
	addi $t2, $t2, 5
	beq $a1, $s1, FirstNodeAddress
	move $a0, $t2
	li $v0, 9
	syscall
	
	beqz $s2, saveFirstNode
	j createFriendNodeContinue2
saveFirstNode:
	move $s3, $v0
createFriendNodeContinue2:
	
	sw $a1, 0($v0)
	addi $t2, $t2, -4
loopToNode:
	addi $v0, $v0, 1
	addi $t2, $t2, -1
	beqz $t2, createFriendNodeContinue3
	j loopToNode
createFriendNodeContinue3:
	addi $s2, $s2, 1
	li $t3, 1
	beq $s2, $t3, FirstNodeAddress
	
	move $t3, $s2
	move $t4, $s3
	addi $t4, $t4, 4
loopToNextNode:
	lbu $t9, 0($t4)
	beqz $t9, addFriendNodeAddress
	addi $t4, $t4, 4
	j loopToNextNode
addFriendNodeAddress:
	sw $v0, 0($t4)
	
FirstNodeAddress:
	move $a0, $s4
	move $a1, $t0
	addi $a0, $a0, 4
	lbu $t0, 0($a0)
	bnez $t0, distantSameNameContinue
	
	addi $s5, $s5, 4
	move $a0, $s5
	move $a1, $s1
	lbu $t0, 0($a0)
	bnez $t0, distantContinue
	
	
	
finish:
	move $v0, $s3
	beq $v0, $0, distantError3
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0
	li $s6, 0
	li $s7, 0
 	jr $ra
 	
 	
 
distantError1:
	bge $s2, $0, FirstNodeAddress
	li $v0, -1
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0
	li $s6, 0
	li $s7, 0
	jr $ra
distantError2:
	li $v0, -2
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0
	li $s6, 0
	li $s7, 0
	jr $ra
 
 distantError3:
 	li $v0, -1
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0
	li $s6, 0
	li $s7, 0
	jr $ra