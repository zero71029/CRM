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
            <title>ZeroMail</title>
        </head>


        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-md-11 app">
                        <el-dialog title="寄預覽信" :visible.sync="tesVisible" width="30%"
                        :close-on-click-modal ="false">
                            <input type="email" v-model="testMail" class="form-control">

                  
                            <span slot="footer" class="dialog-footer">
                                <el-button type="primary" @click="test">确 定</el-button>
                            </span>
                        </el-dialog>

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
                                                    <input type="text" class="form-control" id="Subject" name="Subject">
                                                </div>
                                            </div>
                                            <input type="hidden" name="fileName" v-model="fileName">
                                            <textarea id="content"></textarea>
                                        </form>
                                        <el-button type="primary" @click="tesVisible = true">寄預覽信</el-button>
                                        <el-button type="danger" @click="sendMail">寄信</el-button>
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
            $(".marketing").show();

            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        testMail: "",
                        fileName: "",
                        fileList: [],
                        textarea: "",
                        dialogVisible: false,
                        tesVisible: false,
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
                        var testData = new FormData();
                        testData.append("testMail", this.testMail);
                        testData.append("content", tinyMCE.editors[0].getContent());
                        testData.append("Subject", $("#Subject").val());
                        $.ajax({
                            url: '${pageContext.request.contextPath}/Marketing/testMail',
                            type: 'POST',
                            data: testData,
                            async: false,
                            cache: false,
                            contentType: false,
                            processData: false,
                            success: response=> {
                                if(response.code == 300){
                                    this.$message.error(response.message)
                                }
                                if(response.code == 200){
                                    this.$message.success(response.message);
                                    this.tesVisible=false;
                                }                         

                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });



                    }, sendMail() {
                        if (this.fileName == "") {
                            this.$message({
                                type: 'error',
                                message: '先上傳檔案!'ㄡ
                            });
                        } else {
                            var formData = new FormData($("#sendForm")[0]);
                            formData.append("content", tinyMCE.editors[0].getContent());
                            $.ajax({
                                url: '${pageContext.request.contextPath}/Marketing/sendMail',
                                type: 'POST',
                                data: formData,
                                async: false,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: function (url) {
                                    console.log(url);
                                    vm.successList = url;
                                    vm.dialogVisible = true;
                                },
                                error: function (returndata) {
                                    console.log(returndata);
                                }
                            });
                        }
                    }
                }
            })
        </script>
        <style>
            .el-upload-list__item-name [class^=el-icon] {
                height: auto;
            }

            .zeroMail {
                /* 按鈕顏色 */
                background-color: #afe3d5;
            }
        </style>

        </html>