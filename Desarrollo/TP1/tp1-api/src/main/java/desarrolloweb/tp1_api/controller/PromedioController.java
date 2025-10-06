package desarrolloweb.tp1_api.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/ejercicio2")
public class PromedioController {
    /**
     * Método que calcula el promedio de los valores (notas) enviadas en la query string
     * 
     * @param nota1
     * @param nota2
     * @param nota3
     * @return string con el resultado del promedio
     */
    @GetMapping("/")
    public String calcularPromedio(@RequestParam double nota1, @RequestParam double nota2, @RequestParam double nota3) {
        double promedio = (nota1 + nota2 + nota3) / 3;
        return String.format("El promedio de las notas es: %.2f", promedio);
    }
}
