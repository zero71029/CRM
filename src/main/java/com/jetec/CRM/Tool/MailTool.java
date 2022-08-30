package com.jetec.CRM.Tool;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.mail.internet.MimeMessage;
import java.io.File;

@Component
public class MailTool {

    @Autowired
    private JavaMailSender mailSender;


    public void sendSimpleMail(String to, String Subject,String text) throws Exception {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
        helper.setFrom("zero@mail-jetec.com.tw");
        helper.setTo(to);
        helper.setSubject(Subject);
        helper.setText(text, true);

        mailSender.send(mimeMessage);
    }
    public void sendSimpleMail(String[] to, String Subject,String text) throws Exception {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
        helper.setFrom("zero@mail-jetec.com.tw");
        helper.setTo(to);
        helper.setSubject(Subject);
        helper.setText(text, true);

        mailSender.send(mimeMessage);
    }
    //添加附件
    public void sendAttachmentsMail(String to, String Subject,String text) throws Exception {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
        helper.setFrom("zero@mail-jetec.com.tw");
        helper.setTo(to);
        helper.setSubject(Subject);
        helper.setText(text);

        FileSystemResource file = new FileSystemResource(new File("C:\\CRMfile\\6c89e8c01dc148648ebf0ce4413c98a2.jpg"));
        helper.addAttachment("附件-1.jpg", file);
        helper.addAttachment("附件-2.jpg", file);

        mailSender.send(mimeMessage);
    }
    //添加靜態物件
    public void sendlineMail(String to, String Subject,String text) throws Exception {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
        helper.setFrom("zero@mail-jetec.com.tw");
        helper.setTo(to);
        helper.setSubject(Subject);
        helper.setText("<html><body><img src=\"cid:weixin\" ><p>內容：這是一封測試信件，恭喜您成功發送了唷</p></body></html>", true);
        FileSystemResource file = new FileSystemResource(new File("C:\\CRMfile\\6c89e8c01dc148648ebf0ce4413c98a2.jpg"));
        helper.addInline("weixin", file);

        mailSender.send(mimeMessage);
    }





}
