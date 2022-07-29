package com.jetec.CRM.controler;

import com.jetec.CRM.model.AdminBean;
import org.junit.jupiter.api.BeforeEach;
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
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class PotentialControllerTest {

    @Autowired
    private MockMvc mockMvc;

    HttpSession session;


    @BeforeEach
    void setUp() throws Exception {
        System.out.println("session");
        session = mockMvc.perform(post("/login").param("username", "AAA@AAA.com").param("password", "AAA")).andDo(print()).andExpect(status().isOk()).andReturn().getRequest().getSession();
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        AdminBean adminBean = (AdminBean) sci.getAuthentication().getPrincipal();
        session.setAttribute("user", adminBean);
    }

    /**
     * 獲取登入資訊session
     *
     * @return
     * @throws Exception
     */
//    private HttpSession getLoginSession() throws Exception{
//        // mock request get login session
//        // url = /xxx/xxx/{username}/{password}
//        MvcResult result = mockMvc
//                .perform(post("/login")
//                        .param("username","AAA@AAA.com")
//                        .param("password","AAA")
//                )
//    .andExpect(content().string("hello"))
//                .andExpect(status().isOk())
//                .andReturn();
//        return result.getRequest().getSession();
//    }


//    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
//        params.add("username","AAA@AAA.com");
//        params.add("password","AAA");
//        mockMvc.perform( post("/login").params(params))
//            //斷言
//            .andExpect(status().isOk())
//            //執行動作
//            .andDo(print());
    @Test
    void init() throws Exception {
        mockMvc.perform(post("/Potential/init/e1fb6aefa4c741108d19cc51127b9a87").session((MockHttpSession) session))
                //斷言
                .andExpect(status().isOk()).andExpect(jsonPath("$.customer.company").value("均品科技股份有限公司")).andExpect(jsonPath("$.track[0].customerid").value("e1fb6aefa4c741108d19cc51127b9a87"))
                //執行動作
                .andDo(print());
    }

    @Test
    void clientList() throws Exception {
        System.out.println("======================================");
        mockMvc.perform(post("/Potential/CustomerList").session((MockHttpSession) session).param("pag", "1")).andExpect(status().isOk()).andExpect(jsonPath("$.list").isArray()).andDo(print());
    }

    @Test
    void closed() throws Exception {
        System.out.println("======================================");
        mockMvc.perform(post("/Potential/closed").param("pag", "1").session((MockHttpSession) session)).andExpect(status().isOk()).andExpect(jsonPath("$").isArray());

    }

    @Test
    void selectAdmin() throws Exception {
        System.out.println("======================================");
        mockMvc.perform(post("/Potential/admin/陳岳盟").session((MockHttpSession) session)).andExpect(status().isOk()).andExpect(jsonPath("$").isArray());
    }

    @Test
    void selectDate() throws Exception {
        System.out.println("======================================");
        mockMvc.perform(post("/Potential/closed").param("startDay", "2022-07-10 00:00").param("endDay", "2022-07-15 23:59").session((MockHttpSession) session)).andExpect(status().isOk()).andExpect(jsonPath("$").isArray());
    }

    @Test
    void selectStatus() throws Exception {
        System.out.println("======================================");
        mockMvc.perform(post("/Potential/status/潛在客戶轉").session((MockHttpSession) session)).andExpect(status().isOk()).andExpect(jsonPath("$").isArray());
    }


    //搜索潛在客戶by追蹤時間
    @Test
    void selectTrackDate() throws Exception {
        System.out.println("=======================================================================================");
        mockMvc.perform(post("/Potential/selectTrackDate").param("from", "2022-07-10 00:00").param("to", "2022-07-16 00:00").session((MockHttpSession) session)).andExpect(status().isOk()).andExpect(jsonPath("$").isArray());
    }

    @Test
    void client() throws Exception {
        System.out.println("=======================================================================================");
        mockMvc.perform(post("/Potential/client/7dc9c36f99224ad3b298a985068450b3").session((MockHttpSession) session)).andExpect(status().isOk()).andExpect(jsonPath("$").isArray()).andDo(print());

    }

    @Test
    @Transactional
    @Rollback
    void saveTrackRemark() throws Exception {


        System.out.println("=======================================================================================");

        mockMvc.perform(post("/Potential/saveTrackRemark/00401237cac544b29436362969eaab34/網管測試").session((MockHttpSession) session)).andExpect(status().isOk()).andExpect(jsonPath("$").isArray());
    }

    @Test
    @Transactional
    @Rollback
    void removeTrack() throws Exception {
        mockMvc.perform(post("/Potential/removeTrack/e48c077cde134039adf4e3d294cfcde7")
                        .session((MockHttpSession) session)
                )
                .andExpect(status().isOk())
                .andDo(print());
    }

    @Test
    @Transactional
    @Rollback
    void removeTrackremark() throws Exception {
        mockMvc.perform(post("/Potential/removeTrackremark/6eb6ca72c4e64e338824a667e19a9d29/8665dd48c39b43ccb7a01015fcf21007").session((MockHttpSession) session)).andExpect(status().isOk()).andExpect(jsonPath("$").isArray());
    }

    @Test
    void getCompanyByName() throws Exception {
        mockMvc.perform(post("/Potential/getCompany/榮福股份有限公司").session((MockHttpSession) session)).andExpect(status().isOk()).andDo(print());
    }

    @Test
    void selectcontent() throws Exception {
        System.out.println("=======================================================================================");
        mockMvc.perform(post("/Potential/selectcontent")
                .session((MockHttpSession) session)
                .param("selectcontent", "耐高溫型液位"))
                .andExpect(status().isOk())
                .andDo(print());
    }

    @Test
    void callHelp() throws Exception {
        System.out.println("=======================================================================================");
        mockMvc.perform(post("/Potential/CallHelp/7dc9c36f99224ad3b298a985068450b3").session((MockHttpSession) session)).andExpect(status().isOk()).andExpect(jsonPath("$").value("求助")).andDo(print());
        mockMvc.perform(post("/Potential/CallHelp/7dc9c36f99224ad3b298a985068450b3").session((MockHttpSession) session)).andExpect(status().isOk()).andExpect(jsonPath("$").value("取消")).andDo(print());
    }

    @Test
    void selectPotential() throws Exception {
        System.out.println("=======================================================================================");
        mockMvc.perform(post("/Potential/selectPotential").session((MockHttpSession) session).param("startDay", "2022-07-04").param("endDay", "2022-07-08").param("key", "UserList").param("val", "謝姍妤")).andExpect(status().isOk());
        mockMvc.perform(post("/Potential/selectPotential").session((MockHttpSession) session).param("startDay", "2022-07-04").param("endDay", "2022-07-08").param("key", "name").param("val", "榮福股份有限公司")).andExpect(status().isOk()).andDo(print());
        mockMvc.perform(post("/Potential/selectPotential").session((MockHttpSession) session).param("startDay", "2022-07-04").param("endDay", "2022-07-08").param("key", "content").param("val", "液位傳送器")).andExpect(status().isOk()).andDo(print());
        mockMvc.perform(post("/Potential/selectPotential").session((MockHttpSession) session).param("startDay", "2022-07-04").param("endDay", "2022-07-08").param("key", "inStateList").param("val", "已聯繫")).andExpect(status().isOk()).andDo(print());
        mockMvc.perform(post("/Potential/selectPotential").session((MockHttpSession) session).param("startDay", "2022-07-04").param("endDay", "2022-07-08").param("key", "industry").param("val", "製造業")).andExpect(status().isOk()).andDo(print());


    }

    @Test
    @Transactional
    @Rollback
    void getReceive() throws Exception {
        System.out.println("=======================================================================================");
        mockMvc
                .perform(post("/Potential/getReceive/7dc9c36f99224ad3b298a985068450b3")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.state").value("領取成功"))
                .andExpect(jsonPath("$.user").value("陳彥霖"))
                .andDo(print());
        System.out.println("=======================================================================================");
        mockMvc
                .perform(post("/Potential/getReceive/7dc9c36f99224ad3b298a985068450b3")
                        .session((MockHttpSession) session))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.state").value("取消成功"))
                .andExpect(jsonPath("$.user").isEmpty())
                .andDo(print());
    }
}