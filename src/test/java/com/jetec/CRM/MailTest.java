package com.jetec.CRM;

import com.jetec.CRM.Tool.ZeroTools;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;


@SpringBootTest
public class MailTest {


    @Test
    public void zeroMail(){
        ZeroTools zTools = new ZeroTools();
        zTools.SynologyMail("jeter.tony56@gmail.com","網管測試.....","網管測試","");
    }


}
