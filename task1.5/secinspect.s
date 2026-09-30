	.file	"secinspect.c"
	.text
	.section	.rodata
.LC0:
	.string	"PID: %d\n"
	.align 8
.LC1:
	.string	"Usage: secinspect {-r|-w|-wa|-i} <filepath>\n"
.LC2:
	.string	"-r"
.LC3:
	.string	"-w"
.LC4:
	.string	"-wa"
.LC5:
	.string	"-i"
	.align 8
.LC6:
	.string	"Usage: ./secinspect {-r|-w|-wa|-i} <filepath>\n"
.LC7:
	.string	"open"
.LC8:
	.string	"FILE: %s opened!\n  FD: %d\n"
.LC9:
	.string	"read"
	.align 8
.LC10:
	.string	"Read %zd bytes from %s.\nDATA:\n%s"
	.align 8
.LC11:
	.string	"Write upto %d bytes of data to file. trailing '\\n' will be stripped\n input> "
.LC12:
	.string	"input error!\n"
.LC13:
	.string	"\n"
.LC14:
	.string	"write"
.LC15:
	.string	"%zd bytes written to file"
	.align 8
.LC16:
	.string	"secinspect utility interactive mode"
	.align 8
.LC17:
	.string	"1. fstat %s\n2. read starting at some offset\n3. demo fd 0 1 and 2\n4. redirect output to dup2.txt\nopt: "
.LC18:
	.string	"%d"
.LC19:
	.string	"input error"
.LC20:
	.string	"fstat"
.LC21:
	.string	"size:      %lld bytes\n"
.LC22:
	.string	"inode:     %llu\n"
.LC23:
	.string	"links:     %llu\n"
.LC24:
	.string	"uid:       %u\n"
.LC25:
	.string	"gid:       %u\n"
.LC26:
	.string	"type:      regular file"
.LC27:
	.string	"type:      directory"
.LC28:
	.string	"type:      character device"
.LC29:
	.string	"type:      block device"
.LC30:
	.string	"type:      FIFO/pipe"
.LC31:
	.string	"type:      symlink"
.LC32:
	.string	"type:      socket"
.LC33:
	.string	"type:      unknown"
	.align 8
.LC34:
	.string	"perms:     %c%c%c%c%c%c%c%c%c\n"
.LC35:
	.string	"lseek"
	.align 8
.LC36:
	.string	"Enter a read starting offset in bytes (the start is the beginning of the file)\n The file is %ld bytes.\noffset> "
.LC37:
	.string	"%lld"
	.align 8
.LC38:
	.string	"File Descriptors available to process"
.LC39:
	.string	"stdin  = %d\n"
.LC40:
	.string	"stdout = %d\n"
.LC41:
	.string	"stderr = %d\n"
.LC42:
	.string	"Write to stdout\n"
.LC43:
	.string	"Write to stderr\n"
.LC44:
	.string	"dup2.txt"
.LC45:
	.string	"dup2.txt opened as fd %d\n"
	.align 8
.LC46:
	.string	"redirecting stdout -> dup2.txt ..."
.LC47:
	.string	"dup2"
.LC48:
	.string	"Hello from dup2()!!"
.LC49:
	.string	"close"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$4096, %rsp
	orq	$0, (%rsp)
	subq	$280, %rsp
	.cfi_offset 3, -24
	movl	%edi, -4372(%rbp)
	movq	%rsi, -4384(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	call	getpid@PLT
	movl	%eax, %edx
	leaq	.LC0(%rip), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$3, -4372(%rbp)
	je	.L2
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$1, %eax
	jmp	.L64
.L2:
	movq	-4384(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC2(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -4348(%rbp)
	movq	-4384(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC3(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -4344(%rbp)
	movq	-4384(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC4(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -4340(%rbp)
	movq	-4384(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC5(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -4336(%rbp)
	cmpl	$0, -4348(%rbp)
	jne	.L4
	cmpl	$0, -4344(%rbp)
	jne	.L4
	cmpl	$0, -4340(%rbp)
	jne	.L4
	cmpl	$0, -4336(%rbp)
	jne	.L4
	movq	stderr(%rip), %rax
	leaq	.LC6(%rip), %rdi
	movq	%rax, %rcx
	movl	$46, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movl	$1, %eax
	jmp	.L64
.L4:
	movl	$-1, -4352(%rbp)
	cmpl	$0, -4344(%rbp)
	jne	.L5
	cmpl	$0, -4340(%rbp)
	je	.L6
.L5:
	cmpl	$0, -4340(%rbp)
	je	.L7
	movq	-4384(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movl	$1025, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open@PLT
	movl	%eax, -4352(%rbp)
	jmp	.L6
.L7:
	movq	-4384(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movl	$420, %edx
	movl	$577, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open@PLT
	movl	%eax, -4352(%rbp)
.L6:
	cmpl	$0, -4348(%rbp)
	je	.L8
	movq	-4384(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open@PLT
	movl	%eax, -4352(%rbp)
.L8:
	cmpl	$0, -4336(%rbp)
	je	.L9
	movq	-4384(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movl	$2, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open@PLT
	movl	%eax, -4352(%rbp)
.L9:
	cmpl	$0, -4352(%rbp)
	jns	.L10
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$1, %eax
	jmp	.L64
.L10:
	movq	-4384(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movl	-4352(%rbp), %edx
	leaq	.LC8(%rip), %rcx
	movq	%rax, %rsi
	movq	%rcx, %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -4348(%rbp)
	je	.L11
	leaq	-4128(%rbp), %rcx
	movl	-4352(%rbp), %eax
	movl	$4096, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read@PLT
	movq	%rax, -4280(%rbp)
	cmpq	$0, -4280(%rbp)
	jns	.L12
	leaq	.LC9(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	-4352(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	$1, %eax
	jmp	.L64
.L12:
	leaq	-4128(%rbp), %rdx
	movq	-4280(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movq	-4384(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rdx
	leaq	-4128(%rbp), %rcx
	movq	-4280(%rbp), %rax
	leaq	.LC10(%rip), %rdi
	movq	%rax, %rsi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L13
.L11:
	cmpl	$0, -4344(%rbp)
	jne	.L14
	cmpl	$0, -4340(%rbp)
	je	.L15
.L14:
	leaq	.LC11(%rip), %rax
	movl	$4096, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdin(%rip), %rdx
	leaq	-4128(%rbp), %rax
	movl	$4097, %esi
	movq	%rax, %rdi
	call	fgets@PLT
	testq	%rax, %rax
	jne	.L16
	movq	stderr(%rip), %rax
	leaq	.LC12(%rip), %rdi
	movq	%rax, %rcx
	movl	$13, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movl	-4352(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	$1, %eax
	jmp	.L64
.L16:
	leaq	.LC13(%rip), %rdx
	leaq	-4128(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcspn@PLT
	movb	$0, -4128(%rbp,%rax)
	leaq	-4128(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, -4296(%rbp)
	movq	-4296(%rbp), %rdx
	leaq	-4128(%rbp), %rcx
	movl	-4352(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	movq	%rax, -4288(%rbp)
	cmpq	$0, -4288(%rbp)
	jns	.L17
	leaq	.LC14(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	jmp	.L13
.L17:
	movq	-4288(%rbp), %rax
	leaq	.LC15(%rip), %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L13
.L15:
	cmpl	$0, -4336(%rbp)
	je	.L13
	movl	$-1, -4356(%rbp)
	leaq	.LC16(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	-4384(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	leaq	.LC17(%rip), %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-4356(%rbp), %rax
	leaq	.LC18(%rip), %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	__isoc23_scanf@PLT
	cmpl	$1, %eax
	je	.L19
	movq	stderr(%rip), %rax
	leaq	.LC19(%rip), %rdi
	movq	%rax, %rcx
	movl	$11, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movl	-4352(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	$1, %eax
	jmp	.L64
.L19:
	movl	-4356(%rbp), %eax
	cmpl	$4, %eax
	je	.L21
	cmpl	$4, %eax
	jg	.L22
	cmpl	$3, %eax
	je	.L23
	cmpl	$3, %eax
	jg	.L22
	cmpl	$1, %eax
	je	.L24
	cmpl	$2, %eax
	je	.L25
	jmp	.L22
.L24:
	leaq	-4272(%rbp), %rdx
	movl	-4352(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fstat@PLT
	cmpl	$-1, %eax
	jne	.L26
	leaq	.LC20(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	jmp	.L13
.L26:
	movq	-4224(%rbp), %rax
	leaq	.LC21(%rip), %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-4264(%rbp), %rax
	leaq	.LC22(%rip), %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-4256(%rbp), %rax
	leaq	.LC23(%rip), %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-4244(%rbp), %eax
	leaq	.LC24(%rip), %rdx
	movl	%eax, %esi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-4240(%rbp), %eax
	leaq	.LC25(%rip), %rdx
	movl	%eax, %esi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-4248(%rbp), %eax
	andl	$61440, %eax
	cmpl	$32768, %eax
	jne	.L28
	leaq	.LC26(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L29
.L28:
	movl	-4248(%rbp), %eax
	andl	$61440, %eax
	cmpl	$16384, %eax
	jne	.L30
	leaq	.LC27(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L29
.L30:
	movl	-4248(%rbp), %eax
	andl	$61440, %eax
	cmpl	$8192, %eax
	jne	.L31
	leaq	.LC28(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L29
.L31:
	movl	-4248(%rbp), %eax
	andl	$61440, %eax
	cmpl	$24576, %eax
	jne	.L32
	leaq	.LC29(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L29
.L32:
	movl	-4248(%rbp), %eax
	andl	$61440, %eax
	cmpl	$4096, %eax
	jne	.L33
	leaq	.LC30(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L29
.L33:
	movl	-4248(%rbp), %eax
	andl	$61440, %eax
	cmpl	$40960, %eax
	jne	.L34
	leaq	.LC31(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L29
.L34:
	movl	-4248(%rbp), %eax
	andl	$61440, %eax
	cmpl	$49152, %eax
	jne	.L35
	leaq	.LC32(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L29
.L35:
	leaq	.LC33(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
.L29:
	movl	-4248(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L36
	movl	$120, %r10d
	jmp	.L37
.L36:
	movl	$45, %r10d
.L37:
	movl	-4248(%rbp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L38
	movl	$119, %r9d
	jmp	.L39
.L38:
	movl	$45, %r9d
.L39:
	movl	-4248(%rbp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L40
	movl	$114, %r8d
	jmp	.L41
.L40:
	movl	$45, %r8d
.L41:
	movl	-4248(%rbp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L42
	movl	$120, %edi
	jmp	.L43
.L42:
	movl	$45, %edi
.L43:
	movl	-4248(%rbp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	.L44
	movl	$119, %ebx
	jmp	.L45
.L44:
	movl	$45, %ebx
.L45:
	movl	-4248(%rbp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	je	.L46
	movl	$114, %r11d
	jmp	.L47
.L46:
	movl	$45, %r11d
.L47:
	movl	-4248(%rbp), %eax
	andl	$64, %eax
	testl	%eax, %eax
	je	.L48
	movl	$120, %ecx
	jmp	.L49
.L48:
	movl	$45, %ecx
.L49:
	movl	-4248(%rbp), %eax
	andl	$128, %eax
	testl	%eax, %eax
	je	.L50
	movl	$119, %edx
	jmp	.L51
.L50:
	movl	$45, %edx
.L51:
	movl	-4248(%rbp), %eax
	andl	$256, %eax
	testl	%eax, %eax
	je	.L52
	movl	$114, %esi
	jmp	.L53
.L52:
	movl	$45, %esi
.L53:
	leaq	.LC34(%rip), %rax
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	movl	%ebx, %r9d
	movl	%r11d, %r8d
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	addq	$32, %rsp
	jmp	.L13
.L25:
	movq	$0, -4328(%rbp)
	movl	-4352(%rbp), %eax
	movl	$2, %edx
	movl	$0, %esi
	movl	%eax, %edi
	call	lseek@PLT
	movq	%rax, -4320(%rbp)
	cmpq	$0, -4320(%rbp)
	jns	.L55
	leaq	.LC35(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	-4352(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	$1, %eax
	jmp	.L56
.L55:
	movq	-4320(%rbp), %rax
	leaq	.LC36(%rip), %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-4352(%rbp), %eax
	movl	$0, %edx
	movl	$0, %esi
	movl	%eax, %edi
	call	lseek@PLT
	movq	%rax, -4312(%rbp)
	cmpq	$0, -4312(%rbp)
	jns	.L57
	leaq	.LC35(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	-4352(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	$1, %eax
	jmp	.L56
.L57:
	leaq	-4328(%rbp), %rax
	leaq	.LC37(%rip), %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	__isoc23_scanf@PLT
	cmpl	$1, %eax
	je	.L58
	movq	stderr(%rip), %rax
	leaq	.LC19(%rip), %rdi
	movq	%rax, %rcx
	movl	$11, %edx
	movl	$1, %esi
	call	fwrite@PLT
	movl	$1, %eax
	jmp	.L56
.L58:
	movq	-4328(%rbp), %rcx
	movl	-4352(%rbp), %eax
	movl	$0, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	lseek@PLT
	movq	%rax, -4312(%rbp)
	cmpq	$0, -4312(%rbp)
	jns	.L59
	leaq	.LC35(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	-4352(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	$1, %eax
	jmp	.L56
.L59:
	leaq	-4128(%rbp), %rcx
	movl	-4352(%rbp), %eax
	movl	$4096, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read@PLT
	movq	%rax, -4304(%rbp)
	cmpq	$0, -4304(%rbp)
	jns	.L60
	leaq	.LC9(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	-4352(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	$1, %eax
	jmp	.L56
.L60:
	leaq	-4128(%rbp), %rdx
	movq	-4304(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movq	-4384(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rdx
	leaq	-4128(%rbp), %rcx
	movq	-4304(%rbp), %rax
	leaq	.LC10(%rip), %rdi
	movq	%rax, %rsi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L13
.L56:
	jmp	.L64
.L23:
	leaq	.LC38(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	leaq	.LC39(%rip), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC40(%rip), %rax
	movl	$1, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC41(%rip), %rax
	movl	$2, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC42(%rip), %rax
	movl	$16, %edx
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	leaq	.LC43(%rip), %rax
	movl	$16, %edx
	movq	%rax, %rsi
	movl	$2, %edi
	call	write@PLT
	jmp	.L13
.L21:
	leaq	.LC44(%rip), %rax
	movl	$420, %edx
	movl	$578, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open@PLT
	movl	%eax, -4332(%rbp)
	cmpl	$0, -4332(%rbp)
	jns	.L61
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	jmp	.L13
.L61:
	movl	-4332(%rbp), %eax
	leaq	.LC45(%rip), %rdx
	movl	%eax, %esi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC46(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush@PLT
	movl	-4332(%rbp), %eax
	movl	$1, %esi
	movl	%eax, %edi
	call	dup2@PLT
	cmpl	$-1, %eax
	jne	.L62
	leaq	.LC47(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	-4332(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	jmp	.L13
.L62:
	movl	-4332(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	leaq	.LC48(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush@PLT
	jmp	.L13
.L22:
	movl	$0, %eax
	jmp	.L64
.L13:
	movl	-4352(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	cmpl	$-1, %eax
	jne	.L63
	leaq	.LC49(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
.L63:
	movl	$0, %eax
.L64:
	movq	-24(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L65
	call	__stack_chk_fail@PLT
.L65:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 15.2.0-16ubuntu1) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
