<?php
//Import PHPMailer classes into the global namespace
//These must be at the top of your script, not inside a function
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

//Load Composer's autoloader

    require 'Exception.php'; 
    require 'PHPMailer.php'; 
    require 'SMTP.php';
//Create an instance; passing `true` enables exceptions
$mail = new PHPMailer(true);
$lianluorenxingming2= $_POST['lianluorenxingming2'];//連絡人姓名
$zuzhidanwei2 = $_POST['zuzhidanwei2'];//組織單位
$email2 = $_POST['email2'];//Email
$line = $_POST['line'];//line
$lianluodianhua = $_POST['lianluodianhua'];//連絡電話
$dezhi2 = $_POST['dezhi2'];//地址
$shifouyijingxiangwomengoumaichanpin_ = $_POST['shifouyijingxiangwomengoumaichanpin_'];//是否已經向我們購買產品? 
$chanpinxinghao = $_POST['chanpinxinghao'];//產品型號
$wentishuoming = $_POST['wentishuoming'];//問題說明
//

$zhizaoye2 = ($_POST['zhizaoye2'] ? "機械製造業,":"");
$gongchengguwen2 = ($_POST['gongchengguwen2'] ? "工程顧問,":"");
$maoyiye2 = ($_POST['maoyiye2'] ? "貿易相關,":"");
$jianzhuyingzao2 = ($_POST['jianzhuyingzao2'] ? "建築營造業,":"");
$xuexiao_gongjiajiguan2 = ($_POST['xuexiao_gongjiajiguan2'] ? "學校/研究/公家機關,":"");
$fuwuye2 = ($_POST['fuwuye2'] ? "電子半導體業,":"");
$qingzhong_shihuagongye = ($_POST['qingzhong_shihuagongye'] ? "輕重/石化工業,":"");
$chumunongye = ($_POST['chumunongye'] ? "畜牧農業,":"");
$qita2 = ($_POST['qita2'] ? "其他,":"");





$body = "
從 技術支援 發出<br>

資料<br>
---------------------------------------------------------------------------------<br>
聯絡人: {$lianluorenxingming2}<br>
組織單位: {$zuzhidanwei2}<br>
E-Mail: {$email2}<br>
LINE: {$line} <br>
聯絡電話 : {$lianluodianhua}<br>
地址: {$dezhi2}<br>
是否已經向我們購買產品?:{$shifouyijingxiangwomengoumaichanpin_}
產業類別 : {$zhizaoye2} {$gongchengguwen2} {$maoyiye2} {$jianzhuyingzao2} {$xuexiao_gongjiajiguan2} {$fuwuye2} {$qingzhong_shihuagongye2}
 {$chumunongye} {$qita2}<br><br><br>
---------------------------------------------------------------------------------
<br>
需求說明:<br>
{$wentishuoming}
";






$recaptcha = $_POST['g-recaptcha-response'];
// Google reCAPTCHA 網站密鑰
$data['secret'] = '6LeTLs8eAAAAAJHxyEUjlTCjIpPKT1VzbuH467MJ';
$data['response'] = $_POST['g-recaptcha-response'];
$ch = curl_init();
// 使用CURL驗證
curl_setopt($ch,CURLOPT_SSL_VERIFYHOST,0);
curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,0);
curl_setopt($ch,CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_URL, 'https://www.google.com/recaptcha/api/siteverify');
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
$result = curl_exec($ch);
curl_close($ch);
// 解密
$result = json_decode($result, true);

// 檢查是否通過驗證
if ( ! isset($result['success']) || ! $result['success']) {
    // 驗證失敗
    echo '返回失敗';echo '<br>';
    echo $recaptcha;echo '<br>';
    echo $result['error-codes'];echo '<br>';
} else {
    // 驗證成功
    if($result['score'] >= 0.7){ 
        try {
            //Server settings

            $mail->isSMTP();                                            //使用 SMTP 發送
            $mail->Host       = 'smtp.gmail.com';                     //設置SMTP服務器通過
            $mail->SMTPAuth   = true;                                   //啟用 SMTP 認證
            $mail->Username   = 'jeter.tony56@gmail.com';                     //SMTP username
            $mail->Password   = 'tlcfmczhhdahukbj';                               //SMTP password
            $mail->CharSet   = "UTF-8"; //設定郵件編碼
            $mail->Port = 25;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`
        
            //Recipients
            $mail->setFrom('jeter.tony56@gmail.com', $lianluorenxingming2);
            $mail->addAddress('jeter.tony56@gmail.com');     //添加收件人
            $mail->addAddress('sales@jetec.com.tw' );     //添加收件人
            $mail->addAddress('jetec.co@msa.hinet.net');     //添加收件人
            $mail->addAddress('ychen@jetec.com.tw');     //添加收件人
            //Content
            $mail->isHTML(true);                                  //設置郵件格式為 HTML 
            $mail->Subject = '技術支援';
            $mail->Body    = $body;//這是 HTML 郵件正文
            $mail->AltBody = $body;//這是非 HTML 郵件客戶端的純文本正文
            
        
            $mail->send();
            echo 'true';
        } catch (Exception $e) {
            echo "寄信失敗";
        }
    }else{
        echo $result['score'];echo '<br>';
        echo '驗證失敗';
    }
}
