package com.bakery.Productmanagement.repository;

import com.bakery.Productmanagement.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Integer> {

    List<Product> findByNameContaining(String name);

    List<Product> findByCategory(String category);

    List<Product> findByPriceBetween(double min, double max);

    List<Product> findByAvailabilityTrue();

    List<Product> findByNameContainingAndAvailabilityTrue(String name);
}