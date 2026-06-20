# PROYECTO - ORGANIZACIÓN DE COMPUTADORES 
.include "datos.asm" 
.include "equipos.asm" 
.include "partidos.asm"

.text 


.globl main


 main: 
	    jal seleccionar_equipos
	    jal simular_partidos
	    
	    li $v0, 10
   	    syscall
