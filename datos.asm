.data
	#Fase 0 - Equipos

	# Declaracion de los paises 
	alemania: .asciiz "Alemania"
	arabia: .asciiz "Arabia Saudita"
	argelia: .asciiz "Argelia"
	argentina: .asciiz "Argentina"
	australia: .asciiz "Australia"
	austria: .asciiz "Austria"
	bosnia: .asciiz "Bosnia y Herzegovina"
	brasil: .asciiz "Brasil"
	belgica: .asciiz "Belgica"
	caboverde: .asciiz "Cabo Verde"
	canada: .asciiz "Canada"
	catar: .asciiz "Catar"
	colombia: .asciiz "Colombia"
	coreadelsur: .asciiz "Corea del Sur"
	costademarfil: .asciiz "Costa de Marfil"
	croacia: .asciiz "Croacia"
	curazao: .asciiz "Curazao"
	ecuador: .asciiz "Ecuador"
	egipto: .asciiz "Egipto"
	escocia: .asciiz "Escocia"
	espana: .asciiz "Espana"
	estadosunidos: .asciiz "Estados Unidos"
	francia: .asciiz "Francia"
	ghana: .asciiz "Ghana"
	haiti: .asciiz "Haiti"
	irak: .asciiz "Irak"
	iran: .asciiz "Iran"
	inglaterra: .asciiz "Inglaterra"
	japon: .asciiz "Japon"
	jordania: .asciiz "Jordania"
	marruecos: .asciiz "Marruecos"
	mexico: .asciiz "Mexico"
	noruega: .asciiz "Noruega"
	nuevazelanda: .asciiz "Nueva Zelanda"
	paisesbajos: .asciiz "Paises Bajos"
	panama: .asciiz "Panama"
	paraguay: .asciiz "Paraguay"
	portugal: .asciiz "Portugal"
	republicacheca: .asciiz "Republica Checa"
	rdcongo: .asciiz "Republica Democratica del Congo"
	senegal: .asciiz "Senegal"
	sudafrica: .asciiz "Sudafrica"
	suiza: .asciiz "Suiza"
	suecia: .asciiz "Suecia"
	tunez: .asciiz "Tunez"
	turquia: .asciiz "Turquia"
	uruguay: .asciiz "Uruguay"
	uzbekistan: .asciiz "Uzbekistan"

	# arreglo de los paises 
	arreglo_paises: 
		.word alemania
		.word arabia
		.word argelia
		.word argentina
		.word australia
		.word austria
		.word bosnia
		.word brasil
		.word belgica
		.word caboverde
		.word canada
		.word catar
		.word colombia
		.word coreadelsur
		.word costademarfil
		.word croacia
		.word curazao
		.word ecuador
		.word egipto
		.word escocia
		.word espana
		.word estadosunidos
		.word francia
		.word ghana
		.word haiti
		.word irak
		.word iran
		.word inglaterra
		.word japon
		.word jordania
		.word marruecos
		.word mexico
		.word noruega
		.word nuevazelanda
		.word paisesbajos
		.word panama
		.word paraguay
		.word portugal
		.word republicacheca
		.word rdcongo
		.word senegal
		.word sudafrica
		.word suiza
		.word suecia
		.word tunez
		.word turquia
		.word uruguay
		.word uzbekistan


	NUM_PAISES: .word 48


	#Solicitar al usuario 
	ingreso: .asciiz "Ingrese un país: "
	
	grupo: .space 16   # 4 índices (words)

	entrada: .space 40  # para leer nombre del país
	
	msj_error: .asciiz "País no valido."
	
	msj_repetido: .asciiz "País repetido."
	
	msj_registro: .asciiz "País registrado exitosamente"
