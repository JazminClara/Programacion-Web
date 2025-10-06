package desarrolloweb.tp1_api.model;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Paciente {
    private int idPaciente;
    private String nombre;
    private String apellido;
    private String dni;
    private LocalDate fechaNacimiento;
}