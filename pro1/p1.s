.section .data
	input: .string "%ld %ld %ld %ld"
	output: .string "%ld "
	endl: .string "\n"

	max: .string "Maximum: %ld\n"
	min: .string "Minimum: %ld\n"
	med: .string "Median: %ld\n"
	mod: .string "Mode: %ld\n"
	avgI: .string "Average (int): %ld\n"
	avgF: .string "Average (float): %ld\n"
	sum: .string "Sum: %ld\n"
	
	x: .int 0, 0
	a: .int 0, 0
	b: .int 0, 0
	m: .int 0, 0
	n: .float 16.0				#declared float n = 16.0
	
.section .text

rnd:							#random number generator: s[i+1] = (a * s[i] + b) mod m 
	mov $0, %r12				#%r12 = 0
.rnd_loop:
	cmp $15, %r12				#if (%r12 >= 15){
	jge .rnd_end				#goto .rnd_end:} 

	mov (%rdi, %r12, 8), %rax	#%rax = (long8) %rdi[%r12]
	mul %rsi					#%rax = %rax * %rsi
	add %r8, %rax				#%rax = %r8 + %rsi
	div %rcx					#%rdx = %rax % %rcx; %rax = %rax / %rcx
	inc %r12					#%r12++
	mov %rdx, (%rdi, %r12, 8)	#(long8)%rdi[%r12] = %rdx

	jmp .rnd_loop				#goto .rnd_loop:

.rnd_end:
	ret							#return

print_ar:
	mov $0, %r12				#%r12 = 0

.print_loop:
	mov (%rbp, %r12, 8), %rsi	
	lea output(%rip), %rdi		
	xor %eax, %eax
	call printf@plt

	inc %r12

	cmp $16, %r12				#if (%r12 == 16){
	je .print_endl				#goto .print_endl:}

	jmp .print_loop

.print_endl:
	lea endl(%rip), %rdi
	xor %eax, %eax
	call printf@plt

	ret


.global main
main:
	sub $8, %rsp				#standart memory allocation
	lea input(%rip), %rdi		
	lea x(%rip), %rsi
	lea a(%rip), %rdx
	lea b(%rip), %rcx
	lea m(%rip), %r8
	xor %eax, %eax
	call scanf@plt				#save all data

	sub $128, %rsp				#allocate (n * m) bits, where n is 16 and m is 8, because we are allocating long
	push %rbp					#now we are working with base pointer instead of stack pointer
	mov %rsp, %rbp				#it is required in order to return to base (main)

	mov x(%rip), %rdi			#x is the first value of array, so called seed. %rdi = x
	mov %rdi, (%rbp)			#%rbp[0] = x
	lea (%rbp), %rdi			#%rdi = &rbp[0]
	mov a(%rip), %rsi			
	mov b(%rip), %r8
	mov m(%rip), %rcx
	call rnd					#this function works with next 15 elements only, because the first element is already set

	call print_ar				#print all numbers

	#bubble-sort array
	mov $0, %r9					#%r9 = 0; %r9 will be referenced as i: for (int i = 0;				
.l1:
	mov $15, %r8				#%r8 = 15;
	sub %r9, %r8				#%r8 = %r8 - i
	mov $0, %r12				#%r12 = 0; %r12 will be referenced as j: for (int j = 0;
.l2:
	mov (%rbp, %r12, 8), %rdi	#%rdi = %rbp[j]			(8 here means the size of each element of array)
	mov 8(%rbp, %r12, 8), %rsi	#%rsi = %rbp[j + 1]		(here we jump 8 bits forward, so it is the next element)

	cmp %rdi, %rsi				#if (%rsi >= %rdi){		
	jge .l2_next				#goto .l2_next}
	mov %rdi, %rdx				#%rdx = %rdi
	mov %rsi, (%rbp, %r12, 8)	#%rbp[j] = %rsi
	mov %rdx, 8(%rbp, %r12, 8)	#%rbp[j + 1] = %rdx

.l2_next:
	inc %r12					#j++
	cmp %r12, %r8				#if (j == %r8){
	je .l2_end					#goto .l2_end:}
	jmp .l2						#goto .l2:

.l2_end:
	inc %r9						#i++
	cmp $15, %r9				#if (i == %r8){
	je .l1_end					#goto .l1_end:}
	jmp .l1						#goto .l1:

.l1_end:
	call print_ar				#print sorted

	mov $0, %r12

	lea min(%rip), %rdi			#min value is the first element of sorted array
	mov (%rbp, %r12, 8), %rsi
	xor %eax, %eax
	call printf@plt

	mov $15, %r12

	lea max(%rip), %rdi			#max value is the last element of sorted array
	mov (%rbp, %r12, 8), %rsi
	xor %eax, %eax
	call printf@plt

	mov $15, %r12
	mov (%rbp, %r12, 8), %rsi
	mov $0, %r12
	mov (%rbp, %r12, 8), %rdx
	sub %rdx, %rsi
	lea med(%rip), %rdi			#median = max - min
	xor %eax, %eax
	call printf@plt

	mov $0, %r12				#%r12 is i = 0
	mov $0, %rsi				#%rsi is sum = 0

.sum_loop:
	cmp $16, %r12			
	jge .sum_end
	
	mov (%rbp, %r12, 8), %rdi	#%rdi = %rbp[%r12]
	add %rdi, %rsi				#%rsi = %rdi + %rsi
	
	inc %r12
	jmp .sum_loop

.sum_end:
	mov %rsi, %r12				#tricky place, now we have %r12 = %rsi = sum, we did it in order to save sum, because
								#after calling printf@plt %rsi register will be cleared, but %r12 will not be changed 
	lea sum(%rip), %rdi		
	xor %eax, %eax
	call printf@plt
								#average = sum / n
	mov %r12, %rax				#%rax = %r12
	mov $16, %rdi				#%rdi = 16
	div %rdi					#%rdx = %rax % %rdi; %rax = %rax / %rdi; 
	
	mov %rax, %rsi			
	lea avgI(%rip), %rdi		#output integer average
	xor %eax, %eax
	call printf@plt

	push %r12 					#push %r12 (sum of array) to %rsp (stack). Now %r12 is on top of stack. 
	fild (%rsp)					#push int to fpu (floating point unit (float stack))
	pop %r12					#return from ordinary stack to %r12

	fld n(%rip)					#push n (float) to fpu 
	fdivrp %st, %st(1)			#st (top of fpu) / st(1) (next element from top of fpu), then top is poped, and result saved in st(1), which now is st, because element was popped 
	frndint						#st (top of fpu) is rounded to int and saved in st
	sub $8, %rsp				#allocate memory in stack
	fistp (%rsp)				#pop st in %rsp
	mov (%rsp), %rsi			#mov data from top of stack to %rsi
	add $8, %rsp				#deallocate memory
								#as you can see fpu is a special float stack that works the same way as ordinary stack
								#also, you see that push/pop, sub/add work also the same for stack (%rsp or %rbp)
								
	lea avgF(%rip), %rdi		#output float integer average
	xor %eax, %eax
	call printf@plt
	
	#mode: in order to find mode
	#first sort array, and then count all equal values
	#1 1 1 3 3 3 3 5 5 8
	#3 of 1, 4 of 3, 2 of 5, 1 of 8
	#find the max counter: here it is 4 of 3
	#so the mode of array is 3
	
	#try to understand it by yourself, it is the most difficult part here
	#if any questions arise please approach me
	
	mov $0, %r12
	mov $1, %rdi
	mov $0, %rdx
	mov (%rbp, %r12, 8), %rsi
	mov (%rbp, %r12, 8), %rcx
	
.mod_loop:
	inc %r12
	cmp $16, %r12
	jg .mod_end
	cmp (%rbp, %r12, 8), %rsi
	jne .mod_neql
	inc %rdi
	jmp .mod_loop

.mod_neql:
	cmp %rdx, %rdi
	jg .mod_max
	mov $1, %rdi
	mov (%rbp, %r12, 8), %rsi
	jmp .mod_loop

.mod_max:
	mov %rdi, %rdx
	mov $1, %rdi
	mov %rsi, %rcx
	mov (%rbp, %r12, 8), %rsi
	jmp .mod_loop

.mod_end:
	lea mod(%rip), %rdi
	mov %rcx, %rsi
	xor %eax, %eax
	call printf@plt

	leave
	add $136, %rsp
	xor %eax, %eax
	ret



