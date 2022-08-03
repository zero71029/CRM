package com.jetec.CRM.controler;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class TaskControllerTest {

    @Autowired
    private MockMvc mockMvc;

    HttpSession session;

    @BeforeEach
    void setUp() {
    }

    @Test
    void task() {
    }

    @Test
    void detail() {
    }

    @Test
    void savePotentialCustomer() {
    }

    @Test
    void directorTaskList() {
    }

    @Test
    void workList() {
    }

    @Test
    void printd() {
    }

    @Test
    void delTask() {
    }

    @Test
    void sql() {
    }

    @Test
    void selecttask() {
    }

    @Test

    void saveLeave() throws Exception {
        mockMvc
                .perform(post("/task/saveLeave")
                        .param("user", "系統管理")
                        .param("department", "系統管理")
                        .param("leaveName", "系統管理")
                        .param("agent", "系統管理")
                        .param("reason", "系統管理")
                        .param("startday", "2022-08-19T08:00")
                        .param("endday", "2022-08-25T16:00")
                        .param("director", "系統管理")
                        .param("applyday", "2022-08-02")
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("code").value(200))
                .andExpect(jsonPath("message").value("假單成功"))
                .andExpect(jsonPath("data").value(""))
                .andDo(print());
    }

    @Test
    void getLeave() {
    }
}