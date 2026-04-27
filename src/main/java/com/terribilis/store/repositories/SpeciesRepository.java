package com.terribilis.store.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.terribilis.store.entities.Species;

public interface SpeciesRepository extends JpaRepository<Species, Integer>{

}
