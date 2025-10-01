package com.example.awspursuitdemo;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api")
public class Controller {

    private final UserRepo repo;

    Controller(UserRepo repo){
        this.repo=repo;
    }

    @GetMapping("/health")
    public ResponseEntity<String> health(){
        return ResponseEntity.ok("Success: OK");
    }

    @PostMapping("/user")
    public ResponseEntity<User> saveUser(@RequestBody User user){
        user.setUserId(UUID.randomUUID().toString());

        User saved=repo.save(user);

        return ResponseEntity.ok().body(saved);
    }

}
