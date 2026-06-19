# FASE 0

# Pedir al usuario 4 equipos
#valida que sean validos 

# Aqui comienza comparador string

# a0 = input
# a1 = pais del arreglo

comparar_str: 
	
for:
	lb $t0, 0($a0)
	lb $t1, 0($a1)
	
	bne $t0, $t1, distintos
	
	beq $t0, $zero, iguales
	
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	
	j for
	
iguales: 
	li $v0, 1
	jr $ra
	
distintos: 
	li $v0, 0
	jr $ra






# ----------------------------------------------------------------------
#Aqui comienza BUSCAR PAIS
buscar_pais: 
	
	li $t0,  # i = 0
	
	bge $t0, 48, no_esta #if t0 >=48 no encontrado
	
	#obtener la dirección del pais 
	la $t1, arreglo_paises
	sll $t2, $t0, 2
	add $t1, $t1, $t2
	lw $t3, 0($t1) 
	
	#compara los strings
	move $a1, $t3
	jal comparar_str # 1 -> son iguales
	
	beq $vo, 1, encontrado
	
	add1 $t0, $t0, 1
	
	j  buscar_pais
	
encontrado: 
	move $v0, $t0
	jr $ra
	
no_esta:
	li $v0, -1
	jr $ra
#Aqui termina BUSCAR PAIS




# ------------------------------------------------------------------
# Aquí comienza seleccionar equipos 

seleccionar_equipos:

	li $t0 = 0   # i = 0
	
for: 
	
	bge $t0, 4, salir # if t0 > = 4 -> salir
	
	#solicitar al usuario 
	li $v0, 4
	la $a0, msg_ingreso #mostrar
	syscall 
	
	#leer 
	li $v0, 8
	la $a0, entrada
	li $a1, 40
	syscall
	
	
	# buscar el país ingresado
	
	
volver: 


# Aquí termina seleccionar equipos




	