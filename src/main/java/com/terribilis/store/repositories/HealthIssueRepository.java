package com.terribilis.store.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.terribilis.store.entities.HealthIssue;

public interface HealthIssueRepository extends JpaRepository<HealthIssue, Integer>{

}
