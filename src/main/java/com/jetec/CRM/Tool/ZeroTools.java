package com.jetec.CRM.Tool;

import com.github.f4b6a3.uuid.UuidCreator;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.jetec.CRM.model.AdminBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.GeneralSecurityException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.Properties;

@Component
public class ZeroTools {
     static   Logger logger = LoggerFactory.getLogger(ZeroTools.class);

//////////////////////////////////////////////////////////////////
    /*
     *
     * @mailTo 收件人
     *
     * @text 郵件內文
     *
     * @Subject 郵件的標題
     *
     * @maillist 群發郵件
     *
     */
    private final String STMP = "";
    private final String secret = "";

    // 郵件
    public void mail(String mailTo, String text, String Subject, String maillist) {

//		mailTo = "wiz71028@hotmail.com";
        new Thread() {
            @Override
            public void run() {
                System.out.println(mailTo);
                System.out.println(text);

                Properties prop = new Properties();
                // 發件人的郵箱的SMTP 服務器地址（不同的郵箱，服務器地址不同，如139和qq的郵箱服務器地址不同）
                prop.setProperty("mail.host", "smtp.gmail.com");
                // 使用的協議（JavaMail規範要求）
                prop.setProperty("mail.transport.protocol", "smtp");
                // 需要請求認證

                prop.setProperty("mail.smtp.auth", "true");
                prop.put("mail.smtp.starttls.enable", "true");
                prop.put("mail.smtp.port", "587");
                prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
                // 使用JavaMail發送郵件的5個步驟
                // 1、創建session
                Session session = Session.getInstance(prop);
                // 開啟Session的debug模式，這樣就可以查看到程序發送Email的運行狀態
                session.setDebug(true);
                Transport ts = null;
                try {
                    // 2、通過session得到transport對象
                    ts = session.getTransport();
                    // 3、使用郵箱的用戶名和密碼連接郵件服務器
                    // 發送郵件時，發件人需要提交郵箱的用戶名和密碼給smtp服務器，用戶名和密碼都通過驗證之後才能夠正常發送郵件給收件人。
                    ts.connect("smtp.gmail.com", "jeter.tony56@gmail.com", STMP);
                    // 4、創建郵件
//	            Message message = createComplexMail(session); 
                    MimeMessage message = new MimeMessage(session);
                    // 指明發件人
                    message.setFrom(new InternetAddress("AAA"));
                    // 指明收件人
                    message.setRecipient(Message.RecipientType.TO, new InternetAddress(mailTo));
                    message.addRecipients(Message.RecipientType.BCC, maillist);
                    // 郵件的標題
                    message.setSubject(Subject);
                    // 郵件的文本內容
                    message.setContent(text, "text/html;charset=UTF-8");

                    // 5、發送郵件

                    ts.sendMessage(message, message.getAllRecipients());
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        // 關閉transport對象
                        ts.close();
                    } catch (MessagingException e) {
                        e.printStackTrace();
                    }
                }

            }
        }.start();

    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // google登入
    public void oauth(String idtoken) {
        GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
                // Specify the CLIENT_ID of the app that accesses the backend:
                .setAudience(Collections
                        .singletonList(""))
                // Or, if multiple clients access the backend:
                // .setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
                .build();

        // (Receive idTokenString by HTTPS POST)

        GoogleIdToken idToken = null;
        try {
            idToken = verifier.verify(idtoken);
        } catch (GeneralSecurityException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        if (idToken != null) {
            Payload payload = idToken.getPayload();

            // Print user identifier
            String userId = payload.getSubject();
            System.out.println("User ID: " + userId);

            // Get profile information from payload
            String email = payload.getEmail();
//			boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
            String name = (String) payload.get("name");
//			String pictureUrl = (String) payload.get("picture");
            String locale = (String) payload.get("locale");
//			String familyName = (String) payload.get("family_name");
            String givenName = (String) payload.get("given_name");
            System.out.println("User name: " + name);
            System.out.println("User email: " + email);
            System.out.println("User locale: " + locale);
            System.out.println("User givenName: " + givenName);

            // Use or store profile information
            // ...

        } else {
            System.out.println("Invalid ID token.");
        }
    }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

    // 機器人判斷
    public boolean recaptcha(String toke) {

        // 取得token
        System.out.println(toke);
        System.out.println("*****recaptcha******");

//		JSONObject obj = new JSONObject();
//		obj.put("secret", "");
//		obj.put("response", body);
//		obj.put("remoteip", ip);
        try {
            // 編輯google需要文件
            String url = "https://www.google.com/recaptcha/api/siteverify",
                    params = "secret=" + secret + "&response=" + toke;
            // 開啟網路發送
            HttpURLConnection http = (HttpURLConnection) new URL(url).openConnection();
            http.setDoOutput(true);
            http.setRequestMethod("POST");
            http.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
            OutputStream out = http.getOutputStream();
            out.write(params.getBytes("UTF-8"));
            out.flush();
            out.close();

            // 接收返回資料
            InputStream res = http.getInputStream();
            BufferedReader rd = new BufferedReader(new InputStreamReader(res, "UTF-8"));
            StringBuilder sb = new StringBuilder();
            int cp;
            while ((cp = rd.read()) != -1) {
                sb.append((char) cp);
            }
            JSONObject json = new JSONObject(sb.toString());
            System.out.println(json);
            res.close();

            // 判斷成功存在session
            if ((boolean) json.get("success"))  return true;

            return false;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

    /**
     * 獲得一個UUID
     *
     * @return String UUID
     */
    public static String  getUUID() {
        String s = UuidCreator.getTimeOrderedWithRandom().toString();
        // 去掉“-”符號
        return s.substring(0, 8) + s.substring(9, 13) + s.substring(14, 18) + s.substring(19, 23) + s.substring(24);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//時間格式畫
    public static String getTime(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        return sdf.format(date);
    }


//    日期加幾天
    public String addDay(String day,int i) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        try {
            cal.setTime(dateFormat.parse(day));
        } catch (ParseException e1) {

        }
        cal.add(Calendar.DATE, i);
        return dateFormat.format(cal.getTime());

    }


    /*
     *
     * @mailTo 收件人
     *
     * @text 郵件內文
     *
     * @Subject 郵件的標題
     *
     * @maillist 群發郵件
     *
     */
    // 郵件
    public void SynologyMail(String mailTo, String text, String Subject, String maillist) {

//		mailTo = "wiz71028@hotmail.com";
        new Thread() {
            @Override
            public void run() {


                Properties prop = new Properties();
                // 發件人的郵箱的SMTP 服務器地址（不同的郵箱，服務器地址不同，如139和qq的郵箱服務器地址不同）
                prop.setProperty("mail.host", "192.168.11.118");
                // 使用的協議（JavaMail規範要求）
                prop.setProperty("mail.transport.protocol", "smtp");
                // 需要請求認證

                prop.setProperty("mail.smtp.auth", "true");
                prop.put("mail.smtp.starttls.enable", "false");
                prop.put("mail.smtp.port", "25");
                prop.put("mail.smtp.ssl.trust", "mail-jetec.com.tw");

                prop.put("mail.smtp.user", "zero");
                // 使用JavaMail發送郵件的5個步驟
                // 1、創建session
                Session session = Session.getInstance(prop,
                        new javax.mail.Authenticator() {
                            protected PasswordAuthentication getPasswordAuthentication() {
                                return new PasswordAuthentication(
                                        "zero", "");
                            }
                        });
                // 開啟Session的debug模式，這樣就可以查看到程序發送Email的運行狀態
                session.setDebug(false);
                Transport ts = null;
                try {
                    // 2、通過session得到transport對象
                    ts = session.getTransport();
                    // 3、使用郵箱的用戶名和密碼連接郵件服務器
                    // 發送郵件時，發件人需要提交郵箱的用戶名和密碼給smtp服務器，用戶名和密碼都通過驗證之後才能夠正常發送郵件給收件人。
                    ts.connect("192.168.11.118", "zero", "");
                    // 4、創建郵件
//	            Message message = createComplexMail(session);
                    MimeMessage message = new MimeMessage(session);
                    // 指明發件人
                    message.setFrom(new InternetAddress("zero@mail-jetec.com.tw","zero"));
                    // 指明收件人
                    message.setRecipient(Message.RecipientType.TO, new InternetAddress(mailTo));
                    message.addRecipients(Message.RecipientType.BCC, maillist);
                    // 郵件的標題
                    message.setSubject(Subject);
                    // 郵件的文本內容
                    message.setContent(text, "text/html;charset=UTF-8");

                    // 5、發送郵件

                    ts.sendMessage(message, message.getAllRecipients());
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        // 關閉transport對象
                        ts.close();
                    } catch (MessagingException e) {
                        e.printStackTrace();
                    }
                }

            }
        }.start();

    }
    public static AdminBean  getAdmin(){
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

            return (AdminBean) authentication.getPrincipal();
        } catch (Exception e) {
            logger.error("未登入");
            AdminBean adminBean = new AdminBean();
            adminBean.setName("");
           return adminBean;
        }
    }

}
