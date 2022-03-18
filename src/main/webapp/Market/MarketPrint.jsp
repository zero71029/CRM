<!DOCTYPE html>
<html lang="zh-TW">

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>列印</title>
            <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">
            <!-- bootstrap的CSS、JS樣式放這裡  -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">

            <link rel="stylesheet" href="${pageContext.request.contextPath}\icons\bootstrap-icons.css">
            <!-- 引入样式 vue-->
            <script src="${pageContext.request.contextPath}/js/vue.js"></script>
            <!-- 引入element-ui样式 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/js/element-ui.css">
            <!-- 引入element-ui组件库 -->
            <script src="${pageContext.request.contextPath}/js/element-ui.js"></script>
            <style>
                table tr .cellz {
                    background-color: #CCC;
                }
            </style>
        </head>

        <body>
            <div class="container-fluid app">
                <div class="row"> &nbsp; </div>
                <div class="row">
                    <div class="col-lg-2"></div>
                    <div class="col-lg-8 ">
                        <el-form ref="form" :model="bean" label-width="80px"
                            action="${pageContext.request.contextPath}/task/save" method="post">
                            <div class="row">
                                <table class="table table-bordered" style="border-radius: 15px;">
                                    <tr>
                                        <td colspan="4" class="bg-danger text-white text-center"
                                            style="font-size: 1.5rem; width: 600px;">銷售機會</td>


                                    </tr>
                                    <tr>
                                        <td class="cellz">機會名稱 </td>
                                        <td colspan="3">
                                            {{bean.name}}{{bean.serialnumber}}
                                        </td>

                                        <td class="cellz">創建時間</td>
                                        <td>{{bean.aaa}} </td>
                                    </tr>
                                    <tr>
                                        <td class="cellz">公司名 </td>
                                        <td colspan="2">
                                            {{bean.client}}
                                        </td>
                                        <td>{{bean.serialnumber}}</td>
                                        <td class="cellz">負責人</td>
                                        <td>{{bean.user}}</td>
                                    </tr>
                                    <tr>
                                        <td class="cellz">聯絡人</td>
                                        <td colspan="2">
                                            {{bean.contactname}} {{bean.jobtitle}} {{bean.contacttitle}}
                                        </td>
                                        <td></td>
                                        <td class="cellz">階段</td>
                                        <td>{{bean.stage}}</td>
                                    </tr>

                                    <tr>
                                        <td class="cellz">聯絡人電話</td>
                                        <td>{{bean.contactphone}}  <span v-if="bean.contactextension != ''"> 分機:{{bean.contactextension}}</span>  </td>
                                        <td class="cellz">公司電話</td>
                                        <td>{{bean.phone}}<span v-if="bean.extension != ''"> 分機:{{bean.extension}}</span></td>
                                        <td class="cellz">重要性</td>
                                        <td>{{bean.important}}</td>
                                    </tr>
                                    <tr>
                                        <td class="cellz">聯絡人手機</td>
                                        <td>{{bean.contactmoblie}}</td>
                                        <td class="cellz">產業</td>
                                        <td>{{bean.type}}</td>
                                        <td colspan="2">報價內容 </td>
                                    </tr>
                                    <tr>
                                        <td class="cellz">聯絡人Email</td>
                                        <td>{{bean.contactemail}}</td>
                                        <td class="cellz">來源</td>
                                        <td>{{bean.source}}</td>
                                        <td colspan="2" style="width: 300px;" v-html="bean.quote">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="cellz">Line</td>
                                        <td>{{bean.line}}</td>
                                        <td class="cellz">聯絡方式</td>
                                        <td>{{bean.contactmethod}}</td>
                                    </tr>
                                    <tr>
                                        <td class="cellz">傳真</td>
                                        <td>{{bean.fax}}</td>
                                        <td class="cellz"></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="bg-danger text-white text-center"
                                            style="font-size: 1.5rem;">需求</td>
                                    </tr>
                                    <tr>
                                        <td class="cellz">產品類別</td>
                                        <td>{{bean.producttype}}</td>
                                        <td class="cellz">產品名稱</td>
                                        <td>{{bean.product}}</td>
                                    </tr>
                                    <tr>
                                        <td class="cellz">預算</td>
                                        <td>{{bean.number}}</td>
                                        <td class="cellz">成交機率</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="cellz">案件類型</td>
                                        <td>{{bean.createtime}}</td>
                                        <td class="cellz">結束時間</td>
                                        <td>{{bean.endtime}}</td>
                                    </tr>
                                    <tr>
                                        <td class="cellz">描述</td>
                                        <td colspan="3" v-html="bean.message"></td>

                                    </tr>
                                </table>
                                <table class="table table-bordered" style="border-radius: 15px;">
                                    <tr>
                                        <td colspan="4" class="bg-danger text-white text-center"
                                            style="font-size: 1.5rem;">追蹤資訊</td>
                                    </tr>
                                    <tr>
                                        <td>客人描述</td>
                                        <td> 追蹤結果</td>
                                        <td> </td>
                                    </tr>
                                    <tr v-for="(s, index) in TrackList" :key="index">
                                        <td v-html="s.trackdescribe"></td>
                                        <td v-html="s.result"></td>
                                        <td> {{s.remark}} <br> {{s.tracktime}}</td>

                                    </tr>
                                </table>
                            </div>
                         

                        </el-form>
                    </div>

                </div>
                <!-- 中間主體結束 -->
            </div>

            <script>
                String.prototype.insert = function (index, string) {
                    if (index > 0)
                        return this.substring(0, index) + string + this.substring(index, this.length);
                    else
                        return string + this;
                };
                function formatPhone(sb) {
                    if (sb.length == 10) {
                        sb = sb.insert(2, "-");
                        sb = sb.insert(7, "-");
                    }
                    if (sb.length == 9) {
                        sb = sb.insert(2, "-");
                        sb = sb.insert(6, "-");
                    }
                    if (sb.length == 8) {
                        sb = sb.insert(5, "-");
                    }
                    if (sb.length == 7) {
                        sb = sb.insert(4, "-");
                    }
                    return sb;
                }
                const vm = new Vue({
                    el: ".app",
                    data() {
                        return {
                            bean: {},
                            TrackList: [],
                        }
                    },
                    watch: {
                        TrackList: {
                            handler(newValue, oldValue) {
                                console.log("newValue", newValue);
                                for (var track of newValue) {
                                    track.trackdescribe = track.trackdescribe.replace(/\r\n/g, '<br />');
                                    track.result = track.result.replace(/\r\n/g, '<br />');
                                }
                            }
                        }
                    },
                    created() {

                        var url = new URL(location.href);
                        console.log(url.searchParams.get("id"));





                        $.ajax({
                            url: '${pageContext.request.contextPath}/Market/init/'+url.searchParams.get("id"),
                            type: 'POST',
                            async: false,
                            cache: false,
                            success: (response => (
                                this.bean = response.bean,
                                // this.existsCustomer = response.existsCustomer,
                                // this.changeMessageList = response.changeMessageList,
                                this.bean.phone = formatPhone(this.bean.phone),
                                this.bean.contactphone = formatPhone(this.bean.contactphone),
                                this.bean.contactmoblie = formatPhone(this.bean.contactmoblie),
                                this.oldBean = Object.assign({}, this.bean)

                            )),
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        })
                        //取得追蹤資訊
                        $.ajax({
                            url: '${pageContext.request.contextPath}/Potential/client/' + this.bean.customerid,
                            type: 'POST',
                            async: false,
                            cache: false,
                            success: (response => (
                                this.TrackList = response
                            )),
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        })
                        var regRN = /\r\n/g;
                        this.bean.quote = this.bean.quote.replace(/\r\n/g, '<br />');
                        this.bean.message = this.bean.message.replace(/\r\n/g, '<br />');

                        
                    },

                })
            </script>

        </body>

</html>