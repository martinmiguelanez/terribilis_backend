package com.terribilis.store.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.terribilis.store.entities.Food;

public interface FoodRepository extends JpaRepository<Food, Integer>{

}
