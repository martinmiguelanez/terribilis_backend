package com.terribilis.store.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "habitat")
@Data
public class Habitat {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String tipo;
    
    @Column(name = "tamano_minimo_cm")
    private String tamanoMinimoCm;
    
    private String sustrato;
    private String decoracion;
    private String enriquecimiento;
    
    @OneToOne 
    @JoinColumn(name = "species_id")
    @JsonBackReference
    private Species species;
}
