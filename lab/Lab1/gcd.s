.data
n1: .word 4
n2: .word 8
str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "

.text
main:
	lw s0, n1	
	lw s1, n2 	
	jal ra, GCD	#jump-and-link to the "gcd" label
	
	#print
	mv a1,s0
	lw s0,n1
	lw s1,n2
	jal ra,print 
	
	
	
	#Exit program
	li a0, 10
	ecall
	
GCD:
	mv s2, s1		
	rem s1, s0, s1	
	mv s0, s2		 
	bnez s1, GCD	
	jalr x0, x1, 0
	
print:
	mv t0, s0
	mv t1, s1
	mv t2, a1
	
	#print 
	la a1, str1
	li a0, 4
	ecall
	
	mv a1, t0
	li a0, 1
	ecall
	
	la a1, str2
	li a0, 4
	ecall
	
	mv a1, t1
	li a0, 1
	ecall 
	
	la a1, str3
	li a0, 4
	ecall
	
	mv a1, t2
	li a0, 1
	ecall
	
	ret
	
	

	