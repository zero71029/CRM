package com.jetec.CRM.Tool;

import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.data.redis.core.StringRedisTemplate;

public class note {
    // 筆記
    ///////////////////////////////////////////
    // TRACE < DEBUG < INFO < WARN < ERROR < FATAL

    ///////////////////////////////////////////
//	返回上一頁
//	window.history.back();location.reload();
////////////////////
// sql修改为不自动更新（只是插入是自动生成当前时间）
//alter table hello change uptime uptime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
    //////////////////////////////////////
//	重置 MySQL 自增列 AUTO_INCREMENT 初時值
//	ALTER TABLE tbl AUTO_INCREMENT = 1;
//////////////////////////////////
//	一键复制至剪切板
//	url.select();
//    document.execCommand("Copy");
//////jpa排序
    // Sort sort = Sort.by(Direction.DESC,"marketid");
    // return mr.findAll( sort);
///////////////////////////////
    //更新application
//	HttpServletRequest sce
//	ServletContext app = sce.getServletContext();
//	app.setAttribute("billboardgroup", bgr.findAll());
//////////ajax
//	var formData = new FormData($(".uppdf")[0]);
//	$.ajax({
//        url: '${pageContext.request.contextPath}/CRM/selectContactByClientName/' + $("input[name='client']").val(),//接受請求的Servlet地址
//        type: 'POST',
//        // data: formData,
//        // async: false,//同步請求
//        // cache: false,//不快取頁面
//        // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
//        // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
//        success: function (json) {
//            $(".CCC").empty();
//
//            for (var j of json) {
//                console.log(j);
//
//                $(".CCC").append('<div class="row TTT" onclick="clickContact(`' + j.name + '`,`' + j.phone + '`,`' + j.moblie + '`)">' +
//                    '<div class="col-md-1"></div>' +
//                    '<div class="col-md-3">' + j.name + '</div>' +
//                    '<div class="col-md-3">' + j.phone + '</div>' +
//                    '<div class="col-md-3">' + j.moblie + '</div>' +
//                    '</div>');
//            }
//        },
//        error: function (returndata) {
//            console.log(returndata);
//        }
//    });
    ////////////////////////////////////////////////////



//<dependency>
//        <groupId>org.springframework.boot</groupId>
//        <artifactId>spring-boot-starter-data-redis-reactive</artifactId>
//</dependency>


//            # Redis資料庫索引（預設為0）
//    spring.redis.database=0
//            # Redis伺服器地址
//    spring.redis.host=localhost
//            # Redis伺服器連接端口
//    spring.redis.port=6379
//            # Redis伺服器連接密碼（預設為空）
//    spring.redis.password=
//            # 連接池最大連接數（使用負值表示沒有限制）
//    spring.redis.jedis.pool.max-active=8
//            # 連接池最大阻塞等待時間（使用負值表示沒有限制）
//    spring.redis.jedis.pool.max-wait=-1
//            # 連接池中的最大空閒連接
//    spring.redis.jedis.pool.max-idle=8
//            # 連接池中的最小空閒連接
//    spring.redis.jedis.pool.min-idle=0
//            # 連接超時時間（毫秒）
//    spring.redis.timeout=1000

    // 注入StringRedisTemplate類別，用來操作Redis
//    @Autowired
//    StringRedisTemplate stringRedisTemplate;




}
