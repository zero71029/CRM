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

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
class MarketControlerTest {

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
    @DisplayName("讀取銷售機會")
    void market() throws Exception {
        mockMvc.perform(post("/Market/init/1ed1dd3deaf464359773c377e52c270b")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("銷售機會"));
    }

    @Test
    @DisplayName("儲存潛在客戶 未測")
    void savePotentialCustomer() throws Exception {

    }

    @Test
    @DisplayName("進入潛在客戶細節")
    void potentialcustomer() throws Exception {
        mockMvc.perform(post("/Market/potentialcustomer/1ed1dddc2257675597734dd7c70bc8ae")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(view().name("/Market/potentialcustomer"))
                .andExpect(model().attributeExists("bean"));
        mockMvc.perform(post("/Market/potentialcustomer/1ed1dddc2257")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(view().name("/error/500"))
                .andExpect(model().attribute("message", "此id找不到資料"));
    }

    @Test
    @DisplayName("讀取銷售機會列表")
    void MarketList() throws Exception {
        mockMvc.perform(post("/Market/MarketList")
                        .session((MockHttpSession) session)
                        .param("pag", "1")
                        .param("pageSize", "20"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.todayTotal").isNumber())
                .andExpect(jsonPath("$.endCast").isArray())
                .andExpect(jsonPath("$.pcc").isArray())
                .andExpect(jsonPath("$.total").isNumber())
                .andExpect(jsonPath("$.CallBos").isArray())
                .andExpect(jsonPath("$.markeCreateTime").isArray())
                .andExpect(jsonPath("$.potential").isArray())
                .andExpect(jsonPath("$.list").isArray());
    }


    @Test
    @DisplayName("銷售機會列表(結案)")
    void closeMarket() throws Exception {
        mockMvc.perform(post("/Market/CloseMarket")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(view().name("/Market/MarketList"))
                .andExpect(model().attributeExists("list"));
    }

    @Test
    @DisplayName("未測")
    void saveMarket() {
    }

    @Test
    @DisplayName("進入銷售機會詳細")
    void inMarket() throws Exception {
        mockMvc.perform(post("/Market/{id}")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(view().name("/Market/MarketList"))
                .andExpect(model().attributeExists("list"));
    }

    @Test
    @Transactional
    @Rollback
    void delMarket() throws Exception {
        mockMvc.perform(post("/Market/delMarket")
                        .session((MockHttpSession) session)
                        .param("id", "1ed1dcdc55916dc79773534f829e61dc"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").value("刪除成功"));
    }

    @Test
    void selectMarket() throws Exception {
        mockMvc.perform(post("/Market/selectMarket")
                        .session((MockHttpSession) session)
                        .param("from", "")
                        .param("to", "")
                        .param("key", "name")
                        .param("val", "溫度控制"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());
    }

    @Test
    @DisplayName("未測")
    void saveTrack() {
    }

    @Test
    @Transactional
    @Rollback
    void delPotentialCustomer() throws Exception {
        mockMvc.perform(post("/Market/delPotentialCustomer")
                        .session((MockHttpSession) session)
                        .param("id", "1ed1dde1f56e635a97732ddf7e76387a"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").value("刪除成功"));
    }

    @Test
    void selectPotentialCustomer() throws Exception {
        mockMvc.perform(post("/Market/selectPotentialCustomer")
                        .session((MockHttpSession) session)
                        .param("name", "台灣糖業"))
                .andExpect(status().isOk())
                .andExpect(view().name("/Market/potentialcustomerList"))
                .andExpect(model().attributeExists("list"));
    }


    @Test
    void goQuotation() {
    }

    @Test
    void saveQuotation() {
    }

    @Test
    void quotation() {

    }

    @Test
    void quotationList() {
    }

    @Test
    void saveAgreement() {
    }

    @Test
    void agreement() {
    }

    @Test
    void existsClient() {

    }

    @Test
    void changeClient() {
    }

    @Test
    void existsContact() {
    }

    @Test
    void changeContact() {
    }


    @Test
    void changeWork() {
    }

    @Test
    void testChangeWork() {
    }

    @Test
    void changeMarket() {
    }

    @Test
    void getchange() {
    }

    @Test
    void selectName() throws Exception {
        mockMvc.perform(post("/Market/selectMarket/玟嫣")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());
    }

    @Test
    void selectDate() throws Exception {
        mockMvc.perform(post("/Market/selectDate")
                        .session((MockHttpSession) session)
                        .param("from", "")
                        .param("to", ""))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());
    }


    @Test
    void saveTrackByMarket() {
    }

    @Test
    void changeTrackByMarket() {
    }

    @Test
    void clicks() throws Exception {
        mockMvc.perform(post("/Market/clicks/1ed1f9e600136a4fb357459a7da99fda")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").value("增加成功"));
    }

    @Test
    @DisplayName("檢查有無銷售機會")
    void existMarket() throws Exception {
        mockMvc.perform(post("/Market/existMarket/1ed1f9e600136a4fb357459a7da99fda")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isBoolean());
    }


    @Test
    @DisplayName("切換使用者狀態")
    void addState() throws Exception {
        mockMvc.perform(post("/Market/AddState/admin/玟嫣/success")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].adminid").value("2"))
                .andExpect(jsonPath("$[0].field").value("admin"))
                .andExpect(jsonPath("$[0].state").value("玟嫣"));
    }


    @Test
    @DisplayName("刪除所有狀態")
    void delAllState() throws Exception {
        mockMvc.perform(post("/Market/delAllState/2")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].adminid").value("2"))
                .andExpect(jsonPath("$[0].field").value("admin"))
                .andExpect(jsonPath("$[0].state").value("玟嫣"));
    }



    @Test
    @Deprecated
    void blur() {
    }

    @Test
    void check() {
    }

    @Test
    void autoCloseCase() {
    }

    @Test
    void getAutoClose() {
    }

    @Test
    void getReceive() {
    }

    @Test
    void formatPhone() {
    }
}