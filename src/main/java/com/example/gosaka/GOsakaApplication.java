package com.example.gosaka;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = { "com.example.controller", "com.example.config", "com.example.service", "com.example.model" } ) 
public class GOsakaApplication {

	public static void main(String[] args) {
		SpringApplication.run(GOsakaApplication.class, args);
	}
	
}
