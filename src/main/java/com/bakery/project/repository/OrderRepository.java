package com.bakery.project.repository;

import com.bakery.project.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    // JpaRepository provides all CRUD methods like save(), findById(), and findAll()
}