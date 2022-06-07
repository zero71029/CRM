package com.jetec.CRM;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.internet.MimeMessage;
import java.io.File;

@SpringBootTest
public class test {

    @Autowired
    private JavaMailSender mailSender;

    @Test
    public void sendSimpleMail() throws Exception {


        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
        helper.setFrom("zero@mail-jetec.com.tw");
        helper.setTo("jeter.tony56@gmail.com");
        helper.setSubject("mailSender 測試");

        helper.setText("<html><body><img src=\"cid:weixin\" ><p>內容：這是一封測試信件，恭喜您成功發送了唷</p></body></html>", true);
        FileSystemResource file = new FileSystemResource(new File("C:\\CRMfile\\6c89e8c01dc148648ebf0ce4413c98a2.jpg"));
        helper.addInline("weixin", file);

        mailSender.send(mimeMessage);
    }
}

