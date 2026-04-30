import cosas.*

object camion {

	const property cosas = #{}
	const tara = 1000
	const pesoMaximo = 2500

	// Agrega una cosa 
	method cargar(unaCosa) {

		if (cosas.contains(unaCosa)) self.error("Ya está cargado")
		cosas.add(unaCosa)
	}

	// Quita una cosa 
	method descargar(unaCosa) {

		if (!cosas.contains(unaCosa)) self.error("No se encuentra la cosa")
		cosas.remove(unaCosa)
	}

	// Indica si todos los objetos cargados tienen peso par.
	method todoPesoPar() = cosas.all({ c => c.peso() % 2 == 0 })

	// Indica si hay alguna cosa con el peso exacto indicado.
	method hayAlgunaQuePesa(peso) = cosas.any({ c => c.peso() == peso })

	// Peso total: tara + suma de pesos de la carga.
	method pesoTotal() = tara + cosas.sum({ c => c.peso() })

	// Indica si el peso total supera los 2500kg.
	method hayExcesoDePeso() = self.pesoTotal() > pesoMaximo

	// Busca el primer objeto que coincida con el nivel de peligrosidad.
	method cosaDeNivel(nivel) = cosas.find({ c => c.nivelPeligrosidad() == nivel })

	// Filtra las cosas que superan cierto nivel de peligro.
	method cosasPeligrosas(nivel) = cosas.filter({ c => c.nivelPeligrosidad() > nivel })

	// Reutilizo el método anterior comparando con la peligrosidad de otro objeto.
	method cosasMasPeligrosasQue(otraCosa) = self.cosasPeligrosas(otraCosa.nivelPeligrosidad())

	// Valida peso y que ninguna cosa supere el límite de la ruta.
	method puedeCircular(nivelMaximo) = !self.hayExcesoDePeso() && cosas.all({ c => c.nivelPeligrosidad() <= nivelMaximo })

	// Indica si hay algo cuyo peso esté en el rango (min..max).
	method hayAlgoEntre(min, max) = cosas.any({ c => c.peso().between(min, max)})

	// Retorna el objeto con mayor peso de la carga.
	method laMasPesada() = if (cosas.isEmpty()) self.error("Camion vacio") else cosas.max({ c => c.peso() })

	// Retorna una lista con los valores de los pesos de cada cosa.
	method pesosDeCadaCosa() = cosas.map({ c => c.peso() })

	// Sumatoria total de bultos de la carga.
	method totalBultos() = cosas.sum({ c => c.bulto() })

	// Ejecuta el efecto del accidente en todas las cosas cargadas.
	method sufrirAccidente() { cosas.forEach({ c => c.sufrirAccidente() }) }

	// Valida el camino, transfiere la carga al destino y vacía el camión.
	method transportar(destino, camino) {
		if (!camino.puedePasar(self)) self.error("El camino no soporta el viaje")
		destino.recibirCarga(cosas)
		cosas.clear()
	}
}

// Destinos y Caminos 

object almacen {

	const property cosas = #{}
	// Agrega todas las cosas recibidas a su inventario.
	method recibirCarga(nuevasCosas) { cosas.addAll(nuevasCosas) }
}

object ruta9 {

	// Soporta el viaje si el camión cumple el chequeo de peligrosidad 20.
	method puedePasar(unCamion) = unCamion.puedeCircular(20)
}

object caminosVecinales {

	var property pesoMaximoSoportado = 2000
	// Soporta el viaje si el peso total del camión no supera su límite.
	method puedePasar(unCamion) = unCamion.pesoTotal() <= pesoMaximoSoportado
	
}