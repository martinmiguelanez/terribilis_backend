package com.terribilis.store.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "natural_habitat")
@Data
public class NaturalHabitat {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String region;
    private String clima;
    private String bioma;
    private String altitud;

    @OneToOne
    @JoinColumn(name = "species_id")
    @JsonBackReference
    private Species species;
}
