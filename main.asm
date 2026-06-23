# PROYECTO - ORGANIZACIÓN DE COMPUTADORES 
.include "datos.asm" 
.include "equipos.asm" 
.include "partidos.asm"
.include "tabla_de_posiciones.asm"

.text 


.globl main


 main: 
	    # Fase 0: equipos
		jal seleccionar_equipos

		# Fase 1: partidos
	    jal simular_partidos

	    # Fase 2: Tabla de posiciones
	    jal ordenar_tabla
	    jal mostrar_tabla_ordenada
	    
	    li $v0, 10
   	    syscall
