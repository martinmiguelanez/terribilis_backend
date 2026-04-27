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
@Table(name = "brumation")
@Data
public class Brumation {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private Boolean requiere;
    private String meses;
    private Double temperaturaMin;
    private Double temperaturaMax;
    private String descripcion;

    @OneToOne
    @JoinColumn(name = "species_id")
    @JsonBackReference
    private Species species;
}
