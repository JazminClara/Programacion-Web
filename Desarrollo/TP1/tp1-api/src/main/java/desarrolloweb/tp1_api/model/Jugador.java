package desarrolloweb.tp1_api.model;

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
public class Jugador {
    private int idJugador;
    private String dni;
    private String nombre;
    private int edad;
    private double peso;
    private double estatura;
}
