package com.terribilis.store.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "species_supplement")
@Data
public class SpeciesSupplement {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "species_id")
    @JsonBackReference
    private Species species;

    @ManyToOne
    @JoinColumn(name = "supplement_id")
    private Supplement supplement;

    private String observaciones;
}

