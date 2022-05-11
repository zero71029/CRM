<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">


            <!-- <%-- 主要的CSS、JS放在這裡--%> -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
            <title>CRM客戶管理系統</title>



        </head>


        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-md-11 app">
                        <el-dialog title="成功的公司" :visible.sync="dialogVisible" width="30%">
                            寄了{{successList.length}}封 <br>
                            <p v-for="(item, index) in successList" :key="index">{{item}}</p>
                            <span slot="footer" class="dialog-footer">
                            </span>
                        </el-dialog>
                        <div class="row ">
                            <!-- <%-- 中間主體--%> -->

                            <div class="col-md-11 ">
                                <div class="row ">
                                    <div class="col-md-12 ">
                                        <el-upload class="upload-demo"
                                            action="${pageContext.request.contextPath}/zeroMail"
                                            :on-preview="handlePreview" :before-remove="beforeRemove"
                                            :file-list="fileList" :on-success="upSuccess">
                                            <el-button size="small" type="primary">上傳</el-button>
                                        </el-upload>
                                    </div>
                                </div>

                                


                                <div class="row ">
                                    <div class="col-md-12 ">
                                        <span>用 @company 替換公司名稱</span><br>
                                        <span>用 @contact 替換聯絡人名稱</span>
                                    </div>
                                </div>


                                <div class="row ">
                                    <div class="col-md-12 ">
                                        <form action="${pageContext.request.contextPath}/sendMail" method="post"
                                            id="sendForm">
                                            <div class="mb-3 row">
                                                <label for="inputPassword" class="col-sm-1 col-form-label"> 主題:</label>
                                                <div class="col-sm-11">
                                                    <input type="text" class="form-control" id="Subject"
                                                        name="Subject">
                                                </div>
                                            </div>


                                            <input type="hidden" name="fileName" v-model="fileName">
                                            <textarea id="content"></textarea>
                                        </form>
                                        <button @click="test">寄信</button>
                                    </div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-12 ">

                                    </div>
                                </div>




                            </div>


                            <p>&nbsp;</p>

                        </div>
                    </div>
                </div>
            </div>

        </body>
        <!-- tiny 所見即所得-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/4.7.6/tinymce.min.js"></script>
        <script>
            tinymce.init({
                language: 'zh_TW',
                language_url: '${pageContext.request.contextPath}/tinymce/langs/zh_TW.js',
                selector: '#content',
                height: '400',
                plugins: [
                    "autosave advlist autolink lists link image charmap print preview hr anchor pagebreak ",
                    "searchreplace wordcount visualblocks visualchars code  fullscreen",
                    "insertdatetime media nonbreaking save table contextmenu directionality",
                    "emoticons template paste textcolor colorpicker textpattern imagetools"
                ],
                toolbar1: "insertfile undo redo restoredraft|  fontsizeselect lineheight| alignleft aligncenter alignright alignjustify | bullist numlist outdent indent  " +
                    "bold italic underline strikethrough subscript superscript | forecolor backcolor charmap emoticons | link unlink image media | cut copy paste | insertdatetime fullscreen code|table hr  |" +
                    "lineheight print preview code",
                menubar: false,
                image_advtab: true,
                autosave_ask_before_unload: false,//關閉 嘗試關閉當前窗口時提示他們有未保存的更改
                ax_wordlimit_num: 990,
                ax_wordlimit_callback: function (editor, txt, num) {
                    alert('当前字数：' + txt.length + '，限制字数：' + num);
                }
            });
        </script>

        <script>


            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        fileName: "",
                        fileList: [],
                        textarea: "",
                        dialogVisible: false,
                        successList: [],
                    }
                },
                methods: {
                    handlePreview(file) {
                        console.log(file);
                    },
                    beforeRemove(file, fileList) {
                        return this.$confirm(`確定刪除 `);
                    },
                    upSuccess(response, file, fileList) {
                        console.log(response, file, fileList);
                        this.file = file;
                        this.fileName = file.name;
                    },
                    test() {
                        console.log(tinyMCE.editors[0].getContent());

                        if (this.fileName == "") {

                            this.$message({
                                type: 'error',
                                message: '先上傳檔案!'
                            });
                        } else {
                            var testData = new FormData();
                            testData.append("fileName","zero.csv");
                            testData.append("content", tinyMCE.editors[0].getContent());
                            testData.append("Subject", $("#Subject").val());
                            $.ajax({
                                    url: '${pageContext.request.contextPath}/sendMail',//接受請求的Servlet地址
                                    type: 'POST',
                                    data: testData,
                                    async: false,//同步請求
                                    cache: false,//不快取頁面
                                    contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                                    processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                                    success: function (url) {
                                        console.log(url);

                                    },
                                    error: function (returndata) {
                                        console.log(returndata);
                                    }
                                });
                            this.$confirm("<p>已寄預覽信給 jeter.tony56@gmail.com  jetecmarketing03@gmail.com  ychen@jetec.com.tw 請確認再行動</p>"+                             
                            "<p>&nbsp;</p>" + tinyMCE.editors[0].getContent() + "<p>&nbsp;</p>", '預覽內容', {
                                dangerouslyUseHTMLString: true,
                                confirmButtonText: '确定',
                                cancelButtonText: '取消'
                            }).then(() => {

                               
                            var formData = new FormData($("#sendForm")[0]);
                            formData.append("content", tinyMCE.editors[0].getContent());
                               



                                $.ajax({
                                    url: '${pageContext.request.contextPath}/sendMail',//接受請求的Servlet地址
                                    type: 'POST',
                                    data: formData,
                                    async: false,//同步請求
                                    cache: false,//不快取頁面
                                    contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                                    processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                                    success: function (url) {
                                        console.log(url);
                                        vm.successList = url;
                                        vm.dialogVisible = true;
                                    },
                                    error: function (returndata) {
                                        console.log(returndata);
                                    }
                                });

                            }).catch(() => {
                                this.$message({
                                    type: 'info',
                                    message: '已取消删除'
                                });
                            });
                        }

                    },
                }
            })
        </script>
        <style>
            .el-upload-list__item-name [class^=el-icon] {
                height: auto;
            }
        </style>

        </html>