package com.bakery.Ordermanagement.repository;

import com.bakery.Ordermanagement.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Integer> {

    List<Order> findByCustomerId(int customerId);

    List<Order> findByStatus(String status);

    List<Order> findAllByOrderByCreatedAtDesc();

    long countByStatus(String status);
}