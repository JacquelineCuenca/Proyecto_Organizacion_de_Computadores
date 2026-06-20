# PROYECTO - ORGANIZACIÓN DE COMPUTADORES 
.include "datos.asm" 
.include "equipos.asm" 


.text 


.globl main


 main: 
	    jal seleccionar_equipos
	    
	    
	    li $v0, 10
   	    syscall