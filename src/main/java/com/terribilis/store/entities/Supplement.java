package com.terribilis.store.entities;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "supplement")
@Data
public class Supplement {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

	private String nombre;
    private String descripcion;
    private String marca;
}

