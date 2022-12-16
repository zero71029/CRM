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

@SpringBootTest
@AutoConfigureMockMvc
class LaboratoryControllerTest {


    @Autowired
    private MockMvc mockMvc;
    HttpSession session;

    @BeforeEach
    void setUp() throws Exception {
        session = mockMvc.perform(post("/login")
                        .param("username", "jeter.tony56@gmail.com")
                        .param("password", "tp6u04xup6")
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
    void saveLaboratoryForum() {

    }

    @Test
    void getList() throws Exception {
        mockMvc.perform(post("/laboratory/getList")
                        .session((MockHttpSession) session)
                        .param("page", "1")
                        .param("size", "20"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("文章列表"))
                .andExpect(jsonPath("$.data").isMap());
    }

    @Test
    void getDetail() throws Exception {
        mockMvc.perform(post("/laboratory/getDetail")
                        .session((MockHttpSession) session)
                        .param("forumid", "1ed7c385608c676a934e5318f5234194"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("文章細節"))
                .andExpect(jsonPath("$.data").isMap());
    }

    @Test
    void delForum() throws Exception {
        mockMvc.perform(post("/laboratory/delforum")
                        .session((MockHttpSession) session)
                        .param("forumid", "1ed7c385608c676a934e5318f5234194")
                        .param("forumid", "1ed7aaec9b2f6c1ca1717f5c467ae99e"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("刪除成功"));
    }
}