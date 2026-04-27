package com.terribilis.store.controllers;

import com.terribilis.store.entities.Species;
import com.terribilis.store.repositories.SpeciesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class SpeciesController {

    @Autowired
    private SpeciesRepository speciesRepository;

    @GetMapping("/especies")
    public List<Species> getAllSpecies() {
        return speciesRepository.findAll();
    }

    @PostMapping("/especies")
    @Transactional
    public ResponseEntity<Species> createSpecies(@RequestBody Species species) {
        try {
            // 1. Forzar IDs a null para evitar conflictos de "Llave Duplicada"
            species.setId(null); 
            if (species.getBrumation() != null) species.getBrumation().setId(null);
            if (species.getHabitat() != null) species.getHabitat().setId(null);
            if (species.getEnvironment() != null) species.getEnvironment().setId(null);
            if (species.getNaturalHabitat() != null) species.getNaturalHabitat().setId(null);
            
            // 2. Vincular Objetos 1:1 y limpiar IDs
            if (species.getEnvironment() != null) species.getEnvironment().setSpecies(species);
            if (species.getHabitat() != null) species.getHabitat().setSpecies(species);
            if (species.getNaturalHabitat() != null) species.getNaturalHabitat().setSpecies(species);
            if (species.getBrumation() != null) species.getBrumation().setSpecies(species);

            // 3. Vincular y limpiar Listas (IMPORTANTE para tu error actual)
            if (species.getImages() != null) {
                species.getImages().forEach(i -> {
                    i.setId(null); 
                    i.setSpecies(species);
                });
            }
            
            if (species.getDiets() != null) {
                species.getDiets().forEach(d -> {
                    d.setId(null);
                    d.setSpecies(species); 
                    if (d.getDietFoods() != null) {
                        d.getDietFoods().forEach(df -> {
                            df.setId(null);
                            df.setSpeciesDiet(d);
                        });
                    }
                });
            }

            if (species.getHealthIssues() != null) {
                species.getHealthIssues().forEach(h -> {
                    h.setId(null); // Esto soluciona el error de "species_health_pkey"
                    h.setSpecies(species);
                });
            }
            
            if (species.getSupplements() != null) {
                species.getSupplements().forEach(s -> {
                    s.setId(null);
                    s.setSpecies(species);
                });
            }

            // 4. Guardar en la base de datos
            Species saved = speciesRepository.save(species);
            return new ResponseEntity<>(saved, HttpStatus.CREATED);

        } catch (Exception e) {
            System.err.println("Error al guardar especie: " + e.getMessage());
            e.printStackTrace(); 
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}