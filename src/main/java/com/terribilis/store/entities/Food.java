package com.terribilis.store.entities;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "food")
@Data
public class Food {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    private String nombre;
    private String tipo; // insecto, vegetal, etc.
}
