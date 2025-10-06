package desarrolloweb.tp1_api.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import desarrolloweb.tp1_api.model.Jugador;

@RestController
@RequestMapping("/ejercicio5")
public class JugadorController {
    List<Jugador> listaJugadores = new ArrayList<>();

    /**
     * Método que recibe una lista de jugadores, los agrega a lista creada en el
     * Controller
     * y devuelve la estatura promedio de todos los jugadores
     * 
     * @param listaJugadores
     * @return String con la estatura promedio
     */
    @PostMapping("/jugadores")
    public String listarCacularEstaturaMedia(@RequestBody List<Jugador> listaJugadores) {
        this.listaJugadores.addAll(listaJugadores);
        double estaturaTotal = 0;
        for (Jugador l : this.listaJugadores) {
            estaturaTotal += l.getEstatura();
        }
        double promedio = estaturaTotal / this.listaJugadores.size();
        return String.format("La estatura promedio es: %.2f mtrs.", promedio);
    }
}
