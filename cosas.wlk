object knightRider {

	method peso() = 500
	method nivelPeligrosidad() = 10
	method bulto() = 1
	// Efecto del accidente: No hace nada.
	method sufrirAccidente() {} 
}

object arenaDeGranel {

	var property peso = 0
	method nivelPeligrosidad() = 1
	method bulto() = 1
	// Efecto del accidente: Aumenta su peso en 20kg.
	method sufrirAccidente() { peso += 20 } 

}

object bumblebee {

	var estaTransformado = false // false = Auto, true = Robot
	method peso() = 800
	// Peligrosidad: 15 si es auto, 30 si es robot.
	method nivelPeligrosidad() = if (estaTransformado) 30 else 15
	method bulto() = 2
	method transformarEnAuto() { estaTransformado = false }
	method transformarEnRobot() { estaTransformado = true }
	// Efecto del accidente: Cambia de modo (auto <-> robot).
	method sufrirAccidente() { estaTransformado = !estaTransformado } 

}


object paqueteDeLadrillos {

	var property cantidad = 0
	// Cada ladrillo pesa 2kg
	method peso() = (cantidad.max(0) * 2)
	method nivelPeligrosidad() = 2
	// Bultos: Escala según la cantidad (1, 2 o 3).
	method bulto() = if (cantidad <= 100) 1 else if (cantidad <= 300) 2 else 3
	// Efecto del accidente: Pierde hasta 12 ladrillos.
	method sufrirAccidente() { cantidad = 0.max(cantidad - 12)} 

}

object bateriaAntiaerea {

	var tieneMisiles = false
	// Peso y Peligrosidad: Cambian según si tiene misiles cargados.
	method peso() = if (tieneMisiles) 300 else 200
	method bulto() = if (tieneMisiles) 2 else 1
	method nivelPeligrosidad() = if (tieneMisiles) 100 else 0
	method cargarMisiles() { tieneMisiles = true }
	method descargarMisiles() { tieneMisiles = false }
	// Efecto del accidente: Descarga los misiles.
	method sufrirAccidente() { self.descargarMisiles()} 
}

object contenedorPortuario {

	const cosasDentro = #{}
	method agregarCosa(cosa) { cosasDentro.add(cosa) }
	// Peso: 100 de base + suma de lo que tiene adentro.
	method peso() = 100 + cosasDentro.sum({ c => c.peso() })
	// Peligrosidad: La del objeto más peligroso que contiene (o 0 si está vacío).
	method nivelPeligrosidad() = if (cosasDentro.isEmpty()) 0 else cosasDentro.max({ c => c.nivelPeligrosidad() }).nivelPeligrosidad()
	// Bultos: 1 + la suma de los bultos de su interior.
	method bulto() = 1 + cosasDentro.sum({ c => c.bulto() })
	// Efecto del accidente: Todas las cosas dentro sufren el accidente.
	method sufrirAccidente() { cosasDentro.forEach({ c => c.sufrirAccidente() }) }
}

object residuosRadiactivos {

	var property peso = 0
	method nivelPeligrosidad() = 200
	method bulto() = 1
	// Efecto del accidente: Aumenta su peso en 15kg.
	method sufrirAccidente() { peso += 15 } 
}

object embalajeDeSeguridad {

	var property cosaEnvuelta = null
	method peso() = cosaEnvuelta.peso()
	// Peligrosidad: La mitad de lo que envuelve.
	method nivelPeligrosidad() = cosaEnvuelta.nivelPeligrosidad() / 2
	method bulto() = 2
	// Efecto del accidente: No hace nada.
	method sufrirAccidente() {}
	 
}