package com.enfiletesbaskets.enfiletesbaskets;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EntityScan("com.enfiletesbaskets.enfiletesbaskets.models")
@EnableJpaRepositories("com.enfiletesbaskets.enfiletesbaskets.repositories")
public class EnfiletesbasketsApplication {

	public static void main(String[] args) {
		SpringApplication.run(EnfiletesbasketsApplication.class, args);
	}

}
