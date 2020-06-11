package com.example.demo;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class UserController {
    @RequestMapping("/hello")
    public String hello() {
        return "Hello Spring Boot!";
    }

    @RequestMapping("/user")
    public Map<String, String> user() {
        Map<String, String> map = new HashMap<String,String>();
        map.put("user", "Spring Boot welcome.");
        return map;
    }

    @RequestMapping(value = "check",method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    public Map<String, String> check(@RequestBody User user) {
        String name = user.getName();
        int age = user.getAge();
        String resp = String.format("%s is %d years old. you are welcome, Spring Boot.", name, age);
        Map<String, String> map = new HashMap<String,String>();
        map.put("user" , resp);
        return map;
    }
}
