;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname git_18975534_mardonesaguilar) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))


;nombre: Git
;entrada: Funciones
;salida: Funciones
;descrip: Permite la ejecucion de funciones de git
(define Git (lambda (funcion)
	(funcion)
))


;mombre : Init
;entrada: vacio
;salida: Repositorio
;descrip: Permite iniciar un repositorio vacio
(define init (lambda ()
	(list "master" ( list ) (crearRama "master") ( list ))
))

;nombre: getWorkingSpace
;entrada: Repositorio
;salida: String
;descrip: permite obtener el nombre de la rama trabajando
(define getWorkingSpace (lambda (repositorio)
	(car repositorio)
))


;nombre: getIndex
;entrada: Repositorio
;salida: String
;descrip: permite obtener el index de la zona de trabajo del repositorio
(define getIndex (lambda (repositorio)
	(cdar repositorio)
))

;nombre: getRamas
;entrada: Repositorio
;salida: ramas
;descrip: permite obtener las ramas de trabajo del repositorio local
(define getRamas (lambda (repositorio)
	(cddr repositorio)
))


;nombre: getRemote
;entrada: Repositorio
;salida: ramas
;descrip: permite obtener las ramas de trabajo del repositorio remoto
(define getRemote (lambda (repositorio)
	(cdddr repositorio)
))

;nombre: crearRama
;entrada: string
;salida: rama
;descrip: Permite crear un rama
(define crearRama (lambda (nombre)
	(if(string? nombre)
		(list nombre )
		null
	)
))

;nombre: crearCommit
;entrada: index x mensaje
;salida : commit
;descrip: crear un commit a partir de la informacion del index y un mensaje 
(define crearCommit (lambda (index mensaje)
	(list index mensaje)
))

;nombre: ModificarRama
;entrada: rama x commit
;salida : rama
;descrip: Permite agregar cambios a una rama
;recursion: natural
(define modificarRama (lambda (workingspace commit ramas )
	(if (null? ramas)
		null
		(if (string=? (workingspace) (caar ramas))
			(cons (cons (caar ramas) commit) (modificarRama (cdr ramas)))
			(cons (car ramas) (modificarRama (cdr ramas)))
		)
	)
))



;nombre : add
;entrada: cambios
;salida: funcion
;descrip: funcion que recibe lista de cambios y los agrega al index de un repositorio
(define add (lambda (cambios)
	(lambda (repositorio)
		(list (getWorkingSpace repositorio) (cons (getIndex repositorio) cambios) (getRamas repositorio))
	)
))

;nombre: commit
;entrada: mensaje
;salida: funcion
;descrip: funcion que recibe un mensaje y retorna una funcion esperando como repsuesta un repositorio a modificar
(define commit (lambda (mensaje)
	(lambda (repositorio)
		(list (getWorkingSpace repositorio) null (modificarRama (getWorkingSpace repositorio) (crearCommit (getIndex repositorio) mensaje) (getRamas repositorio)))
	)
))


;nombre: toPull 
;entrada: ramas x remote
;salida : ramas
;descrip: trae los cambios asociados del remote a las ramas de trabajo
;recursion: natural
(define toPull (lambda (ramas remote)
	(if(null? ramas)
		null
		(if (string=? (caar remote) (caar ramas))
			(cons (car remote) (toPull (cdr ramas) (cdr remote)))
			(toPull (cdr ramas) (cdr remote))
		)

	)
))

;nombre: pull
;entrada: vacio
;salida: funcion -> repositorio
;descrip: toma los cambios en el remote y los pasas a las ramas de trabajo local 
(define pull (lambda ()
	(lambda (repositorio)
		(list (getWorkingSpace repositorio) (getIndex repositorio) (toPull (getRamas repositorio) (getRemote repositorio)) (getRemote) )
	)
))


;nombre: push
;entrada: vacio
;salida: funcion -> repositorio
;descrip: toma los cambios en el remote y los pasas a las ramas de trabajo local
(define push (lambda ()
	(lambda (repositorio)
		(list (getWorkingSpace repositorio) (getIndex repositorio) (getRamas repositorio) (getRamas repositorio))
	)
))