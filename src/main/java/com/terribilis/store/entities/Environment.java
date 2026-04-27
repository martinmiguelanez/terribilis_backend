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
@Table(name = "environment")
@Data
public class Environment {
	
    @Id 
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Integer temperaturaDiaMin;
    private Integer temperaturaDiaMax;
    private Integer temperaturaNocheMin;
    private Integer temperaturaNocheMax;
    private Integer humedadMin;
    private Integer humedadMax;
    private Boolean uvbRequerido;
    private Integer horasLuz;
    
    @OneToOne 
    @JoinColumn(name = "species_id")
    @JsonBackReference
    private Species species;
}
