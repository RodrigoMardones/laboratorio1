#lang racket
(require "archivo.rkt")
(require "commit.rkt")
(require "workingZone.rkt")
(require "repoZone.rkt")

;TDA Repository
;===============================constructor===============================


;nombre: Repository
;descrip: crea una repositorio con sus 4 zonas de trabajo en orden, WorkSapce, Index, Local, Remote
;dom: void
;rec: repository
(define Repository (lambda ()  (list (WorkingZone) (WorkingZone) (RepoZone) (RepoZone))))

;==================================accessor==============================

;nombre: getWorkSpace
;descrip: retorna el workspace de un repository
;dom: repository
;rec: WorkingZone
(define getWorkSpace (lambda (repository) (car repository)))

;nombre: getIndex
;descrip: retorna el indexZone de un repository
;dom: repository
;rec: WorkingZone
(define getIndex (lambda (repository) (car (cdr repository))))

;nombre: getLocal
;descrip: retorna el LocalRepository de un repository
;dom: repository
;rec: RepoZone
(define getLocal (lambda (repository) (car (cdr (cdr repository)))))

;nombre: getRemote
;descrip: retorna el RemoteRepository de un repository
;dom: repository
;rec: RepoZone
(define getRemote (lambda (repository) (car (reverse repository))))




;=================== GIT FUNCTIONS =====================================

;nombre: git
;descrip: retorna la funcion sin ejecutar con el nombre correspondiente al proceso de git
;dom: funcion
;rec: funcion
(define git (lambda (function) function))


;nombre: addArchivo
;descrip: agrega un archivo a un repository
;dom: funcion(archivo)
;rec: funcion(repository)
(define addArchivo (lambda (archivo)
                  (lambda(repository)
                    (list (agregarArchivo archivo (getWorkSpace repository)) (getIndex repository) (getLocal repository) (getRemote repository))
                  )))
;nombre: add
;descrip: agrega una lista de elemento o en su defecto el workinZone al indexZone
;dom: funcion(workingZone)
;rec: funcion(repository)
(define add (lambda (workingZone)
              (lambda (repository)
                (if (null? workingZone)
                    (list (getWorkSpace repository) (getWorkSpace repository) (getLocal repository) (getRemote repository))
                    (list (WorkingZone) workingZone (getLocal repository) (getRemote repository))
                ))))

;nombre: commit
;descrip: crea un commit en el localRepository
;dom: funcion(string)
;rec: funcion(repository)
(define commit (lambda (mensaje)
                 (lambda (repository)
                   (list (getWorkSpace repository) (WorkingZone) (agregarCommit (Commit mensaje (getIndex repository))  (getLocal repository)) (getRemote repository))
                   )))

;nombre: push
;descrip: realiza un push dentro del repositorio
;dom: repository
;rec: repository
(define push (lambda (repository)
               (list (getWorkSpace repository) (getIndex repository) (getLocal repository) (getLocal repository))))

;nombre: pull
;descrip: realiza un pull dentro del repositorio
;dom: repository
;rec: repository
(define pull (lambda (repository)
               (if (> (lengthList (getLocal repository) 0 ) (lengthList (getRemote repository) 0))
                      repository
                      (proccessPull (list (getWorkSpace repository) (getIndex repository) (list) (getRemote repository))))))
              

;nombre: git->String
;descrip: representa todas las zonas de trabajo de un repository en string
;dom: repository
;rec: string
(define git->String (lambda (repository)
                      (string-join
                       (list  (string-join (list "workspace" (work2String (getWorkSpace repository))) "\n" )
                              (string-join (list "index" (work2String (getIndex repository))) "\n")
                              (string-join (list "local Repository" (repo2String (getLocal repository))) "\n")
                              (string-join (list "remote Repository"(repo2String (getRemote repository))) "\n")
                      ) " \n " )))


;============================== funciones extra ==================================
;nombre: proccessPull
;descrip: procesa el pull dentro de un repositorio
;dom: repository
;rec: repository
;recursion: natural
;motivo: requerimiento de proyecto obligatorio
(define proccessPull (lambda (repository)
                       (if (null? (getRemote repository))
                           (list (getWorkSpace repository) (getIndex repository) (getLocal repository) (getLocal repository))
                           (proccessPull (list (getWorkSpace repository) (getIndex repository) (cons (car (getRemote repository)) (getLocal repository)) (cdr (getRemote repository))))
                       )))

;nombre: lengthList
;descrip: retorna el largo de una lista
;dom: list
;rec: int
;recursion: natural
;motivo: mejor forma de contar una lista con este paradigma
(define lengthList (lambda (list count)
                     (if (null? list)
                     count
                     (lengthList (cdr list) (+ count 1))
                     )))

;=================================tests==============================

(define a1 (Archivo "archivo1" "contenido1"))
(define a2 (Archivo "archivo2" "contenido2"))
(define a3 (Archivo "archivo3" "contenido3"))

(define r1 (Repository)) 
(define r2 (((git addArchivo) a1) r1)) 
(define r3 (((git add) (getWorkSpace r2)) r2))
(define r4 (((git commit) "primer commit") r3))
(define r5 ((git push) r4))
(define r6 ((git pull) r5))
(git->String r6)

(define r7 (((git addArchivo) a2) r6)) 
(define r8 (((git add) (getWorkSpace r7)) r7))
(define r9 (((git commit) "segundo commit") r8))
(define r10 ((git push) r9))
(define r11 ((git pull) r10))
(git->String r11)

(define r12 (((git addArchivo) a3) r11))
(define r13 (((git add) (getWorkSpace r12)) r12))
(define r14 (((git commit) "tercer commit") r13))
(define r15 ((git push) r14))
(define r16 ((git pull) r15))
(git->String r16)


