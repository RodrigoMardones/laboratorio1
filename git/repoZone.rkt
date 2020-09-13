#lang racket
(require "archivo.rkt")
(require "commit.rkt")

;TDA repoZone
;==========================constructor==============================
(define RepoZone (lambda () (list)))


;===============================accesor=============================
(define getCommits (lambda (repoZone) repoZone))


;============================pertenencia============================

;nombre: isRepoZone
;descrip: funcion que evalua si un elemento es workingZone
;dom: workingZone
;rec: boolean
(define isRepoZone (lambda (repoZone)
                        (if (list? repoZone)
                            #t
                            #f
                            )))

;============================selectores=============================

;nombre: isRepoZone
;descrip: funcion que evalua si un elemento es workingZone
;dom: workingZone
;rec: boolean
(define agregarCommit (lambda (commit repoZone)
                        (if (isCommit commit)
                            (cons commit repoZone)
                            repoZone
                            )))

;======================= other functions ==========================

;nombre: repo2String
;descrip: representa el TDA de zona de repositorio en un String
;dom: RepoZone
;rec: string
(define repo2String (lambda (repoZone)
                      (string-join (map commit2String (getCommits repoZone)) " \n ")))

; export module RepoZone
(provide RepoZone getCommits isRepoZone agregarCommit repo2String)


;==============================tests=================================
;(define a1 (Archivo "hola" "hola"))
;(define listArchivos (list a1 a1 a1))
;(define c1 (Commit "commit de prueba" listArchivos))
;(getMensajeCommit c1)
;(getArchivosCommit c1)
;(isCommit c1)
;(define repo1 (RepoZone))
;(define repo2 (agregarCommit c1 (RepoZone)))

