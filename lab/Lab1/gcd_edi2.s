.data
N1: .word 4
N2: .word 8
str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "

.text
main:
 
    lw       a3, N1
    lw       a4, N2 
 
    mv     a0,a3
    mv     a1,a4
 
    jal      ra,gcd
		
    jal      ra,printResult

		

    # Exit program
    li       a0, 10
    ecall

gcd:
   addi sp,sp,-8
   sw ra, 4(sp)
   sw a0, 0(sp)

   bne a1,zero,loop
   
   addi sp,sp,8

   jalr x0,x1,0
 

loop:
    mv a2, a1
    rem a1, a0, a1
    mv a0, a2
    jal  ra,gcd

   lw ra, 4(sp)

   addi  sp, sp, 8
   ret

printResult:
    mv       t0, a3
    mv       t1, a4
    mv       t2, a0

    la       a1, str1
    li       a0, 4
    ecall

    mv       a1, t0
    li       a0, 1
    ecall

    la       a1, str2
    li       a0, 4
    ecall

    mv       a1, t1
    li       a0, 1
    ecall

    la       a1, str3
    li       a0, 4
    ecall
 
    mv       a1, t2
    li       a0, 1
    ecall

    ret