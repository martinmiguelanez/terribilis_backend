package com.terribilis.store.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "species_health")
@Data
public class SpeciesHealth {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String prevencion;

    @ManyToOne
    @JoinColumn(name = "species_id")
    @JsonBackReference
    private Species species;

    @ManyToOne
    @JoinColumn(name = "health_issue_id")
    private HealthIssue healthIssue;
}
