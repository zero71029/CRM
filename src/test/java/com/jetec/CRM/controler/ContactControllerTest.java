package com.jetec.CRM.controler;

import com.jetec.CRM.model.AdminBean;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.test.web.servlet.MockMvc;

import javax.servlet.http.HttpSession;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

@SpringBootTest
@AutoConfigureMockMvc
class ContactControllerTest {

    @Autowired
    private MockMvc mockMvc;
    HttpSession session;

    @BeforeEach
    void setUp() throws Exception {
        session = mockMvc.perform(post("/login")
                        .param("username", "AAA@AAA.com")
                        .param("password", "AAA")
                )
                .andExpect(status().isOk())
                .andReturn()
                .getRequest()
                .getSession();
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        AdminBean adminBean = (AdminBean) sci.getAuthentication().getPrincipal();
        session.setAttribute("user", adminBean);
    }

    @Test
    void contactListInit() throws Exception {
        mockMvc.perform(post("/contact/ContactListInit")
                        .session((MockHttpSession) session)
                        .param("pag", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("聯絡人列表"))
                .andExpect(jsonPath("$.data.list").isArray())
                .andExpect(jsonPath("$.data.total").isNumber());
    }

    @Test
    void selectContact() throws Exception {
        mockMvc.perform(post("/contact/selectContact")
                        .session((MockHttpSession) session)
                        .param("name", "資源股份"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("搜索聯絡")).andDo(print());
    }
}