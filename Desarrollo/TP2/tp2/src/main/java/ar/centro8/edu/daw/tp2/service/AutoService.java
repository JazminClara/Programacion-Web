package ar.centro8.edu.daw.tp2.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ar.centro8.edu.daw.tp2.model.Auto;
import ar.centro8.edu.daw.tp2.repository.IAutoRepository;

@Service
public class AutoService implements IAutoService{
    @Autowired
    private IAutoRepository autoRepo;

    @Override
    public List<Auto> getAutos() {
        List<Auto> listaAutos = autoRepo.findAll();
        return listaAutos; 
    }

    @Override
    public void saveAuto(Auto auto) {
        autoRepo.save(auto);
    }

    @Override
    public void deleteAuto(int id) {
        autoRepo.deleteById(id);    
    }

    @Override
    public Auto findAuto(int id) {
        Auto auto = autoRepo.findById(id).orElse(null);
        return auto;
    }

    @Override
    public void editAuto(int idOriginal, int idNuevo, String marca, String modelo) {
        Auto auto = this.findAuto(idOriginal);

        auto.setId(idNuevo);
        auto.setMarca(marca);
        auto.setModelo(modelo);

        this.saveAuto(auto);
    }  
}
