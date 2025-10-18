package ar.centro8.edu.daw.tp2.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ar.centro8.edu.daw.tp2.model.Auto;

@Repository
public interface IAutoRepository extends JpaRepository<Auto, Integer> {

}
