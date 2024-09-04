.data
argument: .word 7
str: .string "the number in the Fibonacci sequence is "

.text
main:                          # initial value
        lw    a0, argument     # n = 7
        li    s0, 1            # for comparison with n (n <= 1)
        jal   ra, fib          # call fib(7)

        mv    a1, a0           # a1 : final falue
        lw    a0, argument     # a0 : argument
        jal   ra, printResult  # print result

		#exit
					li   a0, 10
        ecall 

fib:
        ble   a0, s0, L1       # if(n <= 1)
        addi  sp, sp, -24     # push the stack
        sw    ra, 0(sp)        # store return address
        sw    a0, 8(sp)        # store argument n

        addi  a0, a0, -1       # argument = n - 1
        jal   ra, fib          # call fib(n - 1)
        sw    a0, 16(sp)        # store return value of fib(n - 1)

        lw    a0, 8(sp)        # load argument n
        addi  a0, a0, -2       # argument = n - 2
        jal   ra, fib          # call fib(n - 2)
        lw    t1, 16(sp)        # load return value of fib(n - 1)

        add   a0, a0, t1       # fib(n - 1) + fib(n - 2)
        lw    ra, 0(sp)        # load return address
        addi  sp, sp, 24       # pop the stack
                   
	
L1:
        jalr	x0, x1, 0                    # return

printResult:                   # Fibonacci(7)
        mv    t0, a0
        mv    t1, a1
                        
        mv    a1, t0
        li    a0, 1
        ecall      
		            
        la    a1, str
        li    a0, 4
        ecall        
        
        mv    a1, t1
        li    a0, 1
        ecall                  
        ret
