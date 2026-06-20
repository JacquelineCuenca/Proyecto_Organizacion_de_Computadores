.text

# FASE 0

# Pedir al usuario 4 equipos
#valida que sean validos 

# Aqui comienza comparador string

# a0 = input
# a1 = pais del arreglo

comparar_str: 
	
for_comp:
	lb $t0, 0($a0)
	lb $t1, 0($a1)
	
	bne $t0, $t1, distintos
	
	beq $t0, $zero, iguales
	
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	
	j for_comp
	
iguales: 
	li $v0, 1
	jr $ra
	
distintos: 
	li $v0, 0
	jr $ra


#----------------------------------------------------------
# Quitar el salto de linea


quitar_salto:

loop_q:

    lb $t0,0($a0)

    beq $t0,$zero,fin_q

    li $t1,10

    beq $t0,$t1,reemplazar

    addi $a0,$a0,1
    j loop_q

reemplazar:

    sb $zero,0($a0)

fin_q:

    jr $ra



# ----------------------------------------------------------------------
#Aqui comienza BUSCAR PAIS
#-------------------------------------------------------------------------

buscar_pais:
	addi $sp,$sp,-12
    	sw $ra,0($sp)
    	sw $s1,4($sp)
    	sw $s2,8($sp)

    	move $s1,$a0
    	li $s2,0
loop_paises:

  	 bge $s2, 48, no_esta

    # obtener arreglo_paises[i]
    	la  $t1, arreglo_paises
    
    	sll $t2, $s2, 2
    	add $t1, $t1, $t2
    	lw  $t3, 0($t1)

    # comparar input con país actual
   	 move $a0, $s1      # restaurar input
   	 move $a1, $t3          # país del arreglo

   	 jal comparar_str

    	beq $v0, 1, encontrado

   	 addi $s2, $s2, 1
   	 j loop_paises

encontrado:

	move $v0,$s2

   	 lw $s2,8($sp)
   	 lw $s1,4($sp)
   	 lw $ra,0($sp)

   	 addi $sp,$sp,12

  	  jr $ra

no_esta:

 	 li $v0,-1

    	lw $s2,8($sp)
    	lw $s1,4($sp)
    	lw $ra,0($sp)

    	addi $sp,$sp,12

  	  jr $ra


#Aqui termina BUSCAR PAIS

#================================================================================
#------------------------------------------
es_existente: 
	li $t0, 0
	
for_grupo:

	bge $t0, 4, no_existe
	
	la $t1, grupo
	sll $t2, $t0, 2
	add $t1, $t1, $t2
	lw $t3, 0($t1)
	
	beq $t3, $a0, si_existe
	
	addi $t0, $t0, 1
	
	j for_grupo
	
si_existe: 
	li $v0, 1
	jr $ra
	
	
no_existe:

	li $v0, 0
	jr $ra
	

#=================================================================
# ------------------------------------------------------------------
# Aquí comienza seleccionar equipos 

seleccionar_equipos:

 	 addi $sp,$sp,-8
   	 sw $ra,0($sp)
   	 sw $s0,4($sp)

   	 li $s0,0
	
for_e:
	bge $s0, 4, salir # if t0 > = 4 -> salir

volver:
	#solicitar al usuario 
	li $v0, 4
	la $a0, ingreso #mostrar
	syscall 
	
	#leer 
	li $v0, 8
	la $a0, entrada

	
	li $a1, 40
	syscall
	
	
	# buscar el país ingresado
	la $a0, entrada
	
	jal quitar_salto
	
	la $a0, entrada
	
	jal buscar_pais
	
	
	move $t1, $v0
	
	#validar que existe
	li $t2, -1
	beq $t1, $t2, error
	
	#validar si no es repetido
	move $a0,$t1
	jal es_existente
	
	beq $v0, 1, repetido
	
	
	#guardamos en el arreglo grupo
	la $t3, grupo
	sll $t4, $s0, 2
	add $t3, $t3, $t4
	sw $t1, 0($t3)
	
	# confirma
	li $v0, 4
	la $a0, msj_registro
	syscall
	
	
	addi $s0, $s0, 1
	j for_e
	
error:
	li $v0, 4
	la $a0, msj_error
	syscall
	j volver
	
repetido:
	li $v0, 4
	la $a0, msj_repetido
	syscall
	j volver
	
salir:

	lw $s0,4($sp)
    	lw $ra,0($sp)

    	addi $sp,$sp,8

    
	jr $ra

# Aquí termina seleccionar equipos


