package ar.centro8.edu.daw.tp2.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import ar.centro8.edu.daw.tp2.model.Auto;
import ar.centro8.edu.daw.tp2.service.IAutoService;

@RestController
@CrossOrigin(origins = "*", methods = { RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT,
        RequestMethod.DELETE })
public class AutoController {
    @Autowired
    private IAutoService autoService;

    @GetMapping("/autos/obtener")
    public List<Auto> getAutos() {
        return autoService.getAutos();
    }

    @PostMapping("/autos/crear")
    public String saveAuto(@RequestBody Auto auto) {
        autoService.saveAuto(auto);
        return "Auto registrado exitosamente";
    }

    @DeleteMapping("/autos/borrar/{id}")
    public String deleteAuto(@PathVariable int id) {
        autoService.deleteAuto(id);
        return "Auto eliminado exitosamente";
    }

    @PutMapping("/autos/editar/{idOriginal}")
    public Auto editAuto(@PathVariable int idOriginal,
            @RequestParam(required = false, name = "id") int idNuevo,
            @RequestParam(required = false, name = "marca") String marcaNuevo,
            @RequestParam(required = false, name = "modelo") String modeloNuevo) {

        autoService.editAuto(idOriginal, idNuevo, marcaNuevo, modeloNuevo);
        Auto autoNuevo = autoService.findAuto(idNuevo);
        return autoNuevo;
    }

    @GetMapping("/autos/obtener-auto/{id}")
    public Auto getAuto(@PathVariable int id) {
        Auto auto = autoService.findAuto(id);
        return auto;
    }
}
