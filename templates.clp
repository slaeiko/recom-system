(deftemplate smartphone
   (slot id)
   (slot marca)
   (slot modelo)
   (slot color)
   (slot precio)
   (slot almacenamiento) ;; en GB
   (slot stock (default 0))
   (slot en-promocion (default FALSE)))

(deftemplate computadora
   (slot id)
   (slot marca)
   (slot modelo)
   (slot tipo) ;; laptop / escritorio
   (slot color)
   (slot precio)
   (slot almacenamiento) ;; en GB
   (slot ram) ;; en GB
   (slot sistema-operativo)
   (slot procesador)
   (slot stock (default 0))
   (slot en-promocion (default FALSE)))

(deftemplate accesorio
   (slot id)
   (slot tipo) ;; funda, mica, cargador, audífonos, etc.
   (slot marca)
   (slot modelo)
   (slot color)
   (slot precio)
   (slot descuento (default 0)))

(deftemplate cliente
   (slot id)
   (multislot nombre) ;; Permitir nombres con varios espacios
   (slot tipo (default none)) ;; menudista / mayorista
   (slot telefono))

(deftemplate orden
   (slot id)
   (slot cliente-id)
   (slot prod-id)
   (slot pago-id)
   (slot qty)
   (slot forma-pago) ;; contado / tarjeta
   (slot procesada (default FALSE))
   (slot total (default 0)))

(deftemplate tarjetacred
   (slot id)
   (slot banco)
   (slot grupo) ;; VISA / MasterCard / Oro / etc.
   (slot titular)
   (slot exp-date))

(deftemplate vale
   (slot id)
   (slot cliente-id)
   (slot cantidad)
   (slot fecha-emision))


