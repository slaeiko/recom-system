(facts)

;; 1 En la compra de un iPhone 16 con tarjetas Banamex, ofrece 24 meses sin intereses.
(defrule promocion-iphone16-banamex
   ?orden <- (orden (id ?id)
                    (prod-id ?prod-id)
                    (pago-id ?pago-id)
                    (forma-pago tarjeta))
   ?metodo-pago <- (tarjetacred (id ?pago-id)
                    (banco banamex))
   ?producto <- (smartphone (id ?prod-id)
                            (marca apple)
                            (modelo iPhone16))
   =>
   (printout t "Promoción aplicada: 24 meses sin intereses con tarjeta Banamex para el iPhone 16. No. Orden " ?id crlf))

;; 2 En la compra de un Samsung Note 21 con tarjeta de Liverpool VISA, ofrece 12 meses sin intereses.
(defrule promocion-samsung-note21-liverpool
   ?orden <- (orden (id ?id)
                    (prod-id ?prod-id)
                    (forma-pago tarjeta))
   ?metodo-pago <- (tarjetacred (id ?pago-id)
                    (banco liverpool)
                    (grupo VISA))
   ?producto <- (smartphone (id ?prod-id)
                            (marca samsung)
                            (modelo Note21))
   =>
   (printout t "Promoción aplicada: 12 meses sin intereses con tarjeta Liverpool VISA para el Samsung Note 21. No. Orden " ?id crlf))

;; 3 En la compra al contado de una MacBook Air y un iPhone 16, ofrecer 100 pesos en vales por cada 1000 pesos de compra.
(defrule promocion-macbookair-iphone16
   ?orden1 <- (orden (id ?id1)
                     (prod-id ?prod-id1)
                     (forma-pago contado)
                     (total ?total1)
                     (cliente-id ?cliente-id))
   ?producto1 <- (smartphone (id ?prod-id1)
                             (marca apple)
                             (modelo iPhone16))
   ?orden2 <- (orden (id ?id2)
                     (prod-id ?prod-id2)
                     (forma-pago contado)
                     (total ?total2)
                     (cliente-id ?cliente-id)) ;; Validar que sea el mismo cliente
   ?producto2 <- (computadora (id ?prod-id2)
                              (marca apple)
                              (modelo MacBookAir))
   =>
   (bind ?total (+ ?total1 ?total2)) ;; Calcular el total combinado
   (bind ?vales (* (integer (/ ?total 1000)) 100)) ;; Calcular los vales obtenidos
   (printout t "Promoción aplicada: 100 pesos en vales por cada 1000 pesos de compra al contado de una MacBook Air y un iPhone 16." crlf)
   (printout t "Órdenes que activaron la promoción: ID " ?id1 " y ID " ?id2 crlf)
   ;;(printout t "Cliente ID: " ?cliente-id crlf)
   (printout t "Total en vales obtenidos: $" ?vales crlf))

;; 4 Si el cliente compra un Smartphone, ofrecer una funda y mica con un 15% de descuento sobre accesorios.
(defrule promocion-accesorios-smartphone
   ?orden <- (orden (id ?id)
                    (prod-id ?prod-id))
   ?smartphone <- (smartphone (id ?prod-id))
   =>
   (printout t "Promo: 15% de descuento en funda y mica al comprar un Smartphone." crlf)
   (printout t "Orden que activó la promoción: ID " ?id crlf))

;; 5 Si el cliente compra un accesorio con un descuento mayor al 10%, validar que el ID del accesorio coincida con el de la orden e imprimir un mensaje indicando el ahorro.
(defrule promocion-accesorio-descuento
   ?orden <- (orden (id ?orden-id)
                    (prod-id ?prod-id))
   ?accesorio <- (accesorio (id ?prod-id)
                            (descuento ?descuento&:(> ?descuento 10)))
   =>
   (printout t "Promoción aplicada: El accesorio con ID " ?prod-id " en la orden ID " ?orden-id " tiene un descuento del " ?descuento "%." crlf))
   
;; 6 Si el cliente compra una computadora con más de 16GB de RAM, ofrecer un mouse gratis.
(defrule promocion-computadora-ram
   ?orden <- (orden (id ?orden-id)
                     (prod-id ?prod-id))
   ?computadora <- (computadora (id ?prod-id)
                                 (ram ?ram&:(> ?ram 16)))
   =>
   (printout t "Promoción aplicada: La computadora con ID " ?prod-id " en la orden ID " ?orden-id " incluye un mouse gratis por tener más de 16GB de RAM." crlf))

;; 7 Si el cliente compra un smartphone y una computadora, validar que ambos sean de la misma marca, no estén en promoción, y pertenezcan al mismo cliente, y ofrecer un 10% de descuento en el total.
(defrule promocion-smartphone-computadora-misma-marca
   ?orden1 <- (orden (id ?id1)
                     (prod-id ?prod-id1)
                     (total ?total1)
                     (cliente-id ?cliente-id))
   ?orden2 <- (orden (id ?id2)
                     (prod-id ?prod-id2)
                     (total ?total2)
                     (cliente-id ?cliente-id)) ;; Validar que ambas órdenes sean del mismo cliente
   ?smartphone <- (smartphone (id ?prod-id1)
                              (marca ?marca)
                              (en-promocion FALSE))
   ?computadora <- (computadora (id ?prod-id2)
                                (marca ?marca)
                                (en-promocion FALSE))
   =>
   (bind ?total (+ ?total1 ?total2)) ;; Calcular el total combinado
   (bind ?descuento (* ?total 0.10)) ;; Calcular el 10% de descuento
   (printout t "Promoción aplicada: 10% de descuento en el total por comprar un smartphone y una computadora de la marca " ?marca "." crlf)
   (printout t "Órdenes que activaron la promoción: ID " ?id1 " y ID " ?id2 crlf)
   (printout t "Cliente ID: " ?cliente-id crlf)
   (printout t "Descuento total: $" ?descuento crlf))

;; 8 Si el cliente es mayorista y compra más de 10 unidades de cualquier producto, ofrecer un 5% de descuento adicional.
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

;; Si el cliente compra una computadora con sistema operativo macOS, validar que el ID del producto de la orden sea una computadora con macOS y ofrecer un descuento del 10% en accesorios Apple.
(defrule promocion-computadora-macos
   ?orden <- (orden (id ?orden-id)
                    (prod-id ?prod-id))
   ?computadora <- (computadora (id ?prod-id)
                                (sistema-operativo macOS))
   =>
   (printout t "Promoción aplicada: 10% de descuento en accesorios Apple para la computadora con ID " ?prod-id " en la orden ID " ?orden-id " con macOS." crlf))

;; Si el cliente compra una computadora con un precio mayor a $20,000, ofrecer un descuento del 15% en software adicional.
(defrule promocion-computadora-premium
   ?orden <- (orden (id ?orden-id)
                    (prod-id ?prod-id))
   ?computadora <- (computadora (id ?prod-id)
                                (precio ?precio&:(> ?precio 20000)))
   =>
   (printout t "Promoción aplicada: 15% de descuento en software adicional para la computadora con ID " ?prod-id " en la orden ID " ?orden-id " con precio de $" ?precio "." crlf))

;; Regla 12: Si el cliente compra un smartphone y un accesorio de audio (audífonos o bocina), ofrecer un descuento del 10% en el accesorio, siempre que el accesorio no tenga descuento.
(defrule promocion-smartphone-audio
   ?orden-smartphone <- (orden (id ?id1)
                               (prod-id ?prod-id1)
                               (cliente-id ?cliente-id))
   ?smartphone <- (smartphone (id ?prod-id1))
   ?orden-accesorio <- (orden (id ?id2)
                              (prod-id ?prod-id2)
                              (cliente-id ?cliente-id)) ;; Validar que sea el mismo cliente
   ?accesorio <- (accesorio (id ?prod-id2)
                            (tipo ?tipo&:(or (eq ?tipo "audífonos") (eq ?tipo "bocina")))
                            (descuento ?descuento&:(= ?descuento 0))
                            (precio ?precio))
   =>
   (bind ?ahorro (* ?precio 0.10)) ;; Calcular el 10% de descuento
   (printout t "Promoción aplicada: 10% de descuento en el accesorio de audio (ID " ?prod-id2 ") por la compra del smartphone con ID " ?prod-id1 "." crlf)
   (printout t "Cliente ID: " ?cliente-id "." crlf)
   (printout t "Ahorro total: $" ?ahorro "." crlf))

;; Si el cliente compra un smartphone con un precio mayor a $15,000, ofrecer un seguro contra robo gratis.
(defrule promocion-smartphone-seguro-robo
   ?orden <- (orden (id ?orden-id)
                    (prod-id ?prod-id))
   ?smartphone <- (smartphone (id ?prod-id)
                              (precio ?precio&:(> ?precio 15000)))
   =>
   (printout t "Promoción aplicada: Seguro contra robo gratis para el smartphone con ID " ?prod-id " en la orden ID " ?orden-id " con precio de $" ?precio "." crlf))
   
;; Si el cliente compra una computadora y un smartphone de marcas diferentes, ofrecer un descuento del 5% en el total.
(defrule promocion-computadora-smartphone-marcas-diferentes
   ?orden1 <- (orden (id ?id1)
                     (prod-id ?prod-id1)
                     (total ?total1)
                     (cliente-id ?cliente-id))
   ?computadora <- (computadora (id ?prod-id1)
                                 (marca ?marca1))
   ?orden2 <- (orden (id ?id2)
                     (prod-id ?prod-id2)
                     (total ?total2)
                     (cliente-id ?cliente-id)) ;; Validar que ambas órdenes sean del mismo cliente
   ?smartphone <- (smartphone (id ?prod-id2)
                              (marca ?marca2&:(neq ?marca1 ?marca2)))
   =>
   (bind ?total (+ ?total1 ?total2)) ;; Calcular el total combinado
   (bind ?ahorro (* ?total 0.05))   ;; Calcular el 5% de descuento
   (printout t "Promoción aplicada: 5% de descuento en el total por comprar una computadora (ID " ?id1 ") y un smartphone (ID " ?id2 ") de marcas diferentes." crlf)
   (printout t "Cliente ID: " ?cliente-id "." crlf)
   (printout t "Ahorro total: $" ?ahorro "." crlf))

;; Si el cliente compra un smartphone y un accesorio de carga (cargador o batería externa), validar que los IDs de los productos correspondan y ofrecer un descuento del 6% en el accesorio, siempre que el accesorio no tenga descuento.
(defrule promocion-smartphone-carga
   ?orden-smartphone <- (orden (id ?id1)
                               (prod-id ?prod-id1)
                               (cliente-id ?cliente-id))
   ?smartphone <- (smartphone (id ?prod-id1))
   ?orden-accesorio <- (orden (id ?id2)
                              (prod-id ?prod-id2)
                              (cliente-id ?cliente-id)) ;; Validar que sea el mismo cliente
   ?accesorio <- (accesorio (id ?prod-id2)
                            (tipo ?tipo&:(or (eq ?tipo "cargador") (eq ?tipo "batería externa")))
                            (descuento ?descuento&:(= ?descuento 0))
                            (precio ?precio))
   =>
   (bind ?ahorro (* ?precio 0.06)) ;; Calcular el 6% de descuento
   (printout t "Promoción aplicada: 6% de descuento en el accesorio de carga (ID " ?prod-id2 ") por la compra del smartphone con ID " ?prod-id1 "." crlf)
   (printout t "Cliente ID: " ?cliente-id "." crlf)
   (printout t "Ahorro total: $" ?ahorro "." crlf))

;; Si el cliente compra una computadora con almacenamiento mayor a 1TB, ofrecer un descuento del 20% en discos duros externos.
(defrule promocion-computadora-almacenamiento
   ?orden <- (orden (id ?orden-id)
                    (prod-id ?prod-id))
   ?computadora <- (computadora (id ?prod-id)
                                (almacenamiento ?almacenamiento&:(> ?almacenamiento 1024)))
   =>
   (printout t "Promoción aplicada: 20% de descuento en discos duros externos para la computadora con ID " ?prod-id " en la orden ID " ?orden-id " con almacenamiento de " ?almacenamiento "GB." crlf))

;; Si el cliente compra una MacBook Pro con procesador M2 y más de 16GB de RAM, ofrecer un descuento del 15% en software de edición.
(defrule promocion-macbookpro-m2
   ?orden <- (orden (id ?orden-id)
                    (prod-id ?prod-id))
   ?computadora <- (computadora (id ?prod-id)
                                (marca apple)
                                (modelo MacBookPro)
                                (procesador M2)
                                (ram ?ram&:(> ?ram 16)))
   =>
   (printout t "Promoción aplicada: 15% de descuento en software de edición por la compra de la MacBook Pro con ID " ?prod-id " en la orden ID " ?orden-id " con procesador M2 y " ?ram "GB de RAM." crlf))

;; Si el cliente utiliza vales como método de pago y compra un smartphone con un precio mayor a $15,000, ofrecer un descuento adicional del 5% en el total.
(defrule promocion-smartphone-con-vales
   ?orden <- (orden (id ?id)
                    (prod-id ?prod-id)
                    (forma-pago vales)
                    (total ?total&:(> ?total 15000)))
   ?smartphone <- (smartphone (id ?prod-id))
   =>
   (bind ?descuento (* ?total 0.05)) ;; Calcular el 5% de descuento
   (printout t "Promoción aplicada: 5% de descuento adicional en el total por usar vales como método de pago en la compra del smartphone con ID " ?id " con un total de $" ?total "." crlf)
   (printout t "Ahorro total: $" ?descuento "." crlf))

;; Si el cliente utiliza vales como método de pago y compra una computadora con un precio mayor a $25,000 pero no mayor a $100,000, ofrecer un descuento adicional del 10%.
(defrule promocion-computadora-con-vales
   ?orden <- (orden (id ?id)
                    (prod-id ?prod-id)
                    (forma-pago vales)
                    (total ?total&:(and (> ?total 25000) (<= ?total 100000))))
   ?computadora <- (computadora (id ?prod-id))
   =>
   (bind ?descuento (* ?total 0.10)) ;; Calcular el 10% de descuento
   (printout t "Promoción aplicada: 10% de descuento adicional en el total por usar vales como método de pago en la compra de la computadora con ID " ?prod-id " en la orden ID " ?id " con un total de $" ?total "." crlf)
   (printout t "Ahorro total: $" ?descuento "." crlf))
   
;; Si el cliente compra un smartphone de la marca Samsung con un total mayor a $50,000 pagando de contado, ofrecer un bono de $5,000 para la próxima compra.
(defrule promocion-samsung-bono
   ?orden <- (orden (id ?id)
                    (prod-id ?prod-id)
                    (forma-pago contado)
                    (total ?total&:(> ?total 50000)))
   ?smartphone <- (smartphone (id ?prod-id)
                              (marca samsung))
   =>
   (printout t "Promoción aplicada: Bono de $5,000 para la próxima compra por adquirir un smartphone Samsung con un total mayor a $50,000 pagando de contado. Orden ID: " ?id "." crlf))

(defrule validar-mayorista
   ?cliente <- (cliente (id ?cliente-id)
                        (nombre ?nombre)
                        (tipo ?tipo&:(neq ?tipo mayorista)) ; Solo si NO es mayorista
                        (telefono ?telefono)) 
   ?orden <- (orden (id ?id)
                    (cliente-id ?cliente-id)
                    (qty ?qty&:(> ?qty 10)))
   =>
   (modify ?cliente (tipo mayorista)) ;; Actualizar el tipo a 'mayorista'
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
                    (prod-id ?prod-id)
                    (qty ?qty&:(> ?qty 10)))
   ?smartphone <- (smartphone (id ?prod-id))
   =>
   (printout t "Recomendación: Accesorios de protección (funda y mica) disponibles para la orden ID " ?id " con el smartphone ID " ?prod-id "." crlf))

;; Si el stock de un producto baja a menos de 5 unidades, recomendar reabastecimiento.
(defrule recomendar-reabastecimiento
   ?producto <- (smartphone (modelo ?modelo)
                            (almacenamiento ?almacenamiento&:(< ?almacenamiento 5)))
   =>
   (printout t "Recomendación: Reabastecer el modelo " ?modelo " ya que el stock es menor a 5 unidades." crlf))

;; Regla para encontrar clientes que no han comprado nada.
(defrule clientes-sin-compras
   (declare (salience -99))
   (cliente (id ?cliente-id) (nombre ?nombre))
   (not (orden (cliente-id ?cliente-id)))
   =>
   (printout t "Cliente sin compras: " ?nombre " (ID: " ?cliente-id ")." crlf))

;; Regla para encontrar productos comprados y la cantidad total considerando todas las órdenes.
(defrule productos-comprados-total
   (or (smartphone (id ?prod-id) (modelo ?modelo))
       (computadora (id ?prod-id) (modelo ?modelo))
       (accesorio (id ?prod-id) (modelo ?modelo)))
   =>
   (bind ?total-qty 0)
   (foreach ?orden (find-all-facts ((?orden orden)) (eq ?orden:prod-id ?prod-id))
      (bind ?total-qty (+ ?total-qty (fact-slot-value ?orden qty))))
   (if (> ?total-qty 0) then
      (printout t "PRODUCTOS VENDIDOS" crlf)
      (printout t "Id " ?prod-id " Modelo: " ?modelo ", Cantidad total: " ?total-qty "." crlf)))

;; Regla para encontrar clientes que compraron más de 5 productos.
(defrule clientes-mas-de-5-productos
   (cliente (id ?cliente-id) (nombre ?nombre))
   =>
   (bind ?total-qty 0)
   (do-for-all-facts ((?orden orden)) (eq (fact-slot-value ?orden cliente-id) ?cliente-id)
      (bind ?total-qty (+ ?total-qty (fact-slot-value ?orden qty))))
   (if (> ?total-qty 5)
      then
      (printout t "Cliente que compró más de 5 productos: " ?nombre " (ID: " ?cliente-id "). Total: " ?total-qty crlf)))

;; Regla para mostrar clientes mayoristas y menudistas.
(defrule mostrar-clientes-por-tipo
   (cliente (id ?cliente-id) (nombre ?nombre) (tipo ?tipo))
   =>
   (printout t "Cliente: " ?nombre " (ID: " ?cliente-id "), Tipo: " ?tipo "." crlf))

;; Actualizar e imprimir el stock después de una compra
(defrule actualizar-stock-smartphone
   (declare (salience -100))
   ?orden <- (orden (prod-id ?id) (qty ?qty))
   ?p <- (smartphone (id ?id)
                     (stock ?stock&:(>= ?stock ?qty)))
   =>
   (bind ?nuevo-stock (- ?stock ?qty))
   (modify ?p (stock ?nuevo-stock))

   (printout t "Stock actualizado: Smartphone ID " ?id
               " ahora tiene " ?nuevo-stock " unidades." crlf)
               (halt)(run))

(defrule actualizar-stock-computadora
   (declare (salience -100))
   ?orden <- (orden (prod-id ?id) (qty ?qty))
   ?p <- (computadora (id ?id)
                      (stock ?stock&:(>= ?stock ?qty)))
   =>
   (bind ?nuevo-stock (- ?stock ?qty))
   (modify ?p (stock ?nuevo-stock))
  
   (printout t "Stock actualizado: Computadora ID " ?id
               " ahora tiene " ?nuevo-stock " unidades." crlf)
               (halt)(run))
               
