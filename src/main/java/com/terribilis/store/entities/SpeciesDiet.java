package com.terribilis.store.entities;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "species_diet")
@Data
public class SpeciesDiet {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String frecuencia;
    private String observaciones;

    @ManyToOne
    @JoinColumn(name = "species_id")
    @JsonBackReference 
    private Species species;

    @ManyToOne
    @JoinColumn(name = "diet_type_id")
    private DietType dietType;

    @OneToMany(mappedBy = "speciesDiet", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DietFood> dietFoods;
}
