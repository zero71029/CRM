package com.jetec.CRM.controler;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/Potential")   
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')")
public class PotentialController {
	
	
	
	

}
