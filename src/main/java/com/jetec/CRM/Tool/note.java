package com.jetec.CRM.Tool;

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
}
