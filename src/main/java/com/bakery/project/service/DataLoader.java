package com.bakery.project.service;

import com.bakery.project.model.CustomOrder;
import com.bakery.project.model.StandardOrder;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.beans.factory.annotation.Autowired;

@Component
public class DataLoader implements CommandLineRunner {

    @Autowired
    private OrderService orderService;

    @Override
    public void run(String... args) throws Exception {
        // 1. Create a Standard Order
        StandardOrder sOrder = new StandardOrder();
        sOrder.setCustomerName("Amal Perera");
        sOrder.setTotalAmount(1500.00);
        sOrder.setProductCategory("Pastry");
        orderService.placeOrder(sOrder); // Polymorphism: Sets status to CONFIRMED

        // 2. Create a Custom Cake Order
        CustomOrder cOrder = new CustomOrder();
        cOrder.setCustomerName("Nimali Silva");
        cOrder.setTotalAmount(5500.00);
        cOrder.setCakeDesign("Vintage Ghibli Style");
        cOrder.setSpecialInstructions("Less sugar, chocolate ganache");
        orderService.placeOrder(cOrder); // Polymorphism: Sets status to AWAITING_APPROVAL

        System.out.println(">> Test Data Loaded Successfully! <<");
    }
}