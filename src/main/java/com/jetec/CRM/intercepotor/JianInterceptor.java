package com.jetec.CRM.intercepotor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class JianInterceptor implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/file/**").addResourceLocations(
				"file:C:\\Users\\Rong\\Desktop\\apache-tomcat-9.0.53\\webapps\\CRM\\WEB-INF\\classes\\static\\file\\");
		registry.addResourceHandler("/file/**").addResourceLocations(
				"file:E:/CRMfile/");
//		registry.addResourceHandler("/file/**").addResourceLocations( "file:c:/CRMfile/");
	}
}
