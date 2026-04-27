package com.terribilis.store.entities;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "diet_type")
@Data
public class DietType {
	
	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String nombre;
}
