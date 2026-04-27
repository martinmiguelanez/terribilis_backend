package com.terribilis.store.controllers;

import com.terribilis.store.entities.TaxonomicFamily;
import com.terribilis.store.repositories.TaxonomicFamilyRepository;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/taxonomic")
@CrossOrigin("*")
public class TaxonomicFamilyController {

    private final TaxonomicFamilyRepository repository;

    public TaxonomicFamilyController(TaxonomicFamilyRepository repository) {
        this.repository = repository;
    }

    @GetMapping
    public List<TaxonomicFamily> getAll() {
        return repository.findAll();
    }
}
