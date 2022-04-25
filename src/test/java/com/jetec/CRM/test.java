package com.jetec.CRM;

import com.jetec.CRM.Tool.ZeroTools;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;

@SpringBootTest
public class test {


    @Test
    public void vi() throws IOException {

        SimpleDateFormat  sdf = new SimpleDateFormat("yyyyMMdd");
        ProcessBuilder builder = new ProcessBuilder(
                "cmd.exe", "/c", "cd  C:\\MAMP\\bin\\mysql\\bin && mysqldump -uroot -proot crm > C:\\Users\\jetec\\SynologyDrive\\crm"+sdf.format(new Date())+".sql");
        builder.redirectErrorStream(true);
        Process p = builder.start();
        BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
        String line;
        while (true) {
            line = r.readLine();
            if (line == null) { break; }
            System.out.println(line);
        }


    }
}

