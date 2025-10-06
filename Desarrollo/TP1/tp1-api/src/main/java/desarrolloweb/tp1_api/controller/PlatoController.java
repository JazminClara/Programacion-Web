package desarrolloweb.tp1_api.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import desarrolloweb.tp1_api.model.Plato;

@RestController
@RequestMapping("/ejercicio3")
public class PlatoController {
    /**
     * Busca en una lista un Plato, según el valor obtenido del path
     * 
     * @param nroPlato
     * @return retorna el objeto Plato que será codificado a JSON/null si no lo encuentra
     */
    @GetMapping("/{nroPlato}")
    public Plato obtenerPlato(@PathVariable int nroPlato) {
        List<Plato> listaPlatos = new ArrayList<Plato>();

        listaPlatos.add(new Plato(1, "Milanesa con papas fritas", 1500.00,
                "Milanesa de carne vacuna con guarnición de papas fritas"));
        listaPlatos.add(new Plato(2, "Hamburguesa con papas fritas", 1200.00,
                "Hamburguesa casera con guarnición de papas fritas"));
        listaPlatos.add(new Plato(3, "Pizza muzzarella", 1000.00, "Pizza de muzzarella con salsa de tomate y orégano"));
        listaPlatos
                .add(new Plato(4, "Ensalada César", 900.00, "Ensalada con lechuga, pollo, crutones y aderezo César"));
        listaPlatos
                .add(new Plato(5, "Spaghetti bolognesa", 1300.00, "Spaghetti con salsa bolognesa y queso parmesano"));

        for (Plato p : listaPlatos) {
            if (p.getNroPlato() == nroPlato) {
                return p;
            }
        }
        System.out.println("No se encontró el plato con número: " + nroPlato);
        return null;
    }
}
