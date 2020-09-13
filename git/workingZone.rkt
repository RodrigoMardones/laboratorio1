#lang racket

(require "archivo.rkt")

;TDA workingZone

;==========================constructor==============================

;nombre: WorkingZone
;descrip: funcion que crea un WorkingZone(workspace o index zone)
;dom: void
;rec: list Archivo
(define WorkingZone (lambda () (list)))

;===============================accesor=============================

;nombre: getArchivos
;descrip: funcion que retorna la lista de archivos del workingzone
;dom: workingZone
;rec: list Archivo
(define getArchivos (lambda (workingZone) workingZone))

;============================pertenencia============================

;nombre: isWorkingZone
;descrip: funcion que evalua si un elemento es workingZone
;dom: workingZone
;rec: boolean
(define isWorkingZone (lambda (workingZone)
                        (if (list? workingZone)
                            #t
                            #f
                            )))

;============================selectores=============================

;nombre: agregarArchivo
;descrip: agrega un archivo al workinZone
;dom: Archivo, workingZone
;rec: workingZone
(define agregarArchivo (lambda (archivo workingZone)
                         (if (isArchivo archivo)
                             (cons archivo workingZone)
                             workingZone
                         )))

;===================== other functions ============================

;nombre: work2String
;descrip: representa el TDA de zona de trabajo en un String
;dom: WorkingZone
;rec: string
(define work2String (lambda(workingZone)
                      (string-join (map archivo2String (getArchivos workingZone)) " \n ")))

;===================export module workingZone=================================
(provide WorkingZone getArchivos isWorkingZone agregarArchivo work2String)
;test
;(define a1 (Archivo "hola" "contenido"))
;(define w1 (WorkingZone))
;(define w2 (agregarArchivo a1 w1))
;(define w3 (agregarArchivo a1 w2))
