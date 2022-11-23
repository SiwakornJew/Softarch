package com.medicare_backend.medicare_backend.route;

import com.auth0.jwt.interfaces.DecodedJWT;
import com.medicare_backend.medicare_backend.controller.UserController;
import com.medicare_backend.medicare_backend.schema.entity.AuthenticationPatient;
import com.medicare_backend.medicare_backend.schema.entity.Patient;
import com.medicare_backend.medicare_backend.schema.entity.User;
import com.medicare_backend.medicare_backend.schema.request.AddTask;
import com.medicare_backend.medicare_backend.service.InternalPayload;

import java.security.InvalidParameterException;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserRoute {

    @Autowired
    private UserController userService;

    // @GetMapping("/users")
    // public ResponseEntity<?> getListUser() {
    // List<User> data = userService.getListUser();
    // if (!(data != null && data.isEmpty())) {
    // return ResponseEntity.ok().body(data);
    // } else {
    // return ResponseEntity.status(500).body("User List Not Found");
    // }
    // }

    // @GetMapping("/users/findUserById/{id}")
    // public Optional<User> getUserByOneUser(@PathVariable("id") Long id) {
    // return userService.getUserById(id);
    // }

    @PostMapping("/users/register")
    public ResponseEntity<?> registerNewUser(@RequestBody Patient user) {
        InternalPayload data = userService.registerUser(user);
        if (data.getStatusCode() == "0") {
            return ResponseEntity.ok().body(data);
        } else if (data.getStatusCode() == "1") {
            return ResponseEntity.status(400).body(data);
        } else {
            return ResponseEntity.status(500).body(data);
        }

    }

    @PostMapping("/users/login")
    public ResponseEntity<?> loginToUser(@RequestBody AuthenticationPatient auth) {
        InternalPayload data = userService.loginUser(auth);
        if (data.getStatusCode() == "0") {
            return ResponseEntity.ok().body(data);
        } else if (data.getStatusCode() == "1") {
            return ResponseEntity.status(400).body(data);
        } else {
            return ResponseEntity.status(500).body(data);
        }

    }

}
