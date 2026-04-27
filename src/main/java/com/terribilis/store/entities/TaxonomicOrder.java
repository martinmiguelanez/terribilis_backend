package com.terribilis.store.entities;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "taxonomic_order")
@Data
public class TaxonomicOrder {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String nombre;

    @ManyToOne
    @JoinColumn(name = "class_id")
    private TaxonomicClass taxonomicClass;
}
