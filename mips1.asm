# PROYECTO - ORGANIZACIÓN
.include "datos.asm"
.text
	
main:

	#Mostrar al usuario
	#Solicitar el primer país
	li $v0, 4
	la $a0, ingreso1
	syscall


	#Solicitar el segundo país
	li $v0, 4
	la $a0, ingreso1
	syscall


	#Solicitar el tercer país
	li $v0, 4
	la $a0, ingreso1
	syscall


	#Solicitar el cuarto país
	li $v0, 4
	la $a0, ingreso1
	syscall







	# Terminar
	li $v0, 10
	syscall
