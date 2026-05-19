package com.bakery.Ordermanagement.repository;

import com.bakery.Ordermanagement.model.OrderItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface OrderItemRepository extends JpaRepository<OrderItem, Integer> {

    List<OrderItem> findByOrderId(int orderId);

    @Modifying
    @Transactional
    void deleteByOrderId(int orderId);
}