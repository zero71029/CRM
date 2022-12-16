<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link rel="stylesheet" href="${pageContext.request.contextPath}\icons\bootstrap-icons.css">
            <!-- tiny所見即所得 -->
            <script src="${pageContext.request.contextPath}/tinymce/js/tinymce/tinymce.min.js"></script>


            <!-- <%-- 主要的CSS、JS放在這裡--%> -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
            <title>CRM客戶管理系統</title>
            <style>
                [v-cloak] {
                    display: none;
                }

                .cell {
                    border: 0px solid black;
                    border-bottom: 1px solid black;


                }

                .cellbackgroud {
                    background-color: #AAA;
                }

                .cellFrom {
                    border: 0px solid black;
                    /* width: 33%; */
                }

                .error {
                    color: red;
                }
            </style>

        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-md-11 app">
                        <div class="row " v-cloak>


                            <!-- <%--上傳 彈窗--%> -->

                            <el-dialog title="上傳" :visible.sync="imgVisible" width="30%">
                                <el-upload class="upload-demo" drag action="${pageContext.request.contextPath}/upfile"
                                    multiple :on-success="upSuccess" :before-upload="beforeAvatarUpload">
                                    <i class="el-icon-upload"></i>
                                    <div class="el-upload__text">將文件拖到此處，或<em>點擊上傳</em></div>
                                </el-upload>
                            </el-dialog>
                            <!-- <%--上傳 彈窗結束--%> -->







                            <div class="col-md-12">
                                <!-- <%-- 中間主體--%> -->
                                <div class="row ">
                                    <div class="col-md-2"></div>
                                    <div class="col-md-8">
                                        <br><br><br>
                                        <!--發布公告  -->
                                        <form
                                            :action="'${pageContext.request.contextPath}/laboratory/saveForum/'+this.forumid"
                                            method="post" id="myform" class="g-3 needs-validation">
                                            <div class="row">
                                                <input type="hidden" name="forumid" v-model="bean.forumid">
                                                <input type="hidden" name="member" v-model="bean.member">
                                                <input type="hidden" name="replytime" v-model="bean.replytime">
                                                <input type="hidden" name="remark" v-model="bean.remark">
                                                <input type="hidden" name="time" v-model="bean.time">
                                                <div class="row">
                                                    <div class="col-lg-10 cell position-relative cellbackgroud"
                                                        style="text-align: center;color:white;background-color: #569b92; font-size: 20px;">
                                                        發布公告
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-1 cell position-relative cellbackgroud">
                                                        主題*</div>
                                                    <div class="col-lg-9 cell" style="padding: 0%;">
                                                        <input type="text" class=" form-control cellFrom" name="name"
                                                            v-model="bean.name" maxlength="95" required>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-1 cell cellbackgroud">群組</div>
                                                    <div class="col-lg-4 cell" style="padding: 0%;">
                                                        <select input type="text"
                                                            class=" form-select cellFrom billboardGroup"
                                                            v-model="bean.forumgroup" name="forumgroup">
                                                            <option class="selItemOff" value="一般公告">一般公告</option>

                                                        </select>
                                                    </div>
                                                    <div class="col-lg-1 cell cellbackgroud" style="padding: 0%;">子項
                                                    </div>
                                                    <div class="col-lg-4 cell" style="padding: 0%;">
                                                        <select name="forumgroupid" id="" v-model="bean.forumgroupid"
                                                            class="form-select billtownoption">
                                                            <!--  -->

                                                            <!--  -->
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="row">

                                                    <div class="col-lg-1 cell position-relative cellbackgroud">
                                                        內容*</div>
                                                    <div class="col-lg-9 cell " style="padding: 0%;">
                                                        <textarea class="cellFrom " name="content" style="width: 100%;"
                                                            rows="10" id="content" >{{content}}</textarea>
                                                    </div>

                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-1 cell cellbackgroud">狀態</div>
                                                    <div class="col-lg-9 cell" style="padding: 0%;">
                                                        <select input type="text" class=" form-select cellFrom"
                                                            name="state" v-model="bean.state">
                                                            <option class="selItemOff">公開</option>
                                                            <option class="selItemOff">封存</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <c:if test='${user.position == "系統" || user.position == "總經理"}'>
                                                    <div class="row">
                                                        <div class="col-lg-1 cell cellbackgroud">置頂</div>
                                                        <div class="col-lg-9 cell">
                                                            <input type="radio" name="top" id="asd" v-model="bean.top"
                                                                value="0">
                                                            <label for="asd">一般</label>
                                                            <input type="radio" name="top" id="top" v-model="bean.top"
                                                                value="1">
                                                            <label for="top">置頂</label>
                                                        </div>
                                                    </div>
                                                </c:if>
                                                <c:if test='${!(user.position == "系統" || user.position == "總經理")}'>
                                                    <input type="hidden" name="top" value="">
                                                </c:if>
                                                <c:if test="${bean.user == user.name  || empty bean}">
                                                    <div class="row">
                                                        <div class="col-lg-10" style="padding: 0%;">
                                                            <button type="submit"
                                                                style="width: 100%;background-color: #08604f;color: white;"
                                                                class="btn ">儲存
                                                            </button>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </form>
                                        <br><br>
                                    </div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-12"></div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-12"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>
        <script>
            tinymce.init({
                selector: 'textarea',  // change this value according to your HTML
                plugins: ["autosave preview code link media hr charmap emoticons"],
                toolbar: 'undo redo |  bold italic fontsizeselect | forecolor backcolor charmap emoticons| alignleft aligncenter alignright alignjustify hr | outdent indent   | link unlink selectiveDateButton media |   preview code',
                language: 'zh_TW',
                height: '500',
                //自訂義按鈕
                setup: (editor) => {
                    //定義新icon
                    editor.ui.registry.addIcon('triangleUp', `<i class="bi bi-cloud-arrow-up" style="font-size:26px"></i>`);
                    //設定功能
                    editor.ui.registry.addButton('selectiveDateButton', {
                        icon: 'triangleUp',
                        tooltip: 'Insert Image',
                        onAction: (_) => {
                            vm.imgVisible = true;
                        },
                    });
                }
            });
        </script>
        <script>
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        forumid: "",
                        bean: {
                            forumgroup: "一般公告",
                            member: "${user.name}",
                            state: "公開",
                            top: 0,
                        },
                        imgVisible: false,
                        content: "",
                    }
                },
                created() {
                    const url = new URL(window.location.href);
                    this.forumid = url.searchParams.get("forumid");
                    console.log(this.forumid);
                    console.log(this.bean.member);
                    //如果有id,就是要修改
                    if (this.forumid != null) {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/laboratory/getDetail?forumid=' + this.forumid,
                            type: 'get',
                            success: json => {
                                console.log(json);
                                if (json.code == 200) {
                                    this.bean = json.data.bean;
                                    this.content = json.data.content;
                                }
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    }
                },
                methods: {
                    //上傳成功
                    upSuccess(response, file, fileList) {
                        console.log("response", response);
                        console.log("file", file);




                        if (response.indexOf("png") > 0 || response.indexOf("gif") > 0 || response.indexOf("jpg") > 0 || response.indexOf("jpeg") > 0) {
                            const img = `<p><img src="${pageContext.request.contextPath}/file/` + response + `"  style="max-width: 100%; height: auto; width: 50%;" ></p><p>&nbsp;</p>`;
                            console.log(img);
                            this.imgVisible = false;
                            tinymce.activeEditor.execCommand('mceInsertContent', false, img);
                        } else {
                            const img = `<p><a href="${pageContext.request.contextPath}/file/` + response + `" target="_blank"  > ` + file.name + `</a></p><p>&nbsp;</p>`;
                            console.log(img);
                            this.imgVisible = false;
                            tinymce.activeEditor.execCommand('mceInsertContent', false, img);
                        }






                    },
                    //上船之前
                    beforeAvatarUpload() {

                    }
                },
            })
        </script>


   

        </html>