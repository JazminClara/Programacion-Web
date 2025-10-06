package desarrolloweb.tp1_api.controller;

import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import desarrolloweb.tp1_api.model.Paciente;

@RestController
@RequestMapping("/ejercicio4")
public class PacienteController {
    List<Paciente> listaPacientes = new ArrayList<Paciente>();

    // Utilizo el constructor como forma de carga, de objetos, a la lista. Ya spring
    // lo hace una vez que se llama al controller
    public PacienteController() {
        listaPacientes.add(new Paciente(1, "Juan", "Pérez", "38345678", LocalDate.of(1993, 2, 18)));
        listaPacientes.add(new Paciente(2, "María", "Gómez", "46654321", LocalDate.of(2015, 10, 30)));
        listaPacientes.add(new Paciente(3, "Carlos", "López", "42223344", LocalDate.of(1999, 12, 10)));
        listaPacientes.add(new Paciente(4, "Ana", "Martínez", "49332211", LocalDate.of(2019, 5, 15)));
        listaPacientes.add(new Paciente(5, "Luis", "Rodríguez", "44667788", LocalDate.of(2000, 9, 20)));
    }

    /**
     * Método que devuelve la lista completa de pacientes
     * 
     * @return lista de pacientes
     */
    @GetMapping("/pacientes")
    public List<Paciente> listarPacientes() {
        return listaPacientes;
    }

    /**
     * Método que devuelve la lista de pacientes menores de 18 años
     * 
     * @return lista de pacientes menores de 18 años
     */
    @GetMapping("/pacientes-menores")
    public List<Paciente> listarPacientesMenores() {
        List<Paciente> listaMenores = new ArrayList<>();
        for (Paciente l : listaPacientes) {
            if (Period.between(l.getFechaNacimiento(), LocalDate.now()).getYears() < 18) {
                listaMenores.add(l);
            }
        }
        return listaMenores;
    }
}
