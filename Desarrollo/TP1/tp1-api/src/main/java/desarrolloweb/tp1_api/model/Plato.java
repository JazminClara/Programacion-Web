package desarrolloweb.tp1_api.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Plato {
    private int nroPlato;
    private String nombre;
    private double precio;
    private String descripcion;
}
