.data
    msj_resultados: .asciiz "\nResultados de partidos:\n"
    msj_tabla: .asciiz "\nTabla de posiciones (sin ordenar):\n"
    enc_tabla: .asciiz "Equipo\tGF\tGC\tPts\n"
    sep_tab: .asciiz "\t"
    sep_guion: .asciiz " - "
    salto_linea: .asciiz "\n"

.text

# Simula los 6 partidos del grupo y luego muestra la tabla sin ordenar
simular_partidos:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    jal inicializar_estadisticas

    li $v0, 4
    la $a0, msj_resultados
    syscall

    # grupo[0] vs grupo[1]
    li $a0, 0
    li $a1, 1
    jal jugar_partido

    # grupo[0] vs grupo[2]
    li $a0, 0
    li $a1, 2
    jal jugar_partido

    # grupo[0] vs grupo[3]
    li $a0, 0
    li $a1, 3
    jal jugar_partido

    # grupo[1] vs grupo[2]
    li $a0, 1
    li $a1, 2
    jal jugar_partido

    # grupo[1] vs grupo[3]
    li $a0, 1
    li $a1, 3
    jal jugar_partido

    # grupo[2] vs grupo[3]
    li $a0, 2
    li $a1, 3
    jal jugar_partido

    jal mostrar_tabla_sin_orden

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra


# Inicializa GF, GC y puntos en 0 para los 4 equipos del grupo
inicializar_estadisticas:
    li $t0, 0

loop_init:
    bge $t0, 4, fin_init

    sll $t1, $t0, 2

    la $t2, gf
    add $t2, $t2, $t1
    sw $zero, 0($t2)

    la $t2, gc
    add $t2, $t2, $t1
    sw $zero, 0($t2)

    la $t2, puntos
    add $t2, $t2, $t1
    sw $zero, 0($t2)

    addi $t0, $t0, 1
    j loop_init

fin_init:
    jr $ra


# Simula un partido entre dos equipos del grupo, actualiza y muestra marcador
jugar_partido:
    addi $sp, $sp, -20
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)

    # Generar goles para ambos equipos
    jal random_gol
    sw $v0, 12($sp)      # goles A
    jal random_gol
    sw $v0, 16($sp)      # goles B

    # Actualizar GF, GC y puntos
    lw $a0, 4($sp)       # equipo A
    lw $a1, 8($sp)       # equipo B
    lw $a2, 12($sp)      # goles A
    lw $a3, 16($sp)      # goles B
    jal actualizar_estadisticas

    # Mostrar marcador del partido
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    lw $a2, 12($sp)
    lw $a3, 16($sp)
    jal imprimir_resultado_partido

    lw $ra, 0($sp)
    addi $sp, $sp, 20
    jr $ra


# Genera un numero aleatorio entre 0 y 5 (goles)
random_gol:
    li $v0, 42      # random
    li $a0, 0       # generador aleatorio 0
    li $a1, 6       # rango 0-5
    syscall
    move $v0, $a0
    jr $ra


# Imprime: EquipoA golesA - golesB EquipoB
imprimir_resultado_partido:
    addi $sp, $sp, -24
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $a2, 12($sp)
    sw $a3, 16($sp)

    # Nombre equipo A
    lw $a0, 4($sp)
    jal imprimir_nombre_equipo_grupo

    # Separador
    li $v0, 4
    la $a0, sep_tab
    syscall

    # Goles A
    li $v0, 1
    lw $a0, 12($sp)
    syscall

    # " - "
    li $v0, 4
    la $a0, sep_guion
    syscall

    # Goles B
    li $v0, 1
    lw $a0, 16($sp)
    syscall

    # Separador
    li $v0, 4
    la $a0, sep_tab
    syscall

    # Nombre equipo B
    lw $a0, 8($sp)
    jal imprimir_nombre_equipo_grupo

    # Nueva linea
    li $v0, 4
    la $a0, salto_linea
    syscall

    lw $ra, 0($sp)
    addi $sp, $sp, 24
    jr $ra


# Imprime el nombre del equipo
imprimir_nombre_equipo_grupo:
    addi $sp, $sp, -16
    sw $t0, 0($sp)
    sw $t1, 4($sp)
    sw $t2, 8($sp)
    sw $t3, 12($sp)

    sll $t0, $a0, 2

    la $t1, grupo
    add $t1, $t1, $t0
    lw $t2, 0($t1)       # indice en arreglo_paises

    sll $t2, $t2, 2
    la $t3, arreglo_paises
    add $t3, $t3, $t2
    lw $a0, 0($t3)       # puntero al nombre del pais

    li $v0, 4
    syscall

    lw $t3, 12($sp)
    lw $t2, 8($sp)
    lw $t1, 4($sp)
    lw $t0, 0($sp)
    addi $sp, $sp, 16
    jr $ra


# Muestra la tabla de posiciones sin ordenar
mostrar_tabla_sin_orden:
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $s0, 4($sp)

    li $v0, 4
    la $a0, msj_tabla
    syscall

    li $v0, 4
    la $a0, enc_tabla
    syscall

    li $s0, 0

loop_tabla:
    bge $s0, 4, fin_tabla

    # Equipo
    move $a0, $s0
    jal imprimir_nombre_equipo_grupo

    li $v0, 4
    la $a0, sep_tab
    syscall

    # GF
    sll $t1, $s0, 2
    la $t2, gf
    add $t2, $t2, $t1
    lw $a0, 0($t2)
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, sep_tab
    syscall

    # GC
    sll $t1, $s0, 2
    la $t2, gc
    add $t2, $t2, $t1
    lw $a0, 0($t2)
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, sep_tab
    syscall

    # Puntos
    sll $t1, $s0, 2
    la $t2, puntos
    add $t2, $t2, $t1
    lw $a0, 0($t2)
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, salto_linea
    syscall

    addi $s0, $s0, 1
    j loop_tabla

fin_tabla:
    lw $s0, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra


# Actualiza las estadisticas de los equipos despues de un partido
actualizar_estadisticas:
    # a0 = equipo A
    # a1 = equipo B
    # a2 = goles A
    # a3 = goles B

    # GF y GC equipo A
    la $t0, gf
    sll $t1, $a0, 2
    add $t0, $t0, $t1

    lw $t2, 0($t0)
    add $t2, $t2, $a2
    sw $t2, 0($t0)

    la $t0, gc
    sll $t1, $a0, 2
    add $t0, $t0, $t1
    lw $t2, 0($t0)
    add $t2, $t2, $a3
    sw $t2, 0($t0)

    # GF y GC equipo B
    la $t0, gf
    sll $t1, $a1, 2
    add $t0, $t0, $t1

    lw $t2, 0($t0)
    add $t2, $t2, $a3
    sw $t2, 0($t0)

    la $t0, gc
    sll $t1, $a1, 2
    add $t0, $t0, $t1
    lw $t2, 0($t0)
    add $t2, $t2, $a2
    sw $t2, 0($t0)

    # Determinar resultado
    beq $a2, $a3, empate
    bgt $a2, $a3, ganaA

    # gana B
    la $t0, puntos
    sll $t1, $a1, 2
    add $t0, $t0, $t1
    lw $t2, 0($t0)
    addi $t2, $t2, 3
    sw $t2, 0($t0)
    jr $ra

ganaA:
    la $t0, puntos
    sll $t1, $a0, 2
    add $t0, $t0, $t1
    lw $t2, 0($t0)
    addi $t2, $t2, 3
    sw $t2, 0($t0)
    jr $ra

empate:
    la $t0, puntos
    sll $t1, $a0, 2
    add $t0, $t0, $t1
    lw $t2, 0($t0)
    addi $t2, $t2, 1
    sw $t2, 0($t0)

    la $t0, puntos
    sll $t1, $a1, 2
    add $t0, $t0, $t1
    lw $t2, 0($t0)
    addi $t2, $t2, 1
    sw $t2, 0($t0)

    jr $ra
