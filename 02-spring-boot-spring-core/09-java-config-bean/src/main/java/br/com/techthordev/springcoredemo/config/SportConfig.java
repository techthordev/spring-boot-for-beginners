package br.com.techthordev.springcoredemo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import br.com.techthordev.springcoredemo.common.Coach;
import br.com.techthordev.springcoredemo.common.SwimCoach;

@Configuration
public class SportConfig {

	@Bean("aquatic")
	public Coach swimCoach() {
	    return new SwimCoach();
	}
}