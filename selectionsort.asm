 .data
tam: .word 15
str: .asciiz "Informe um numero inteiro\n"
str2: .asciiz " "
str4: .asciiz "o resultado final da ordenacao \n"
str3: .asciiz "informe um numero entre 1 e 15 \n"
str5: .asciiz "TRABALHO PRATICO 1\nDaniela Menezes e Giovani Santos G Araujo\n"
  .align 2
num: .space 60
.text
main:
li $v0,4
la $a0,str5
syscall
li $v0,4                   # codigo para imprimir string 
la $a0,str3                # $a0 = string 3
syscall                    # chamada da impressao
li $v0,5                   # codigo para ler um inteiro
syscall                    # chamada da leitura
add $s4,$zero,$v0          # $s4 = tam
la $sp,num                 # $s6 = array num
add $s5,$zero,$zero        # inicializa variavel i com 0
Lup:                       # inicia o Looping
slt $t0,$s5,$s4            # testa if ( i < tam )
beq $t0,$zero,FimLup       # se i >= tam , sai do Loop
li $v0,4                   # codigo para imprimir string 
la $a0,str                 # $a0 = string 
syscall                    # chamada da impressao
sll $t0,$s5,2              # $t0 = i * 4
add $t1,$t0,$sp            # soma $t0 ao endereço base do vetor
li $v0,5                   # codigo para ler um inteiro
syscall                    # chamada da leitura
sw $v0,0($t1)              # num[$t0] = $v0
addi $s5,$s5,1             # i = i + 1
j Lup
FimLup:
add $a2,$sp,$zero
add $a1,$s4,$zero
jal selection_sort
li $v0,4
la $a0,str4
syscall
add $s0, $zero, $zero
Imprime:
slt $t0, $s0, $s4
beq $t0, $zero, FimPrime
sll $t1, $s0, 2
add $t1, $t1, $sp
lw $a0, 0($t1)
li $v0, 1
syscall
li $v0,4
la $a0,str2
syscall
addi $s0, $s0, 1 
j Imprime
FimPrime:

li $v0,10
syscall

selection_sort:
add $s0, $zero,$zero
addi $t0, $a1, -1
Loop:
slt $t1, $s0, $t0
beq $t1, $zero, FimLoop
add $s2, $zero, $s0
addi $s1,$s0,1 
Loop2:
slt $t1, $s1, $a1
beq $t1, $zero, FimLoop2
sll $t2, $s1, 2
add $t3, $a2, $t2
lw $t4, 0($t3)
sll $t5, $s2, 2
add $t3, $a2, $t5
lw $t6, 0($t3)
slt $t7, $t4, $t6
beq $t7, $zero, Fim
add $s2, $zero, $s1
Fim:
addi $s1, $s1, 1
j Loop2
FimLoop2:
beq $s0, $s2, IFim  
sll $t3, $s0, 2       #ix4
add $t3, $a2, $t3     #soma no vtor
lw $s3, 0($t3)        #s3 = num[i]
sll $t4, $s2, 2       # min x 4
add $t4, $a2, $t4     # soma no vtor
lw $t5, 0($t4)        # t5 = num[min]
add $t8,$zero,$s3     #aux = num[i]  
sw $t5,0($t3)         # num[i] = num[min]
sw $t8,0($t4)         #num[min] = aux
IFim:
addi $s0, $s0, 1      #i++
j Loop
FimLoop:
jr $ra