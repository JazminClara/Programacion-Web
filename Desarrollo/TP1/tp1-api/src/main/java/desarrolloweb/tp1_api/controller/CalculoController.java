package desarrolloweb.tp1_api.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/ejercicio1")
public class CalculoController {
    /**
     * Método que hacer la conversión de galones a litros
     * Donde 1 galón = 3,78541 litros
     * 
     * @param galones
     * @return string con la equivalencia en litros
     */
    @GetMapping("/")
    public String convertirCombustible(@RequestParam double galones) {
        double litros = galones * 3.78541;
        return String.format("Cantidad de litros que necesitas: %.2f ltrs", litros);
    }
}
