.data
N: .word 10 # Number of data
str1: .string "Array: "
str2: .string "Sorted: \n"
str3: .string " "
str4: .string "\n"
data:
  .word 5
  .word 3
  .word 6
  .word 7
  .word 31
  .word 23
  .word 43
  .word 12
  .word 45
  .word 1

.text
main:

        # Print the result to console

	la a1,str1
	li a0, 4
	ecall

	la a1,str4
	li a0,4
	ecall

	jal ra,printArray

	jal ra,bubblesort

	la a1,str2
	li a0, 4
	ecall

	jal printArray

	# Exit program
	li       a0, 10
	ecall


# t0:i
# t1:j
# t2:N
# t3:data



bubblesort:
	# save reg
	addi sp,sp,-8
	sw ra,0(sp)

	li t0,0
	lw t2,N
outer_loop:
	# if i >= N, end the process ((if i < N ) is a end condition in C program)
	bge t0,t2,outer_loop_end
	# j will start from i-1 
	addi t1,t0,-1
inner_loop:
	#j < 0, end the inner loop 
	blt t1,zero,inner_loop_end #(condition j >= 0 in C program)
	la t3,data			
	#every integer is 4 byte in this program, so when you want get data[1]
	#you have to go to addres (data + 4)
	#t1 is index i
	#slli t6, t1, 2 means t6 = t1 * 4
	slli t6,t1,2		 
	add t3,t3,t6
	lw t4,0(t3)
	lw t5,4(t3)
	
	
	#(in C program t4 is data[j], t5 is data[j+1])									
	bge t5,t4,inner_loop_end 
	#so when data[j+1] >= data[j], that loop will not swap
	la a0,data
	mv a1,t1
	jal ra,swap
	addi t1,t1,-1
	j inner_loop

inner_loop_end:
 #	i = i + 1
	addi t0,t0,1
	j outer_loop
outer_loop_end:
	# function complete
	lw ra,0(sp)
	addi sp,sp,8
	ret

swap:
	addi sp,sp,-24
	# t0, t1, t2 will be used later, so you have to save it.
	sw t0,0(sp)
	sw t1,8(sp)
	sw t2,16(sp)
	#befor we call this function, we store index i in a1, and data address in a0
	#now we shift index i by 2 and add to a0 to get real address of data[i]
	slli a1,a1,2
	add t1,a0,a1
	#swap data[i] and data[i+1]
	lw t0,0(t1)
	lw t2,4(t1)
	sw t2,0(t1)
	sw t0,4(t1)
	
	# take back t0, t1, t2
	lw t0,0(sp)
	lw t1,8(sp)
	lw t2,16(sp)
	addi sp,sp,24
	ret

## t0 :i
## t1 : N
## t2: data
## t3:char of data
printArray:
    li t0,0
    lw t1,N

printArray_for:
    bge t0,t1,printArray_for_End
    
    la t2,data
    slli t4,t0,2
    add t2,t2,t4

    lb a1,0(t2)
    li a0,1
    ecall 

    la a1,str3
    li a0,4
    ecall 

    # i++
    addi t0,t0,1
    j printArray_for

printArray_for_End:
    la a1,str4
    li a0,4
    ecall 
    ret