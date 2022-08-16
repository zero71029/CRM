package com.jetec.CRM;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jetec.CRM.model.AdminBean;
import com.jetec.CRM.model.TrackBean;
import com.jetec.CRM.repository.MarketRepository;
import com.jetec.CRM.repository.TrackRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class test {



    @Test
    public void XXX() throws Exception {
        int[] prices = new int[]{0,0,1,1,1,2,2,3,3,4};






    }

    @Test
    public void test2() throws Exception {
        Pageable pageable = PageRequest.of(0, 40, Sort.Direction.DESC, "aaa");
        for (int x = 0; x < 10; x++) {
            Long start = System.currentTimeMillis();
            for (int i = 0; i < 1000; i++) {

            }
            System.out.println("==================test2=====================");

            System.out.println("花費時間 : " + (System.currentTimeMillis() - start));
        }
    }

    @Test
    public void ObjectMapper() throws JsonProcessingException {


        ObjectMapper objectMapper = new ObjectMapper();

        // User Object 轉 json

        String json = objectMapper.writeValueAsString(new AdminBean());

        // json 轉 User Object
        AdminBean user2 = objectMapper.readValue(json, AdminBean.class);

        // List<User> 轉 json
        List<AdminBean> ulist = new ArrayList<>();

        ulist.add(new AdminBean());
        String ujson = objectMapper.writeValueAsString(ulist);

        // json 轉 List<User>
        List<AdminBean> urlist = objectMapper.readValue(ujson, new TypeReference<List<AdminBean>>() {});

        // Map<String, User> 轉 json
        HashMap<String, AdminBean> umap = new HashMap<>();

        umap.put("John", new AdminBean());
        String mjson2 = objectMapper.writeValueAsString(umap);

        // json 轉 Map<String, User>
        Map<String, AdminBean> urMap = objectMapper.readValue(mjson2, new TypeReference<HashMap<String, AdminBean>>() {});


    }


    /**
     * 從網路Url中下載檔案
     *
     * @param urlStr
     * @param fileName
     * @param savePath
     * @throws IOException
     */
    public static void downLoadFromUrl(String urlStr, String fileName, String savePath) throws IOException {
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        //設定超時間為3秒
        conn.setConnectTimeout(3 * 1000);
        //防止遮蔽程式抓取而返回403錯誤
        conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");

        //得到輸入流
        InputStream inputStream = conn.getInputStream();
        //獲取自己陣列
        byte[] getData = readInputStream(inputStream);

        //檔案儲存位置
        File saveDir = new File(savePath);
        if (!saveDir.exists()) {
            saveDir.mkdirs();
        }
        File file = new File(saveDir + File.separator + fileName);
        FileOutputStream fos = new FileOutputStream(file);
        fos.write(getData);
        if (fos != null) {
            fos.close();
        }
        if (inputStream != null) {
            inputStream.close();
        }

        System.out.println("info:" + url + " download success");

    }

    /**
     * 從輸入流中獲取位元組陣列
     *
     * @param inputStream
     * @return
     * @throws IOException
     */
    public static byte[] readInputStream(InputStream inputStream) throws IOException {
        byte[] buffer = new byte[1024];
        int len = 0;
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        while ((len = inputStream.read(buffer)) != -1) {
            bos.write(buffer, 0, len);
        }
        bos.close();
        return bos.toByteArray();
    }

    @Test
    public void dddd() {
        URL url = null;

        try {
            //生成圖片連結的url類
            url = new URL("https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=csv&date=20220809&stockNo=5871");
            File file = new File("c:/file/aaa.csv");

            //將url連結下的圖片以位元組流的形式儲存到 DataInputStream類中
            DataInputStream dataInputStream = new DataInputStream(url.openStream());
            //為file生成對應的檔案輸出流
            FileOutputStream fileOutputStream = new FileOutputStream(file);
            //定義位元組陣列大小
            byte[] buffer = new byte[1024];


            //從所包含的輸入流中讀取[buffer.length()]的位元組，並將它們儲存到緩衝區陣列buffer 中。
            //dataInputStream.read()會返回寫入到buffer的實際長度,若已經讀完 則返回-1
            while (dataInputStream.read(buffer) > 0) {
                fileOutputStream.write(buffer);//將buffer中的位元組寫入檔案中區
            }
            dataInputStream.close();//關閉輸入流
            fileOutputStream.close();//關閉輸出流


        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @Test
    public void sss() {

            int HttpResult; // 伺服器返回的狀態
            String ee = new String();
            try {
                URL url = new URL("https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=csv&date=20220809&stockNo=5871"); // 建立URL
                URLConnection urlconn = url.openConnection(); // 試圖連線並取得返回狀態碼
                urlconn.connect();
                HttpURLConnection httpconn = (HttpURLConnection) urlconn;
                HttpResult = httpconn.getResponseCode();
                if (HttpResult != HttpURLConnection.HTTP_OK) {
                    System.out.print("無法連線到");
                } else {
                    int filesize = urlconn.getContentLength(); // 取資料長度
                    InputStreamReader isReader = new InputStreamReader(urlconn.getInputStream(), "UTF-8");
                    BufferedReader reader = new BufferedReader(isReader);
                    StringBuffer buffer = new StringBuffer();
                    String line; // 用來儲存每行讀取的內容
                    line = reader.readLine(); // 讀取第一行
                    while (line != null) { // 如果 line 為空說明讀完了
                        buffer.append(line); // 將讀到的內容新增到 buffer 中
                        buffer.append(" "); // 新增換行符
                        line = reader.readLine(); // 讀取下一行
                    }
                    System.out.print(buffer.toString());
                    ee = buffer.toString();
                }
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }

        }



}

