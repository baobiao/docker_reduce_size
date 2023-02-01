package com.example.helloworld;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {
    
    @GetMapping("/helloworld/{name}")
    public String sayHello(@PathVariable("name") String name) {
        String escapedName = StringEscapeUtils.escapeHtml4(name);
        return "Hello World, " + escapedName;
    }
}
