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
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
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
    void getclientList() throws Exception {

    }

    @Test
    void client() throws Exception {
        mockMvc.perform(post("/CRM/client/0")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("bean", "market", "quotation"))
                .andExpect(view().name("/client/client")).andDo(print());
    }

    @Test
    @DisplayName("搜索客戶")
    void selectclientResponseBody() throws Exception {
        mockMvc.perform(post("/CRM/selectclientResponseBody/技h術h股h份")
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
                        .param("id", "7"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("刪除成功"));
    }

    @Test
    @DisplayName("搜索聯絡人by公司")
    void selectContactByClientName() throws Exception {
        mockMvc.perform(post("/CRM/selectContactByClientName/頎邦科技股份有限公司")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0]").exists());
    }

    @Test
    @DisplayName("儲存聯絡人  未測")
    void saveContact() {
    }

    @Test
    @DisplayName("讀取聯絡人細節")
    void contact() throws Exception {
        mockMvc.perform(post("/CRM/contact/8")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(view().name("/client/contact"))
                .andExpect(model().attributeExists("bean"));
    }

    @Test
    @DisplayName("刪除聯絡人")
    @Transactional
    @Rollback
    void delcontact() throws Exception {
        mockMvc.perform(post("/CRM/delcontact")
                        .session((MockHttpSession) session)
                        .param("id","8"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").value("刪除成功"))
                .andDo(print());
    }

    @Test
    @DisplayName("客戶轉換聯絡人 未測")
    void changeContact() {
    }



    @Test
    void changeWork() {
    }

    @Test
    @Transactional
    @Rollback
    @DisplayName("新增其他地址")
    void newAddress() throws Exception {
        mockMvc.perform(post("/CRM/newAddress")
                        .session((MockHttpSession) session)
                        .param("clientid","10")
                        .param("city","彰化縣")
                        .param("town","福興鄉")
                        .param("postal","506")
                        .param("address","iiiiiiiiiiiiiiiii")
                )
                .andExpect(status().is3xxRedirection())
                .andExpect(view().name("redirect:/CRM/client/10"));
    }

    @Test
    @DisplayName("刪除其他地址  沒有資料 未測")
    void delClientAddress() throws Exception {

    }

    @Test
    void clickTag() {
    }
}