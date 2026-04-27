package com.terribilis.store.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.terribilis.store.entities.DietType;
import com.terribilis.store.entities.Food;
import com.terribilis.store.entities.HealthIssue;
import com.terribilis.store.entities.Supplement;
import com.terribilis.store.entities.TaxonomicClass;
import com.terribilis.store.entities.TaxonomicFamily;
import com.terribilis.store.entities.TaxonomicOrder;
import com.terribilis.store.repositories.DietTypeRepository;
import com.terribilis.store.repositories.FoodRepository;
import com.terribilis.store.repositories.HealthIssueRepository;
import com.terribilis.store.repositories.SupplementRepository;
import com.terribilis.store.repositories.TaxonomicClassRepository;
import com.terribilis.store.repositories.TaxonomicFamilyRepository;
import com.terribilis.store.repositories.TaxonomicOrderRepository;

@RestController
@RequestMapping("/api")
@CrossOrigin("*")
public class MasterController {
	
	
	@Autowired private TaxonomicClassRepository classRepo;   // Añadido
    @Autowired private TaxonomicOrderRepository orderRepo;
	@Autowired private TaxonomicFamilyRepository familyRepo;
    @Autowired private DietTypeRepository dietTypeRepo;
    @Autowired private HealthIssueRepository healthIssueRepo;
    @Autowired private SupplementRepository supplementRepo;
    @Autowired private FoodRepository foodRepo;
    
    @GetMapping("/TaxonomicClass")
    public List<TaxonomicClass> getClasses() {
        return classRepo.findAll();
    }

    @GetMapping("/TaxonomicOrder")
    public List<TaxonomicOrder> getOrders() {
        return orderRepo.findAll();
    }
    
    @GetMapping("/TaxonomicFamily")
    public List<TaxonomicFamily> getFamilies() {
        return familyRepo.findAll();
    }

    @GetMapping("/DietTypes")
    public List<DietType> getDietTypes() {
        return dietTypeRepo.findAll();
    }

    @GetMapping("/Food")
    public List<Food> getFood() {
        return foodRepo.findAll();
    }

    @GetMapping("/Supplement")
    public List<Supplement> getSupplements() {
        return supplementRepo.findAll();
    }

    @GetMapping("/HealthIssue")
    public List<HealthIssue> getHealthIssues() {
        return healthIssueRepo.findAll();
    }
}
