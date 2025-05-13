(deffacts hechos-iniciales
   ;; Hechos para probar las reglas de promociones y validaciones

   ;; Smartphones
   (smartphone (id 1) (marca apple) (modelo iPhone16) (color negro) (precio 18000) (almacenamiento 128) (stock 10) (en-promocion FALSE))
   (smartphone (id 2) (marca samsung) (modelo Note21) (color blanco) (precio 25000) (almacenamiento 256) (stock 15) (en-promocion FALSE))

   ;; Computadoras
   (computadora (id 3) (marca apple) (modelo MacBookAir) (tipo laptop) (color gris) (precio 25000) (almacenamiento 512) (ram 8) (sistema-operativo macOS) (procesador M1) (stock 5) (en-promocion FALSE))
   (computadora (id 4) (marca apple) (modelo MacBookPro) (tipo laptop) (color plata) (precio 35000) (almacenamiento 1024) (ram 32) (sistema-operativo macOS) (procesador M2) (stock 3) (en-promocion FALSE))

   ;; Accesorios
   (accesorio (id 5) (tipo funda) (marca apple) (modelo funda-iPhone16) (color negro) (precio 500) (descuento 0))
   (accesorio (id 6) (tipo mica) (marca apple) (modelo mica-iPhone16) (color transparente) (precio 300) (descuento 0))
   (accesorio (id 7) (tipo audífonos) (marca samsung) (modelo galaxy-buds) (color negro) (precio 2000) (descuento 0))
   (accesorio (id 8) (tipo cargador) (marca samsung) (modelo cargador-rapido) (color blanco) (precio 1500) (descuento 0))

   ;; Clientes
   (cliente (id 1) (nombre "Juan Pérez") (tipo menudista) (telefono "1234567890"))
   (cliente (id 2) (nombre "María López") (tipo mayorista) (telefono "0987654321"))

   ;; Órdenes
   (orden (id 105) (cliente-id 2) (prod-id 1) (pago-id 201) (qty 1) (forma-pago tarjeta) (total 18000))
   (orden (id 106) (cliente-id 1) (prod-id 2) (pago-id 202) (qty 1) (forma-pago tarjeta) (total 25000))
   (orden (id 107) (cliente-id 1) (prod-id 3) (pago-id 201) (qty 1) (forma-pago contado) (total 25000))
   (orden (id 108) (cliente-id 2) (prod-id 4) (pago-id 202) (qty 1) (forma-pago tarjeta) (total 35000))
   (orden (id 109) (cliente-id 2) (prod-id 7) (pago-id 202) (qty 2) (forma-pago contado) (total 4000))
   (orden (id 110) (cliente-id 1) (prod-id 5) (pago-id 201) (qty 3) (forma-pago contado) (total 1500))
   (orden (id 111) (cliente-id 2) (prod-id 6) (pago-id 202) (qty 5) (forma-pago contado) (total 1500))
   (orden (id 112) (cliente-id 1) (prod-id 8) (pago-id 201) (qty 1) (forma-pago contado) (total 1500))

   ;; Tarjetas de crédito
   (tarjetacred (id 201) (banco banamex) (grupo VISA) (titular "Juan Pérez") (exp-date "12/25"))
   (tarjetacred (id 202) (banco liverpool) (grupo VISA) (titular "María López") (exp-date "11/24"))

   ;; Vales
   (vale (id 301) (cliente-id 1) (cantidad 500) (fecha-emision "2023-01-01"))
)
