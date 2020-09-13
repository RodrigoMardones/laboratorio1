#lang racket
(require "archivo.rkt")

;TDA Commit

;==========================constructor==============================

;nombre: Commit
;descrip: funcion que crea un commit
;dom: string mensaje, list Archivo
;rec: Commit
(define Commit (lambda (mensaje listaArchivos)
                 (if (and (string? mensaje) (list? listaArchivos))
                     (list mensaje listaArchivos)
                     null
                 )))


;==========================accesor==================================

;nombre: getMensajeCommit
;descrip: funcion que retorna el mensaje del commit 
;dom: Commit
;rec: string
(define getMensajeCommit (lambda (commit) (car commit)))

;nombre: getArchivosCommit
;descrip: funcion que retorna la lista de archivos asociados al commit 
;dom: Commit
;rec: string
(define getArchivosCommit (lambda(commit) (car (reverse commit))))

;============================pertenencia============================

;nombre: iscommit
;descrip: funcion que evalua si un elemento es un commit 
;dom: commit
;rec: boolean
(define isCommit (lambda(commit)
                   (if(not(list? commit))
                      #f
                      (if (null? commit)
                          #f
                          (if (and (string? (getMensajeCommit commit)) (list? (getArchivosCommit commit)))
                              #t
                              #f
                              )))))


;=========================selectores===============================



;=========================other functions==========================

;nombre: commit2String
;descrip: representa el TDA de commit en un string
;dom: Commit
;rec: string
(define commit2String(lambda(commit)
                       (string-join (list (getMensajeCommit commit)(string-join (map archivo2String (getArchivosCommit commit)) " \n ")) " \n ")
                       ))


;export module commit
(provide Commit getMensajeCommit getArchivosCommit isCommit commit2String)
;==============================tests=================================


;(define a1 (Archivo "hola" "mensaje"))
;(define listArchivos (list a1 a1 a1))
;(define c1 (Commit "commit de prueba" listArchivos))
;(getMensajeCommit c1)
;(getArchivosCommit c1)
;(isCommit c1)