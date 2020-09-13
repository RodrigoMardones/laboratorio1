#lang racket

; TDA archivo

;==========================constructor==============================

;nombre: Archivo
;descrip: funcion que crea un Archivo
;dom: string mensaje, string contenido
;rec: Archivo
(define Archivo (lambda (nombre contenido)
                  (if (and (string? nombre) (string? contenido))
                      (list nombre contenido)
                      null
                      )))

;===============================accesor=============================


;nombre: getNombreArchivo
;descrip: funcion que retorna el nombre de un archivo 
;dom: Archivo
;rec: string
(define getNombreArchivo (lambda (archivo) (car archivo)))

;nombre: getContenidoArchivo
;descrip: funcion que retorna el contenido de un archivo 
;dom: Archivo
;rec: string
(define getContenidoArchivo (lambda(archivo) (car (reverse archivo))))

;============================pertenencia============================

;nombre: isArchivo
;descrip: funcion que evalua si un elemento es un archivo
;dom: Archivo
;rec: bool
(define isArchivo (lambda (archivo)
                    (if (and(not (list? archivo)))
                        #f
                        (if (null? archivo)
                            #f
                            (if (and (string? (getNombreArchivo archivo)) (string? (getContenidoArchivo archivo)))
                                #t
                                #f
                                )))))
;============================selectores=============================

;nombre: setNombre
;descrip: funcion que setea un nuevo nombre a un archivo
;dom: string, Archivo
;rec: archivo
(define setNombre (lambda(nombre archivo)
                  (if (and (string? nombre) (isArchivo archivo))
                           (Archivo nombre (getContenidoArchivo archivo))
                           null
                           )))

;nombre: setContenido
;descrip: funcion que setea un nuevo contenido a un archivo
;dom: string, Archivo
;rec: archivo
(define setContenido (lambda (contenido archivo)
  (if (and (string? contenido) (isArchivo archivo))
      (Archivo (getNombreArchivo archivo) contenido)
      null
  )))


;=========================== other functions =======================

;nombre: archivo2String
;descrip: representa el TDA de un archivo en un string
;dom: archivo
;rec: string
(define archivo2String (lambda (archivo)
                         (string-join archivo ": ")))

;export module Archivo
(provide Archivo getNombreArchivo getContenidoArchivo isArchivo setNombre setContenido archivo2String)

;==============================tests=================================
;(define a1 (Archivo "hola.py" "contenido"))
;(define a2 (Archivo "hola.py" 1))