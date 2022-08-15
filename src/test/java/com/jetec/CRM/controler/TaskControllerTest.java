package com.jetec.CRM.controler;

import com.jetec.CRM.controler.service.TaskService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.transaction.annotation.Transactional;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class TaskControllerTest {

    @Autowired
    private MockMvc mockMvc;
    @Autowired
    TaskService ts;

    @Test
    void task() throws Exception {
        mockMvc.perform(post("/task/init/1ed16fc968f869f6bf8121d4b88c8c34")
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.taskList").isArray())
                .andExpect(jsonPath("$.bean.evaluateid").value("1ed16fc968f869f6bf8121d4b88c8c34"))
                .andExpect(jsonPath("$.bean.name").value("蕭佩宜"));
    }

    @Test
    void detail() throws Exception {
        mockMvc.perform(post("/task/detail/1ed16fc968f869f6bf8121d4b88c8c34")
                )
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.model().attributeExists("bean"))
                .andExpect(MockMvcResultMatchers.view().name("/Task/Task"));
        System.out.println("=============================================");
        mockMvc.perform(post("/task/detail/1ed16fc968")
                )
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.model().attribute("message", "此id找不到資料"))
                .andExpect(MockMvcResultMatchers.view().name("/error/500"));
    }

    @Test
    @Transactional
    @Rollback
    @DisplayName("未測")
    void savePotentialCustomer() {
//        HttpSession session = mockMvc.perform(post("/login")
//                        .param("username", "AAA@AAA.com")
//                        .param("password", "AAA")
//                )
//                .andReturn()
//                .getRequest()
//                .getSession();
//        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
//        AdminBean adminBean = (AdminBean) sci.getAuthentication().getPrincipal();
//        session.setAttribute("user", adminBean);
//        mockMvc.perform(post("/task/save")
//                        .session((MockHttpSession) session)
//                        .param("department", "行銷")
//                        .param("name", "蕭佩宜")
//                        .param("evaluatedate", "2022-08-09")
//                        .param("remark", "")
//                        .param("score", "A")
//                        .param("assessment", "")
//                        .param("director", "")
//                        .param("hr", "")
//                        .param("costtime", "")
//                        .param("task[0].content","氣象儀器綜合型錄修改")
//                        .param("task[0].important","L")
//                )
//                .andExpect(status().is2xxSuccessful())
//                .andDo(print());
    }

    @Test
    void directorTaskList() throws Exception {
        mockMvc.perform(post("/task/directorTaskList")
                        .param("pag","1")
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.total").isNumber())
                .andExpect(jsonPath("$.userList").isArray())
                .andExpect(jsonPath("$.list").isArray());
    }

    @Test
    void workList() throws Exception {
        mockMvc.perform(post("/task/taskList")
                        .param("pag","1")
                        .param("name","賴世全")
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.total").isNumber())
                .andExpect(jsonPath("$.list").isArray());
    }

    @Test
    void printd() throws Exception {
        mockMvc.perform(post("/task/print/95bbff11c1ac4f13bb322142d9ace043"))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.model().attributeExists("bean"))
                .andExpect(MockMvcResultMatchers.view().name("/Task/print"));
    }

    @Test
    @Transactional
    @Rollback
    void delTask() throws Exception {
        mockMvc.perform(post("/task/delTask")
                        .param("id","85c456286674491092b98108f57adcac"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").value("刪除成功"));
    }

    @Test
    void sql() {
    }

    @Test
    void selecttask() throws Exception {
        mockMvc.perform(post("/task/selecttask")
                        .param("pag","1")
                        .param("name","賴世全"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());
    }

    @Test
    @Transactional
    @Rollback
    void saveLeave() throws Exception {
        mockMvc.perform(post("/task/saveLeave")
                        .param("user", "系統管理")
                        .param("department", "系統管理")
                        .param("leaveName", "系統管理")
                        .param("agent", "系統管理")
                        .param("reason", "系統管理")
                        .param("startday", "2022-07-19T08:00")
                        .param("endday", "2022-08-05T16:00")
                        .param("director", "系統管理")
                        .param("applyday", "2022-08-02")
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("code").value(200))
                .andExpect(jsonPath("message").value("假單成功"))
                .andExpect(jsonPath("data").value(""));
    }

    @Test
    void getLeave() throws Exception {
        mockMvc.perform(post("/task/getLeave/2022-08"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("code").value(200))
                .andExpect(jsonPath("message").value("請假單列表"))
                .andExpect(jsonPath("data").isArray());
    }

    @Test
    void leave() throws Exception {
        mockMvc.perform(post("/task/leave/43"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("code").value(200))
                .andExpect(jsonPath("message").value("讀取請假單"))
                .andExpect(jsonPath("data").exists());
    }

    @Test
    @Transactional
    @Rollback
    void saveBusinessTrip() throws Exception {
        mockMvc.perform(post("/task/saveBusinessTrip")
                        .param("schedule", "系統管理")
                        .param("tripday", "2022-08-20")
                        .param("expected", "8小時")
                        .param("responsible1", "系統管理")
                        .param("tripname", "台積電工程")
                        .param("type", "中部")
                        .param("content", "危險氣體感測器裝設")
                        .param("responsible2", "系統管理")
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("code").value(200))
                .andExpect(jsonPath("message").value("出差申請成功"))
                .andExpect(jsonPath("data").isEmpty());
    }


    @Test
    void BusinessTripList() throws Exception {
        mockMvc.perform(post("/task/BusinessTripList/2022-08"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("code").value(200))
                .andExpect(jsonPath("message").value("讀取出差申請列表"))
                .andExpect(jsonPath("data").isArray());
    }

    @Test
    void BusinessTrip() throws Exception {
        mockMvc.perform(post("/task/BusinessTrip/10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("code").value(200))
                .andExpect(jsonPath("message").value("讀取出差申請"))
                .andExpect(jsonPath("data.tripid").value(10))
                .andExpect(jsonPath("data").exists()).andDo(print());
    }
}