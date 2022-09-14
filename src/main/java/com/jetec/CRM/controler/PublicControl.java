package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.DirectorService;
import com.jetec.CRM.controler.service.SystemService;
import com.jetec.CRM.controler.service.WorkSerivce;
import com.jetec.CRM.model.*;
import com.jetec.CRM.repository.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.nio.file.Files;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
public class PublicControl {
    @Autowired
    DirectorService ds;
    @Autowired
    AdminRepository ar;
    @Autowired
    SystemService ss;
    @Autowired
    WorkSerivce ws;
    @Autowired
    ZeroTools zTools;
    @Autowired
    AuthorizeRepository authorizeRepository;
    @Autowired
    BillboardRepository br;
    @Autowired
    BillboardFileRepository bfr;
    @Autowired
    BillboardReplyRepository brr;
    @Autowired
    ReplyAdviceRepository rar;
    @Autowired
    ReplyFileRepository rfr;
    @Autowired
    ReplyTimeRepository rtr;

    Logger logger = LoggerFactory.getLogger("PublicControl");

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//登入驗證
    @RequestMapping("/UserAuthorize")
    @ResponseBody
    public boolean UserAuthorize(Authentication authentication, HttpSession session) {
        logger.info("登入驗證");
        // 驗證 補session user
        if (authentication != null) {
            ss.auth(authentication, session);
            return true;
        }
        System.out.println("沒有authentication");
        return false;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 主頁面
    @RequestMapping(path = {"/", "/index"})
    public String index() {
        return "redirect:/billboard?pag=1&sort=lastmodified";
    }

    // 主頁面
    @RequestMapping(path = {"billboard"})
    public String billboard(Model model, HttpSession session, @RequestParam("pag") Integer pag,
                            @RequestParam("sort") String sortString) {
        System.out.println("*****主頁面*****");
        if ("createtime".equals(sortString)) sortString = "lastmodified";
        // 分頁
        if (pag < 1)
            pag = 1;
        pag--;
        Sort sort = Sort.by(Direction.DESC, sortString);
        Pageable p = PageRequest.of(pag, 40, sort);
        Page<BillboardBean> page = br.getByStateAndTop("公開", "", p);
//		全部有幾頁
        model.addAttribute("TotalPages", page.getTotalPages());
        // 抓取登入者
        AdminBean user = (AdminBean) session.getAttribute("user");
        // 如果有登入者 更新資料
        if (user != null) {
            // 抓被@的資料
            AdminBean adminBean = ar.getById(user.getAdminid());
//            List<BillboardAdviceBean> a = adminBean.getAdvice();
//            for (BillboardAdviceBean bean : a) {
//                if (bean.getReply().equals("1"))
//                    advice.add(br.getById(bean.getBillboardid()));
//            }
//            // 抓被未讀的資料
//            List<AdminMailBean> mail = adminBean.getMail();
//            for (AdminMailBean bean : mail) {
//                unread.add(br.getById(bean.getBillboardid()));
//            }

            //////////////////////////////////////////////////////////////////////////////
            if ("lastmodified".equals(sortString)) {
                model.addAttribute("list", ss.getBillboardList("公開", adminBean, pag, sort));
            }
            if ("reply.lastmodified".equals(sortString)) {
                model.addAttribute("list", ss.getBillboardList("公開", adminBean, pag, sort));
            }
            session.setAttribute("user", adminBean);
//            model.addAttribute("advice", advice);// 抓被@的資料
//            model.addAttribute("unread", unread);// 抓被未讀的資料
        } else {
            AdminBean xxx = null;
            if ("lastmodified".equals(sortString))
                model.addAttribute("list", ss.getBillboardList("公開", xxx, pag, sort));
            if ("reply.lastmodified".equals(sortString)) {
                model.addAttribute("list", ss.getBillboardList("公開", xxx, pag, sort));
            }
        }
        return "/CRM";
    }

    //初始化(讀取未讀)
    @RequestMapping(path = {"init"})
    @ResponseBody
    public Map<String, Object> CRMInit(HttpSession session) {
        System.out.println("*****初始化*****");
        Map<String, Object> result = new HashMap<>();
        List<BillboardBean> advice = new ArrayList<>();
        List<BillboardBean> unread = new ArrayList<>();
        // 抓取登入者
        AdminBean user = (AdminBean) session.getAttribute("user");
        // 如果有登入者 更新資料
        if (user != null) {
            // 抓被@的資料
            AdminBean adminBean = ar.getById(user.getAdminid());
            List<BillboardAdviceBean> a = adminBean.getAdvice();
            for (BillboardAdviceBean bean : a) {
                if ("1".equals(bean.getReply()))
                    advice.add(br.getById(bean.getBillboardid()));
            }
            // 抓被未讀的資料
            List<AdminMailBean> mail = adminBean.getMail();
            for (AdminMailBean bean : mail) {
                unread.add(br.getById(bean.getBillboardid()));
            }
        }
        result.put("advice", advice);
        result.put("unread", unread);
        return result;

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取公佈欄列表  依分類
    @RequestMapping("/selectBillboardGroup/{billboardgroupid}")
    public String selectBillboardGroup(Model model, @PathVariable("billboardgroupid") String billboardgroupid) {
//List<BillboardBean> resulet = ss.getBillboardList("公開");
        System.out.println("*****讀取公佈欄列表*****");
        model.addAttribute("list", ss.getBillboardList("公開", billboardgroupid));
        return "/CRM";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//登入
    @RequestMapping("/home")
    public String join(@RequestParam("username") String username, @RequestParam("password") String password,
                       HttpSession session) {
        if (ar.existsByEmailAndPassword(username, password)) {
            logger.info("{} 登入", username);
            session.setAttribute("user", ar.findByEmailAndPassword(username, password));
            return "redirect:/";
        }
        return "redirect:/time.jsp";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//登出
    @RequestMapping(path = {"/Signout"})
    public String Signout(HttpSession session) {
        logger.info("登出");
        session.invalidate();
        return "redirect:/";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//點擊已讀
    @RequestMapping("/read/{billboardid}/{adminid}")
    @ResponseBody
    public String read(@PathVariable("billboardid") Integer billboardid, @PathVariable("adminid") Integer adminid,
                       HttpSession session) {
        logger.info("{} 點擊已讀 {}", adminid, billboardid);
        String result = ss.saveRead(billboardid, adminid);
        session.setAttribute("user", ar.getById(adminid));
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//取消已讀
    @RequestMapping("/ReRead/{billboardid}/{adminid}")
    public String ReRead(@PathVariable("billboardid") Integer billboardid, @PathVariable("adminid") Integer adminid,
                         HttpSession session) {
        System.out.println("*****取消已讀*****");
        logger.info("{} 取消已讀 {}", adminid, billboardid);
        ss.ReRead(billboardid, adminid);
        session.setAttribute("user", ar.getById(adminid));
        return "redirect:/billboardReply/" + billboardid;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//進入公佈欄留言頁面
    @RequestMapping("/billboard/Reply/{id}")
    public String billboardReply(Model model, @PathVariable("id") Integer id, HttpSession session) {
        logger.info("進入公佈欄細節 {}", id);
        // 上傳檔案用
        model.addAttribute("uuid", ZeroTools.getUUID());
        AdminBean adminBean = (AdminBean) session.getAttribute("user");
        // 讀取公佈欄細節 如果有登入就已讀
        model.addAttribute("bean", ss.getBillboardById(id, adminBean));
        // 如果有登入 更新資料
        if (adminBean != null) session.setAttribute("user", ar.getById(adminBean.getAdminid()));
        // 讀取2星期內的訊息
//		model.addAttribute("news", ss.getBillboardByTime());
        // 讀取回覆
        model.addAttribute("reply", ss.getBillboardReply(id));
        return "/system/billboardReply";
    }

    //進入授權
    @RequestMapping("/authorize/{uuid}")
    public String authorize(Model model, @PathVariable("uuid") String uuid, HttpSession session) {
        if (authorizeRepository.existsById(uuid)) {
            AuthorizeBean authorizeBean = authorizeRepository.getById(uuid);
            AdminBean user = (AdminBean) session.getAttribute("user");
            if (user == null) return "redirect:/CRM.jsp?mess=2";
            logger.info("{} 進入授權 {}", user.getName(), uuid);
            if (user.getName().equals(authorizeBean.getUsed()) || "所有人".equals(authorizeBean.getUsed())) {
                model.addAttribute("authorizeBean", authorizeBean);
                return "/authorize";
            }
        }
        return "redirect:/CRM.jsp?mess=3";
    }

    // 儲存授權
    @RequestMapping("/saveAuthorize/{uuid}")
    public String saveAuthorize(@PathVariable("uuid") String uuid, BillboardBean bean, HttpSession session) {
        logger.info("儲存授權");
        bean.setRemark("(被授權)");
        bean.setUser(bean.getUser());
        // 存檔
        BillboardBean save = ss.SaveBillboard(bean, session);
        // 附件處理
        List<BillboardFileBean> list = bfr.findByAuthorize(uuid);
        for (BillboardFileBean b : list) {
            b.setBillboardid(save.getBillboardid());
            bfr.save(b);
        }
        // 刪除授權
        authorizeRepository.deleteById(uuid);

        return "redirect:/billboardReply/" + save.getBillboardid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索公布欄
    @RequestMapping("/selectBillboard")
    public String selectMarket(Model model, @RequestParam("search") String search) {
        logger.info("搜索公布欄 {}", search);
        model.addAttribute("list", ss.selectBillboardt(search));
        return "/CRM";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//新增員工
    @RequestMapping("/SaveAdmin")
    @ResponseBody
    public String SaveAdmin(AdminBean abean, HttpServletRequest req, HttpSession session) {
        System.out.println("*****新增員工*****");
        logger.info("新增員工");
        logger.info("{}", abean);
        if (!ar.existsByEmail(abean.getEmail())) {
            String save = ss.SaveAdmin(abean);
            ServletContext sce = req.getServletContext();
            sce.setAttribute("admin", ar.findByStateOrState("在職", "新"));
            AdminBean user = (AdminBean) session.getAttribute("user");
            if (user != null) {
                if ("系統".equals(user.getPosition()) || "主管".equals(user.getPosition())) {
                    zTools.mail("jeter.tony56@gmail.com","CRM新增員工 "+user.getName(),"CRM新增員工","");



                    return "儲存成功,<a href='/CRM/system/adminList/adminid'>返回</a>";
                }
            }
            return save;
        }
        return "Email已經被使用,請更換一個";
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//上傳型錄
    @RequestMapping("/upFile/{authorizeId}")
    @ResponseBody
    public String upFile(MultipartHttpServletRequest multipartRequest,
                         @PathVariable("authorizeId") String authorizeId) {
        logger.info("上傳型錄");
        String uuid = ZeroTools.getUUID();
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        System.out.println("fileMap " + fileMap);
//圖片儲存
        try {
            for (int i = 0; i <= fileMap.size(); i++) {
//2. 儲存圖片到資料夾
                if (fileMap.get("file" + i) != null) {
//					讀取檔眳
                    System.out.println(fileMap.get("file" + i).getOriginalFilename());
//					讀取副檔名
                    String lastname = fileMap.get("file" + i).getOriginalFilename()
                            .substring(fileMap.get("file" + i).getOriginalFilename().indexOf("."));
                    System.out.println(lastname);
                    // 獲取Tomcat伺服器所在的路徑
                    String tomcat_path = System.getProperty("user.dir");
                    System.out.println("Tomcat伺服器所在的路徑: " + tomcat_path);
                    // 獲取Tomcat伺服器所在路徑的最後一個檔案目錄
                    String bin_path = tomcat_path.substring(tomcat_path.lastIndexOf("\\") + 1, tomcat_path.length());
                    System.out.println("Tomcat伺服器所在路徑的最後一個檔案目錄: " + bin_path);
                    System.out.println("bin_path == " + bin_path);
                    String path2 = "C:/CRMfile/" + fileMap.get("file" + i).getOriginalFilename();

                    String path3 = "C:\\Users\\Rong\\Desktop\\tomcat-9.0.41\\webapps\\CRM\\WEB-INF\\classes\\static\\file\\"
                            + fileMap.get("file" + i).getOriginalFilename();
                    // 檔案輸出
                    System.out.println("檔案輸出到" + path2);
                    fileMap.get("file" + i).transferTo(new File(path2));
                    System.out.println("輸出成功");
                    // 檔案複製
                    String pic_path;
                    try {
                        // 判斷最後一個檔案目錄是否為bin目錄
                        if (("bin").equals(bin_path)) {
                            System.out.println("binbinbinbinbinbinbinbinbinbinbinbin");
                            // 獲取儲存上傳圖片的檔案路徑
                            pic_path = tomcat_path.substring(0, System.getProperty("user.dir").lastIndexOf("\\"))
                                    + "/webapps/CRM/WEB-INF/classes/static/file/";
                            // 列印路徑
                            System.out.println(pic_path + fileMap.get("file" + i).getOriginalFilename());
                            File source = new File(path3);
                            File dest = new File(pic_path + fileMap.get("file" + i).getOriginalFilename());
                            Files.copy(source.toPath(), dest.toPath());
                            System.out.println("複製成功");
                        } else {
                            File source = new File(path2);
                            File dest = new File(path3);
                            System.out.println(path2 + fileMap.get("file" + i).getOriginalFilename());
                            Files.copy(source.toPath(), dest.toPath());
                            System.out.println("複製成功");
                        }

                    } catch (Exception e) {
                        System.out.println("複製失敗");
                    }

//3. 儲存檔案名稱到資料庫
                    BillboardFileBean billBoardFileBean = new BillboardFileBean();
                    billBoardFileBean.setBillboardid(0);
                    billBoardFileBean.setAuthorize(authorizeId);
                    billBoardFileBean.setFileid(uuid);
//					billBoardFileBean.setUrl(uuid + lastname); // 使用uuid建檔名
                    billBoardFileBean.setUrl(fileMap.get("file" + i).getOriginalFilename());
                    billBoardFileBean.setName(fileMap.get("file" + i).getOriginalFilename());
                    ss.saveUrl(billBoardFileBean);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("儲存失敗");
            return "儲存失敗";
        }
        return "上傳成功";
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//要求附件
    @RequestMapping("/selectFile/{authorizeId}")
    @ResponseBody
    public List<BillboardFileBean> selectFile(@PathVariable("authorizeId") String authorizeId) {
        logger.info("要求附件  {}", authorizeId);
        return bfr.findByAuthorize(authorizeId);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除型錄
    @RequestMapping("/remove/{fileId}")
    @ResponseBody
    public String removefile(@PathVariable("fileId") String fileId) {

        BillboardFileBean billBoardFileBean = bfr.getById(fileId);
        File file = new File("E:\\JetecCRM\\src\\main\\resources\\static\\file\\" + billBoardFileBean.getUrl());
        System.out.println(file.delete());
        bfr.delete(billBoardFileBean);
        return "刪除成功";
//		ss.removefile(fileid);
//		return "redirect:/system/billboard/" + billboardid;
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//置頂設定
    @RequestMapping("/top/{billboardid}/{adminid}")
    @ResponseBody
    public String billboardid(@PathVariable("billboardid") Integer billboardid,
                              @PathVariable("adminid") Integer adminid, HttpSession session) {
        logger.info("置頂設定 {}", billboardid);
        String result = ss.setTop(billboardid, adminid);
        session.setAttribute("user", ar.getById(adminid));
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存公佈欄留言
    @RequestMapping("/saveReply/{fileuuid}")
    public String saveReply(@PathVariable("fileuuid") String fileuuid, BillboardReplyBean bean, HttpSession session) {
        System.out.println("*****儲存公佈欄留言*****");
        // 儲存留言
        BillboardReplyBean save = ss.SaveReply(bean);

        // 附件處理
        List<ReplyFileBean> list = rfr.findByAuthorize(fileuuid);
        for (ReplyFileBean b : list) {
            b.setReplyid(save.getReplyid());
            rfr.save(b);
        }

        BillboardBean bb = br.getById(bean.getBillboardid());// 取出公布欄的訊息
        AdminBean user = (AdminBean) session.getAttribute("user");// 登入者
        // 插入最後回覆時間時間
        Date date = new Date();
        bb.setReplytime(ZeroTools.getTime(date));
        AdminBean abean = ar.findByName(bb.getUser());// 取出發佈人
        // 寄Emai 給發佈人
        String mailTo = abean.getEmail();
        String Subject = bean.getName() + "回覆留言";
        String text = "主題 :" + bb.getTheme() + "<br>回覆 :" + bean.getContent();

        zTools.mail(mailTo, text, Subject, "");
        // 給發佈人 存mail
        if (!user.getName().equals(abean.getName()))
            ss.saveMail(abean.getAdminid(), bean.getBillboardid(), "新留言");
        // 給被@的人 存mail
        List<BillboardAdviceBean> adviceList = bb.getAdvice();
        for (BillboardAdviceBean advice : adviceList) {
            if (!user.getName().equals(advice.getFormname()))
                ss.saveMail(advice.getAdviceto(), bean.getBillboardid(), "新留言");
        }
        // 留言過的人 存mail
        List<BillboardReplyBean> replyList = bb.getReply();
        for (BillboardReplyBean reply : replyList) {
            if (!user.getName().equals(reply.getName()))
                ss.saveMail(ar.findByName(reply.getName()).getAdminid(), bean.getBillboardid(), "新留言");// 用名子去admin找人
            // 找到後取出Adminid
        }
        // 最後回覆時間
        br.save(bb);
        ReplyTimeBean replyTimeBean = new ReplyTimeBean();
        replyTimeBean.setBillboardid(bb.getBillboardid());
        replyTimeBean.setAaa("1");
        replyTimeBean.setLastmodified(new Date());
        rtr.save(replyTimeBean);
        return "redirect:/billboardReply/" + bean.getBillboardid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//修改留言
    @RequestMapping("/replyChange")
    public String replyChange(BillboardReplyBean bean) {
        logger.info("修改留言 {}", bean.getBillboardid());
        ss.SaveReply(bean);
        return "redirect:/billboardReply/" + bean.getBillboardid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除留言
    @RequestMapping("/replyRemove/{replyId}")
    public String replyRemove(@PathVariable("replyId") String replyId) {
        logger.info("刪除留言 {}", replyId);
        Integer Billboardid = ss.delReply(replyId);
        return "redirect:/billboardReply/" + Billboardid;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存留言的留言
    @RequestMapping("/saveReplyreply")
    public String saveReplyreply(ReplyreplyBean replyreplyBean, @RequestParam("billboardid") Integer billboardid) {
        System.out.println("*****儲存留言的留言*****");
        logger.info("儲存留言的留言");
        logger.info(replyreplyBean.toString());
        replyreplyBean.setLastmodified(new Date());
        ss.saveReplyreply(replyreplyBean);
        return "redirect:/billboardReply/" + billboardid;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除留言的留言
    @RequestMapping("/removeReplyreply/{ReplyreplyId}")
    @ResponseBody
    public String removeReplyreply(@PathVariable("ReplyreplyId") String ReplyreplyId) {
        logger.info("刪除留言的留言 {}", ReplyreplyId);
        return ss.removeReplyreply(ReplyreplyId);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取留言的@
    @RequestMapping("/replyAdvice/{ReplyId}")
    @ResponseBody
    public List<ReplyAdviceBbean> replyAdvice(@PathVariable("ReplyId") String ReplyId) {
        logger.info("讀取留言的@ {}", ReplyId);
        return ss.replyAdvice(ReplyId);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存留言的@
    @RequestMapping("/saveReplyAdvice/{ReplyId}")
    @ResponseBody
    public String saveReplyAdvice(@RequestParam("adviceto") Integer[] adviceto, @PathVariable("ReplyId") String ReplyId,
                                  @RequestParam("billboardid") Integer billboardid) {
        logger.info("儲存留言的@ billboardid:{}",billboardid);
        // 準備ReplyAdvice
        ReplyAdviceBbean raBean = new ReplyAdviceBbean();
        raBean.setReplyid(ReplyId);
        // 寄信準備
        BillboardBean billboardBean = br.getById(billboardid);
        BillboardReplyBean replyBean = brr.getById(ReplyId);
        String mailTo = ar.findByName(replyBean.getName()).getEmail();
        String Subject = billboardBean.getTheme() + "有回復被標記";
        String text = replyBean.getContent();
        StringBuilder maillist = new StringBuilder();
        // 沒人刪除ReplyAdvice
        if (adviceto.length == 1 & adviceto[0] == 0) {
            return ss.delReplyAdviceByReplyid(ReplyId);// 返回刪除結果
        } else {// 有人
            // 刪除舊資料
            ss.delReplyAdviceByReplyid(ReplyId);
            // 插入新資料
            for (Integer a : adviceto) {
                if (a != 0) {
                    // 儲存ReplyAdvice
                    raBean.setReplyadvice(ZeroTools.getUUID());
                    raBean.setAdviceto(a);
                    ss.saveReplyAdvice(raBean);
                    // 儲存maill
                    ss.saveMail(a, billboardid, "有回復被標記");
                    // 寄信
                    AdminBean adminBean = ar.getById(a);
                    maillist.append(adminBean.getEmail());
                    maillist.append(",");
                }
            }
            maillist.append("jeter.tony56@gmail.com");
            zTools.mail(mailTo, text, Subject, maillist.toString());
        }
        return "@成功";

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 忘記密碼
    @RequestMapping("/forget")
    public String forget(AdminBean bean, Model model) {
        logger.info("忘記密碼 {}", bean.getEmail());
        String uuid = ZeroTools.getUUID();
        Map<String, String> errors = new HashMap<>();
        model.addAttribute("errors", errors);
        model.addAttribute("email", bean.getEmail());

// 郵件格式判斷
        if (bean.getEmail() == null || bean.getEmail().length() == 0) {
            errors.put("email", "Email錯誤");
        }
        if (!bean.getEmail().contains("@"))
            errors.put("email", "Email錯誤");

        if (!ar.existsByEmail(bean.getEmail())) {
            errors.put("email", "查不到這個Email");
        }
        if (errors != null && !errors.isEmpty())
            return "/forget";

        // 儲存認證碼?
        ss.saveAuthorize(uuid, bean.getEmail());

// 寄發郵件
        String text = "<p><a href='http://192.168.11.100:8080/CRM/system/reset.jsp?id=" + uuid + "'>從新設定密碼</a></p>";
//bean.setEmail("jeter.tony56@gmail.com");
        String Subject = "從新設定密碼";// 主題
        String maillist = "";
        zTools.mail(bean.getEmail(), text, Subject, maillist);
        return "redirect:/system/forgetSend.jsp";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//密碼修改
    @RequestMapping("/resetPassword/{ForgetAuthorizeId}")
    public String resetPassword(@PathVariable("ForgetAuthorizeId") String ForgetAuthorizeId,
                                @RequestParam("password") String password, Model model) {
        logger.info("密碼修改");
        ForgetAuthorizeBean forgetAuthorizeBean = ss.getForgetAuthorize(ForgetAuthorizeId);
        if (forgetAuthorizeBean == null) {
            model.addAttribute("error", "驗證碼錯誤");
            return "/system/resetPasswordError";
        } else {
            System.out.println(forgetAuthorizeBean);
            AdminBean adminBean = ar.findByEmail(forgetAuthorizeBean.getEmail());
            try {
                adminBean.setPassword(password);
                ar.save(adminBean);

            } catch (Exception e) {
                model.addAttribute("error", "找不到Email");
                return "/system/resetPasswordError";
            }
        }
        return "redirect:/system/resetPasswordOK.jsp";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//取得工作項目
    @RequestMapping("/workitem/{adminname}")
    @ResponseBody
    public List<WorkBean> workitem(@PathVariable("adminname") String adminname) {return ws.workitem(adminname); }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//取得銷售機會
    @RequestMapping("/marketitem/{adminname}")
    @ResponseBody
    public List<MarketBean> marketitem(@PathVariable("adminname") String adminname) {return ws.marketitem(adminname);}

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//取得銷售機會
    @RequestMapping("/PotentialItem/{adminname}")
    @ResponseBody
    public List<PotentialCustomerBean> PotentialItem(@PathVariable("adminname") String adminname) {return ws.PotentialItem(adminname); }

//紀錄修改
    @RequestMapping("/changeMessage/{id}")
    @ResponseBody
    public boolean changeMessage(@RequestBody Map<String, Object> map, @PathVariable("id") String id, HttpSession session) {
        logger.info("紀錄修改 {}",map);
        Set<String> set = map.keySet();
        Iterator<String> it = set.iterator();
        ChangeMessageBean cmbean = new ChangeMessageBean();
        if (map == null || map.isEmpty()) return false;
        AdminBean aBean = (AdminBean) session.getAttribute("user");
        while (it.hasNext()) {
            cmbean.setChangemessageid(ZeroTools.getUUID());
            cmbean.setCreatetime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            cmbean.setChangeid(id);
            cmbean.setAfter("");
            cmbean.setSource("");
            cmbean.setName(aBean.getName());
            String key = it.next();
            cmbean.setFiled(key);
            System.out.printf("key:%s,value:%s\n", key, map.get(key));
            List<Object> list = (List<Object>) map.get(key);

            if (list.get(1) == null) {//如果 來源為空 不儲存
            } else {
                if (list.get(0) == null) {//目的地為空
                    cmbean.setAfter("");
                } else {
                    cmbean.setAfter(list.get(0).toString());
                }
                cmbean.setSource(list.get(1).toString());
                ss.saveChangeMesssage(cmbean);
            }
        }
        return true;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//取得未讀(資料更新)
    @RequestMapping("/getNews")
    @ResponseBody
    public String getNews(Authentication authentication, HttpSession session) {
        System.out.println("取得未讀(資料更新)");
        AdminBean adminBean = (AdminBean) session.getAttribute("user");

        if (adminBean == null) {
            UserAuthorize(authentication, session);
            adminBean = (AdminBean) session.getAttribute("user");
        }
        String result;
        try {
            result = String.valueOf(adminBean.getMail().size());
        } catch (Exception e) {
            System.out.println("沒有登入");
            result = "沒有登入";
        }
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //儲存主管留言
    @ResponseBody
    @RequestMapping("/SaveMessage")
    public List<BosMessageBean> SaveMessage(@RequestBody Map<String, String> body) {
        logger.info("儲存主管留言  {}",body);

        BosMessageBean bmBean = new BosMessageBean(ZeroTools.getUUID(), body.get("bosmessage"), body.get("admin"), body.get("message"), ZeroTools.getTime(new Date()));
        ds.save(bmBean);
        System.out.println(ds.getBosMessageList(body.get("bosmessage")));
        return ds.getBosMessageList(body.get("bosmessage"));
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //讀取主管留言
    @ResponseBody
    @RequestMapping("/getMessage/{customerid}")
    public List<BosMessageBean> getMessage(@PathVariable("customerid") String customerid) {
        System.out.println("*****讀取主管留言*****");
        System.out.println(ds.getBosMessageList(customerid));
        return ds.getBosMessageList(customerid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //刪除主管留言
    @ResponseBody
    @RequestMapping("/reomveBosMessage/{bosmessageid}")
    public List<BosMessageBean> reomveBosMessage(@PathVariable("bosmessageid") String bosmessageid) {
        System.out.println("*****刪除主管留言*****");
        return ds.delBosMessageList(bosmessageid);
    }
}
