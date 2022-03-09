package com.jetec.CRM.intercepotor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class JianInterceptor implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/file/**").addResourceLocations(
				"file:c:/CRMfile/","file:e:/CRMfile/");
//		registry.addResourceHandler("/file/**").addResourceLocations( "file:e:/CRMfile/");
	}
}
