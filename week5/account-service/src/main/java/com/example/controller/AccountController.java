package com.example.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;

@RestController
public class AccountController {

    @GetMapping("/account/details")
    public Map<String, Object> getDetails() {
        return Map.of(
            "accountNumber", "123456",
            "accountType", "Saving",
            "balance", 50000
        );
    }
}
