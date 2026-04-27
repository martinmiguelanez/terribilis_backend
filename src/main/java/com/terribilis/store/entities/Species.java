package com.terribilis.store.entities;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import jakarta.persistence.*;
import lombok.Data;

/**
 * Entidad principal que representa a un animal en la tienda.
 * Centraliza toda la información taxonómica, de cuidados, salud y alimentación.
 */
@Entity
@Table(name = "species") // Se conecta con la tabla 'species' de PostgreSQL
@JsonPropertyOrder({ 
    "id", 
    "nombreComun", 
    "nombreCientifico", 
    "familiaCompleta",
    "descripcion", 
    "origen", 
    "dificultad",
    "peligrosidad",
    "esperanzaVida",
    "tamanoPromedioCm",
    "pesoPromedioGramos",
    "actividad",
    "taxonomicFamily",
    "naturalHabitat",
    "habitat",
    "environment",
    "brumation",
    "diets",
    "healthIssues",
    "images"
})
@Data
public class Species {
	
    // --- ATRIBUTOS BÁSICOS ---
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // ID autoincremental
    private Integer id;
	
    private String nombreComun;    // Ej: Dragón Barbudo
    private String nombreCientifico; // Ej: Pogona vitticeps
    private String descripcion;     // Texto libre sobre el animal
    private String origen;          // Ej: Australia
    private Integer esperanzaVida;  // Años aproximados
    
    @Column(name = "tamano_promedio_cm")
    private Integer tamanoPromedioCm;
    
    private Integer pesoPromedioGramos;
    private String actividad;       // Diurno, nocturno, crepuscular
    private String peligrosidad;    // Docil, agresivo, veneno...
    private String dificultad;      // Principiante, Experto...
    
    // --- RELACIONES TAXONÓMICAS ---
    
    // Muchos animales pertenecen a una misma Familia
    @ManyToOne 
    @JoinColumn(name = "family_id")
    private TaxonomicFamily taxonomicFamily;


    @OneToOne(mappedBy = "species", cascade = CascadeType.ALL)
    private Environment environment;

    @OneToOne(mappedBy = "species", cascade = CascadeType.ALL)
    private Habitat habitat;

    @OneToOne(mappedBy = "species", cascade = CascadeType.ALL)
    private NaturalHabitat naturalHabitat;

    @OneToOne(mappedBy = "species", cascade = CascadeType.ALL)
    private Brumation brumation;

    // --- RELACIONES DE LISTAS ---

    @OneToMany(mappedBy = "species", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<SpeciesImage> images;

    @OneToMany(mappedBy = "species", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<SpeciesDiet> diets;

    @OneToMany(mappedBy = "species", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<SpeciesHealth> healthIssues;

    @OneToMany(mappedBy = "species", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<SpeciesSupplement> supplements;
    
    @JsonProperty("familiaCompleta")
    public String getFamiliaCompleta() {
        if (taxonomicFamily != null && 
            taxonomicFamily.getTaxonomicOrder() != null && 
            taxonomicFamily.getTaxonomicOrder().getTaxonomicClass() != null) {
            
            return taxonomicFamily.getTaxonomicOrder().getTaxonomicClass().getNombre() + " > " +
                   taxonomicFamily.getTaxonomicOrder().getNombre() + " > " +
                   taxonomicFamily.getNombre();
        }
        return "Taxonomía no disponible";
    }

}

