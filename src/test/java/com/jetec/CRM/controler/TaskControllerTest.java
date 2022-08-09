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
    @Transactional
    @Rollback
    void saveLeave() throws Exception {
        mockMvc .perform(post("/task/saveLeave")
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
        mockMvc .perform(post("/task/getLeave/2022-08"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("code").value(200))
                .andExpect(jsonPath("message").value("請假單列表"))
                .andExpect(jsonPath("data").isArray());
    }

    @Test
    void leave() throws Exception {
        mockMvc .perform(post("/task/leave/43"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("code").value(200))
                .andExpect(jsonPath("message").value("讀取請假單"))
                .andExpect(jsonPath("data").exists());
    }
    @Test
    void saveBusinessTrip() throws Exception {

    }
    @Test
    void getBusinessTrip() throws Exception {

    }
    @Test
    void BusinessTripList() throws Exception {

    }
    @Test
    void BusinessTrip() throws Exception {

    }
}