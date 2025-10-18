package ar.centro8.edu.daw.tp2.service;

import java.util.List;
import ar.centro8.edu.daw.tp2.model.Auto;

public interface IAutoService {
    public List<Auto> getAutos();

    public void saveAuto(Auto auto);

    public void deleteAuto(int id);

    public Auto findAuto(int id);
    
    public void editAuto(int idOriginal, int idNuevo, String marca, String modelo);
}
