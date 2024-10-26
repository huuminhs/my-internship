package com.backend.example.service;

import com.backend.example.dto.OrderDTO;
import com.backend.example.model.Order;
import com.backend.example.repository.OrderRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class OrderService {
    @Autowired
    OrderRepository orderRepository;

    public Order getOrder(Long id) {
        Optional<Order> order = orderRepository.findById(id);
        if (order.isPresent()) {
            return order.get();
        }
        return null;
    }

    @Transactional
    public Order createOrder(OrderDTO orderDTO) {
        Order newOrder = new Order();
        newOrder.setCustomer(orderDTO.getCustomer());
        newOrder.setValue(orderDTO.getValue());

        return orderRepository.save(newOrder);
    }

    @Transactional
    public Order updateOrder(Long id, OrderDTO orderDTO) {
        Optional<Order> orderOptional = orderRepository.findById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            order.setCustomer(orderDTO.getCustomer());
            order.setValue(orderDTO.getValue());
            return orderRepository.save(order);
        }
        return null;
    }

    @Transactional
    public void deleteOrder(Long id) {
        Optional<Order> orderOptional = orderRepository.findById(id);
        if (orderOptional.isPresent()) {
            orderRepository.delete(orderOptional.get());
        }
    }
}
