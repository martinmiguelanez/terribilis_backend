package com.terribilis.store.entities;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "taxonomic_family")
@Data
public class TaxonomicFamily {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String nombre;
    
    @ManyToOne
    @JoinColumn(name = "order_id")
    private TaxonomicOrder taxonomicOrder;
}
