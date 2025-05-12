;; En la compra de un iPhone 16 con tarjetas Banamex, ofrece 24 meses sin intereses.
(defrule promocion-iphone16-banamex
   ?orden <- (orden (id ?id)
                    (tipo smartphone)
                    (marca apple)
                    (modelo iPhone16)
                    (forma-pago tarjeta)
                    (tarjeta-banco banamex))
   =>
   (printout t "Promoción aplicada: 24 meses sin intereses con tarjeta Banamex para el iPhone 16. No. Orden " ?id crlf))

;; En la compra de un Samsung Note 21 con tarjeta de Liverpool VISA, ofrece 12 meses sin intereses.
(defrule promocion-samsung-note21-liverpool
   ?orden <- (orden (id ?id)
                    (tipo smartphone)
                    (marca samsung)
                    (modelo Note21)
                    (forma-pago tarjeta)
                    (tarjeta-banco liverpool)
                    (tarjeta-grupo VISA))
   =>
   (printout t "Promoción aplicada: 12 meses sin intereses con tarjeta Liverpool VISA para el Samsung Note 21. No. Orden " ?id  crlf))

;; En la compra al contado de una MacBook Air y un iPhone 16, ofrecer 100 pesos en vales por cada 1000 pesos de compra.
(defrule promocion-macbookair-iphone16
   ?orden1 <- (orden (id ?id1)
                     (tipo smartphone)
                     (marca apple)
                     (modelo iPhone16)
                     (forma-pago contado))
   ?orden2 <- (orden (id ?id2)
                     (tipo computadora)
                     (marca apple)
                     (modelo MacBookAir)
                     (forma-pago contado))
   =>
   (printout t "Promoción aplicada: 100 pesos en vales por cada 1000 pesos de compra al contado de una MacBook Air y un iPhone 16." crlf)
   (printout t "Órdenes que activaron la promoción: ID " ?id1 " y ID " ?id2 crlf))

;; Si el cliente compra un Smartphone, ofrecer una funda y mica con un 15% de descuento sobre accesorios.
(defrule promocion-accesorios-smartphone
   ?orden <- (orden (id ?id)
                    (tipo smartphone))
   =>
   (printout t "Promoción aplicada: 15% de descuento en funda y mica al comprar un Smartphone." crlf)
   (printout t "Orden que activó la promoción: ID " ?id crlf))

;; Si el cliente compra un accesorio con un descuento mayor al 10%, imprimir un mensaje indicando el ahorro.
(defrule promocion-accesorio-descuento
   ?accesorio <- (accesorio (id ?id)
                            (descuento ?descuento&:(> ?descuento 10)))
   =>
   (printout t "Promoción aplicada: El accesorio con ID " ?id " tiene un descuento del " ?descuento "%." crlf))

;; Si el cliente compra una computadora con más de 16GB de RAM, ofrecer un mouse gratis.
(defrule promocion-computadora-ram
   ?computadora <- (computadora (id ?id)
                                (ram ?ram&:(> ?ram 16)))
   =>
   (printout t "Promoción aplicada: La computadora con ID " ?id " incluye un mouse gratis por tener más de 16GB de RAM." crlf))
  
;; Si el cliente compra un smartphone y una computadora de la misma marca, ofrecer un 10% de descuento en el total, siempre que ninguno esté en promoción.
(defrule promocion-smartphone-computadora-misma-marca
   ?orden1 <- (orden (id ?id1)
                     (tipo smartphone)
                     (marca ?marca1)
                     (total ?total1)
                     (en-promocion FALSE))
   ?orden2 <- (orden (id ?id2)
                     (tipo computadora)
                     (marca ?marca2&:(eq ?marca1 ?marca2))
                     (total ?total2)
                     (en-promocion FALSE))
   =>
   (bind ?total (+ ?total1 ?total2)) ;; Calcular el total combinado
   (bind ?descuento (* ?total 0.10)) ;; Calcular el 10% de descuento
   (printout t "Promoción aplicada: 10% de descuento en el total por comprar un smartphone y una computadora de la marca " ?marca1 "." crlf)
   (printout t "Órdenes que activaron la promoción: ID " ?id1 " y ID " ?id2 crlf)
   (printout t "Descuento total: $" ?descuento crlf))

;; Si el cliente es mayorista y compra más de 10 unidades de cualquier producto, ofrecer un 5% de descuento adicional.
(defrule promocion-mayorista
   ?cliente <- (cliente (id ?cliente-id)
                        (tipo mayorista))
   ?orden <- (orden (id ?id)
                    (cliente-id ?cliente-id)
                    (total ?total)
                    (qty ?qty&:(> ?qty 10)))
   =>
   (bind ?descuento (* ?total 0.05)) ;; Calcular el 5% de descuento
   (printout t "Promoción aplicada: 5% de descuento adicional para el cliente mayorista con ID " ?cliente-id " en la orden ID " ?id "." crlf)
   (printout t "Ahorro total: $" ?descuento "." crlf))

;; Si el cliente compra una computadora con sistema operativo macOS, ofrecer un descuento del 10% en accesorios Apple.
(defrule promocion-computadora-macos
   ?computadora <- (computadora (id ?id)
                                (sistema-operativo macOS))
   =>
   (printout t "Promoción aplicada: 10% de descuento en accesorios Apple para la computadora con ID " ?id " con macOS." crlf))

;; Si el cliente compra una computadora con un precio mayor a $20,000, ofrecer un descuento del 15% en software adicional.
(defrule promocion-computadora-premium
   ?computadora <- (computadora (id ?id)
                                (precio ?precio&:(> ?precio 20000)))
   =>
   (printout t "Promoción aplicada: 15% de descuento en software adicional para la computadora con ID " ?id " con precio de $" ?precio "." crlf))

;; Regla 12: Si el cliente compra un smartphone y un accesorio de audio (audífonos o bocina), ofrecer un descuento del 10% en el accesorio, siempre que el accesorio no tenga descuento.
(defrule promocion-smartphone-audio
   ?orden1 <- (orden (id ?id1)
                     (tipo smartphone))
   ?accesorio <- (accesorio (id ?id2)
                            (tipo ?tipo&:(or (eq ?tipo "audífonos") (eq ?tipo "bocina")))
                            (descuento ?descuento&:(= ?descuento 0))
                            (precio ?precio))
   =>
   (bind ?ahorro (* ?precio 0.10)) ;; Calcular el 10% de descuento
   (printout t "Promoción aplicada: 10% de descuento en el accesorio de audio (ID " ?id2 ") por la compra del smartphone con ID " ?id1 "." crlf)
   (printout t "Ahorro total: $" ?ahorro "." crlf))

;; Si el cliente compra un smartphone con un precio mayor a $15,000, ofrecer un seguro contra robo gratis.
(defrule promocion-smartphone-seguro-robo
   ?smartphone <- (smartphone (id ?id)
                              (precio ?precio&:(> ?precio 15000)))
   =>
   (printout t "Promoción aplicada: Seguro contra robo gratis para el smartphone con ID " ?id " con precio de $" ?precio "." crlf))

;; Si el cliente compra una computadora y un smartphone de marcas diferentes, ofrecer un descuento del 5% en el total.
(defrule promocion-computadora-smartphone-marcas-diferentes
   ?orden1 <- (orden (id ?id1)
                     (tipo computadora)
                     (marca ?marca1)
                     (total ?total1))
   ?orden2 <- (orden (id ?id2)
                     (tipo smartphone)
                     (marca ?marca2&:(neq ?marca1 ?marca2))
                     (total ?total2))
   =>
   (bind ?total (+ ?total1 ?total2)) ;; Calcular el total combinado
   (bind ?ahorro (* ?total 0.05))   ;; Calcular el 5% de descuento
   (printout t "Promoción aplicada: 5% de descuento en el total por comprar una computadora (ID " ?id1 ") y un smartphone (ID " ?id2 ") de marcas diferentes." crlf)
   (printout t "Ahorro total: $" ?ahorro "." crlf))

;; Si el cliente compra un smartphone y un accesorio de carga (cargador o batería externa), ofrecer un descuento del 6% en el accesorio, siempre que el accesorio no tenga descuento.
(defrule promocion-smartphone-carga
   ?orden1 <- (orden (id ?id1)
                     (tipo smartphone))
   ?accesorio <- (accesorio (id ?id2)
                            (tipo ?tipo&:(or (eq ?tipo "cargador") (eq ?tipo "batería-externa")))
                            (descuento ?descuento&:(= ?descuento 0))
                            (precio ?precio))
   =>
   (bind ?ahorro (* ?precio 0.06)) ;; Calcular el 6% de descuento
   (printout t "Promoción aplicada: 6% de descuento en el accesorio de carga (ID " ?id2 ") por la compra del smartphone con ID " ?id1 "." crlf)
   (printout t "Ahorro total: $" ?ahorro "." crlf))

;; Si el cliente compra una computadora con almacenamiento mayor a 1TB, ofrecer un descuento del 20% en discos duros externos.
(defrule promocion-computadora-almacenamiento
   ?computadora <- (computadora (id ?id)
                                (almacenamiento ?almacenamiento&:(> ?almacenamiento 1024)))
   =>
   (printout t "Promoción aplicada: 20% de descuento en discos duros externos para la computadora con ID " ?id " con almacenamiento de " ?almacenamiento "GB." crlf))

;; Si el cliente compra una MacBook Pro con procesador M2 y más de 16GB de RAM, ofrecer un descuento del 15% en software de edición.
(defrule promocion-macbookpro-m2
   ?computadora <- (computadora (id ?id)
                                (marca apple)
                                (modelo MacBookPro)
                                (procesador M2)
                                (ram ?ram&:(> ?ram 16)))
   =>
   (printout t "Promoción aplicada: 15% de descuento en software de edición por la compra de la MacBook Pro con ID " ?id " con procesador M2 y " ?ram "GB de RAM." crlf))

;; Si el cliente utiliza vales como método de pago y compra un smartphone con un precio mayor a $15,000, ofrecer un descuento adicional del 5% en el total.
(defrule promocion-smartphone-con-vales
   ?orden <- (orden (id ?id)
                    (tipo smartphone)
                    (forma-pago vales)
                    (total ?total&:(> ?total 15000)))
   =>
   (bind ?descuento (* ?total 0.05)) ;; Calcular el 5% de descuento
   (printout t "Promoción aplicada: 5% de descuento adicional en el total por usar vales como método de pago en la compra del smartphone con ID " ?id " con un total de $" ?total "." crlf)
   (printout t "Ahorro total: $" ?descuento "." crlf))

;; Si el cliente utiliza vales como método de pago y compra una computadora con un precio mayor a $25,000 pero no mayor a $100,000, ofrecer un descuento adicional del 10%.
(defrule promocion-computadora-con-vales
   ?orden <- (orden (id ?id)
                    (tipo computadora)
                    (forma-pago vales)
                    (total ?total&:(and (> ?total 25000) (<= ?total 100000))))
   =>
   (bind ?descuento (* ?total 0.10)) ;; Calcular el 10% de descuento
   (printout t "Promoción aplicada: 10% de descuento adicional en el total por usar vales como método de pago en la compra de la computadora con ID " ?id " con un total de $" ?total "." crlf)
   (printout t "Ahorro total: $" ?descuento "." crlf))
   
;; Si el cliente compra productos de la marca Samsung con un total mayor a $50,000 pagando de contado, ofrecer un bono de $5,000 para la próxima compra.
(defrule promocion-samsung-bono
   ?orden <- (orden (id ?id)
                     (marca samsung)
                     (forma-pago contado)
                     (total ?total&:(> ?total 50000)))
   =>
   (printout t "Promoción aplicada: Bono de $5,000 para la próxima compra por adquirir productos Samsung con un total mayor a $50,000 pagando de contado. Orden ID: " ?id "." crlf))

;; Validar si el cliente es mayorista y actualiza el tipo de cliente si compra más de 10 unidades.
(defrule validar-mayorista
   ?cliente <- (cliente (id ?cliente-id)
               (nombre ?nombre)
               (tipo ?tipo)
               (telefono ?telefono)) ;; Agregar todos los campos adicionales del cliente
   ?orden <- (orden (id ?id)
               (cliente-id ?cliente-id)
               (qty ?qty&:(> ?qty 10)))
   =>
   (retract ?cliente)
   (assert (cliente (id ?cliente-id)
               (nombre ?nombre)
               (tipo mayorista)
               (telefono ?telefono))) ;; Mantener todos los campos originales
   (printout t "Validación realizada: El cliente con ID " ?cliente-id " ha sido actualizado a tipo 'mayorista' por comprar más de 10 unidades en la orden ID " ?id "." crlf))

;; Si el cliente compra más de 30 unidades de un producto, ofrecer envío gratis.
(defrule envio-gratis
   ?orden <- (orden (id ?id)
                    (qty ?qty&:(> ?qty 30)))
   =>
   (printout t "Promoción aplicada: Envío gratis para la orden ID " ?id " por comprar más de 30 unidades." crlf))

;; Si el cliente compra un smartphone con más de 10 unidades, recomendar accesorios de protección (funda y mica).
(defrule recomendacion-accesorios-proteccion
   ?orden <- (orden (id ?id)
                    (tipo smartphone)
                    (qty ?qty&:(> ?qty 10)))
   =>
   (printout t "Recomendación: Accesorios de protección (funda y mica) disponibles para la orden ID " ?id "." crlf))

;; Si el stock de un producto baja a menos de 5 unidades, recomendar reabastecimiento.
(defrule recomendar-reabastecimiento
   ?producto <- (smartphone (modelo ?modelo)
                            (almacenamiento ?almacenamiento&:(< ?almacenamiento 5)))
   =>
   (printout t "Recomendación: Reabastecer el modelo " ?modelo " ya que el stock es menor a 5 unidades." crlf))

;; Actualizar e imprimir el stock después de una compra (aplica para smartphones y computadoras).
(defrule actualizar-e-imprimir-stock
   ?orden <- (orden (id ?orden-id)
                    (modelo ?modelo)
                    (qty ?qty))
   ?producto <- (or (smartphone (id ?prod-id)
                                (marca ?marca)
                                (modelo ?modelo)
                                (color ?color)
                                (precio ?precio)
                                (almacenamiento ?almacenamiento)
                                (stock ?stock)
                                (en-promocion ?en-promocion))
                    (computadora (id ?prod-id)
                                 (marca ?marca)
                                 (modelo ?modelo)
                                 (tipo ?tipo)
                                 (color ?color)
                                 (precio ?precio)
                                 (almacenamiento ?almacenamiento)
                                 (ram ?ram)
                                 (sistema-operativo ?sistema-operativo)
                                 (procesador ?procesador)
                                 (stock ?stock)
                                 (en-promocion ?en-promocion)))
   =>
   ;; Calcular el nuevo stock
   (bind ?nuevo-stock (- ?stock ?qty))
   
   ;; Eliminar el hecho actual del producto
   (retract ?producto)
   
   ;; Insertar el producto actualizado con el nuevo stock
   (if (eq ?producto smartphone)
       then
       (assert (smartphone (id ?prod-id)
                           (marca ?marca)
                           (modelo ?modelo)
                           (color ?color)
                           (precio ?precio)
                           (almacenamiento ?almacenamiento)
                           (stock ?nuevo-stock)
                           (en-promocion ?en-promocion)))
       else
       (assert (computadora (id ?prod-id)
                            (marca ?marca)
                            (modelo ?modelo)
                            (tipo ?tipo)
                            (color ?color)
                            (precio ?precio)
                            (almacenamiento ?almacenamiento)
                            (ram ?ram)
                            (sistema-operativo ?sistema-operativo)
                            (procesador ?procesador)
                            (stock ?nuevo-stock)
                            (en-promocion ?en-promocion))))
   
   ;; Imprimir el resultado
   (printout t "Stock actualizado: El modelo " ?modelo " ahora tiene " ?nuevo-stock " unidades disponibles." crlf))

;; Regla para encontrar clientes que no han comprado nada.
(defrule clientes-sin-compras
   (cliente (id ?cliente-id) (nombre ?nombre))
   (not (orden (cliente-id ?cliente-id)))
   =>
   (printout t "Cliente sin compras: " ?nombre " (ID: " ?cliente-id ")." crlf))

;; Regla para encontrar productos comprados y la cantidad total considerando todas las órdenes.
(defrule productos-comprados-total
   (declare (salience 10)) ;; Asegurar que esta regla se evalúe después de otras relacionadas con órdenes.
   ?orden <- (orden (modelo ?modelo) (qty ?qty))
   (aggregate sum ?total-qty (orden (modelo ?modelo) (qty ?qty)) ?total-qty)
   =>
   (printout t "Producto comprado: Modelo " ?modelo ", Cantidad total: " ?total-qty "." crlf))

;; Regla para encontrar clientes que compraron más de 5 productos.
(defrule clientes-mas-de-5-productos
   (cliente (id ?cliente-id) (nombre ?nombre))
   (aggregate sum ?qty (orden (cliente-id ?cliente-id) (qty ?qty)) > 5)
   =>
   (printout t "Cliente que compró más de 5 productos: " ?nombre " (ID: " ?cliente-id ")." crlf))

;; Regla para mostrar clientes mayoristas y menudistas.
(defrule mostrar-clientes-por-tipo
   (cliente (id ?cliente-id) (nombre ?nombre) (tipo ?tipo))
   =>
   (printout t "Cliente: " ?nombre " (ID: " ?cliente-id "), Tipo: " ?tipo "." crlf))

