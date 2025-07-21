package com.example.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;

@RestController
public class LoanController {

    @GetMapping("/loan/details")
    public Map<String, Object> getDetails() {
        return Map.of(
            "loanId", "LN001",
            "loanType", "Car",
            "loanAmount", 200000
        );
    }
}
