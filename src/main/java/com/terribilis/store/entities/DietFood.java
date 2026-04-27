package com.terribilis.store.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "diet_food")
@Data
public class DietFood {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    private Double porcentaje;

    @ManyToOne
    @JoinColumn(name = "species_diet_id")
    @JsonIgnore
    private SpeciesDiet speciesDiet;

    @ManyToOne
    @JoinColumn(name = "food_id")
    private Food food;
}
