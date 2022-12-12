package com.jetec.CRM;

import com.jetec.CRM.Tool.MailTool;
import com.jetec.CRM.Tool.ZeroTools;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;


@SpringBootTest
public class MailTest {
    @Autowired
    MailTool mailTool;


    @Test
    public void zeroMail(){
        ZeroTools zTools = new ZeroTools();
        zTools.SynologyMail("jeter.tony56@gmail.com","網管測試.....","網管測試","");
    }
    @Test
    public void Mail2() throws Exception {
        mailTool.sendSimpleMail("jeter.tony56@gmail.com","Test mail ","測試郵件");
    }

}
