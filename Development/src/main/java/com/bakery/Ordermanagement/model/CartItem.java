package com.bakery.Ordermanagement.model;

public class CartItem {

    private int productId;
    private String productName;
    private String productCategory;
    private double price;
    private int quantity;
    private boolean availability;

    public CartItem() {}

    public CartItem(int productId, String productName, String productCategory,
                    double price, int quantity, boolean availability) {
        this.productId = productId;
        this.productName = productName;
        this.productCategory = productCategory;
        this.price = price;
        this.quantity = quantity;
        this.availability = availability;
    }

    // Getters and Setters
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getProductCategory() { return productCategory; }
    public void setProductCategory(String productCategory) { this.productCategory = productCategory; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public boolean isAvailability() { return availability; }
    public void setAvailability(boolean availability) { this.availability = availability; }

    public double getSubtotal() { return price * quantity; }

    public void incrementQuantity() { this.quantity++; }
    public void decrementQuantity() { if (this.quantity > 1) this.quantity--; }
}