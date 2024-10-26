package com.backend.example.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data // to generate getters and setters
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String customer;
    private float value;

}
