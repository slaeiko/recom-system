;; Cambiar al directorio donde están los archivos
(chdir "d:/Documentos/CUCEI/Semestre_6/KBS/recom-system/")

;; Cargar los templates, hechos y reglas
(load "templates.clp")
(load "facts.clp")
(load "rules.clp")

;; Resetear el entorno para cargar los hechos iniciales
(reset)

;; Ejecutar las reglas
(run)

;; Finalizar la ejecución
(printout t "Ejecución completada." crlf)