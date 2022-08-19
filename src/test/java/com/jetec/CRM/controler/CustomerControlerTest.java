package com.jetec.CRM.controler;

import com.jetec.CRM.model.AdminBean;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
class CustomerControlerTest {

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
    @DisplayName("客戶列表初始化")
    void init() throws Exception {
        mockMvc.perform(post("/CRM/init")
                        .session((MockHttpSession) session)
                        .param("pag", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("客戶列表"))
                .andExpect(jsonPath("$.data.list").isArray())
                .andExpect(jsonPath("$.data.todayTotal").isNumber());
    }

    @Test
    @DisplayName("儲存客戶 未測")
    void saveClient() {
    }

    @Test
    void getclientList() {
    }

    @Test
    void client() throws Exception {
        mockMvc.perform(post("/CRM/client/0")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("bean","market","quotation"))
                .andExpect(view().name("/client/client")).andDo(print());
    }

    @Test
    @DisplayName("搜索客戶")
    void selectclientResponseBody() throws Exception {
        mockMvc.perform(post("/CRM/selectclientResponseBody/技術股份")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("搜索客戶"))
                .andExpect(jsonPath("$.data").isArray());
    }


    @Test
    @DisplayName("刪除客戶")
    @Transactional
    @Rollback
    void delClient() throws Exception {
        mockMvc.perform(post("/CRM/delClient")
                        .session((MockHttpSession) session)
                        .param("id","7"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("刪除成功"));
    }

    @Test
    void selectContactByClientName() {
    }

    @Test
    void saveContact() {
    }

    @Test
    void contact() {
    }

    @Test
    void delcontact() {
    }

    @Test
    void changeContact() {
    }

    @Test
    void changeMarket() {
    }

    @Test
    void changeWork() {
    }

    @Test
    void newAddress() {
    }

    @Test
    void delClientAddress() {
    }

    @Test
    void clickTag() {
    }
}