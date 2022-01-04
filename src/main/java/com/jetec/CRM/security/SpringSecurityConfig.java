package com.jetec.CRM.security;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

@Configuration
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true)
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private UserDetailsService UserDetailsService;

	// 注入數據源
	@Autowired
	private DataSource dataSource;

	@Autowired
	AppsAuthenticationFailureHandler appsAuthenticationFailureHandler;

	// 配置對象
	@Bean
	public PersistentTokenRepository persistentTokenRepository() {
		JdbcTokenRepositoryImpl jdbcTokenRepositoryImpl = new JdbcTokenRepositoryImpl();
		jdbcTokenRepositoryImpl.setDataSource(dataSource);
//		 jdbcTokenRepositoryImpl.setCreateTableOnStartup(true);
		return jdbcTokenRepositoryImpl;
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {

		http.csrf().disable();
		// 自定義登入
		http.formLogin()
				// 登入頁面
				.loginPage("/time.jsp")
				// 後端處理登入的方法 表單提交地址
				.loginProcessingUrl("/login")
				// 登入成功後轉發地址
				.successForwardUrl("/home")
				//失敗處理
				.failureHandler(appsAuthenticationFailureHandler);

		// 用戶沒有權限處理
		http.exceptionHandling().accessDeniedPage("/AuthorityError.jsp");
		// 權限配置
		http.authorizeRequests();
		// 登入頁面放行
//		.antMatchers("/time.jsp").permitAll()
//		//放行頁面
//		.antMatchers("/billboard","/CRM.jsp","/index","/","/css/**","/js/**").permitAll()
//		//其他資源須登入
//		.anyRequest().authenticated();

		http.logout() // 1.登出功能的支援
				.logoutUrl("/logout") // 2.設定觸發登出功能的 URL
				.logoutSuccessUrl("/Signout").permitAll() // 3.登出後會重新導向
				// .logoutSuccessHandler(logoutSuccessHandler) // 4.容許提供自訂的
				// LogoutSuccessHandler，如果有列出此項，則 logoutSuccessUrl() 的部分會被忽略
				.invalidateHttpSession(true) // 5.設定登出後是否要註銷 HttpSession，預設為 true，此項其實是在背後對 SecurityContextLogoutHandler
												// 做設定
				// .addLogoutHandler(logoutHandler) // 6.加入 LogoutHandler。預設會將
				// SecurityContextLogoutHandler 作為最後一個 LogoutHandler 加入
				.deleteCookies("remember-me"); // 設定成功登出後要刪除的 cookie 名稱

		// 配置token自動登入
		http.rememberMe().tokenRepository(persistentTokenRepository()).tokenValiditySeconds(2500000)// 設置有效時長 單位秒
				.userDetailsService(UserDetailsService);

	}

}
