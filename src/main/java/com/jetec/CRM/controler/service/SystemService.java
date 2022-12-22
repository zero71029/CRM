package com.jetec.CRM.controler.service;

import java.io.File;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.jetec.CRM.model.*;
import com.jetec.CRM.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jetec.CRM.Tool.ZeroTools;

@Service
@Transactional
public class SystemService {

    @Autowired
    ChangeMessageRepository cmr;
    @Autowired
    AdminRepository ar;
    // mail顯示未讀用
    @Autowired
    AdminMailRepository amr;
    @Autowired
    LibraryRepository lr;
    @Autowired
    LibraryChangeRepository lcr;

    @Autowired
    BillboardRepository br;
    @Autowired
    BillboardReadRepository brr;
    @Autowired
    BillboardReplyRepository billboardReplyRepository;
    @Autowired
    BillboardGroupRepository bgr;
    @Autowired
    BillboardFileRepository bfr;
    // 被標註
    @Autowired
    BillboardAdviceRepository bar;
    @Autowired
    BillboardTopRepository btr;
    //	留言的留言
    @Autowired
    ReplyreplyRepository rrr;
    @Autowired
    ReplyAdviceRepository rar;
    @Autowired
    ReplyFileRepository rfr;
    @Autowired
    ForgetAuthorizeRepository far;

    @Autowired
    AdminPermitRepository apr;


    @Autowired
    ZeroTools zTools;

    /////////////////////////////////////////////////////////////////////////////////////
    // 讀取員工列表
    public List<AdminBean> getAdminList(String so) {
        if (so.equals("adminid"))
            return ar.getAll();
        if (so.equals("XXX"))
            return ar.findByState("離職");

        return ar.findAll();
    }

    /////////////////////////////////////////////////////////////////////////////////////
    // 讀取員工列表by職位
    public List<AdminBean> getAdminByDepartment(String position) {

        return ar.getByDepartment(position);
    }

    /////////////////////////////////////////////////////////////////////////////////////
    // 讀取員工細節
    public AdminBean getById(Integer id) {
        return ar.getById(id);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存員工
    public String SaveAdmin(AdminBean abean) {
        System.out.println(abean);

        if (ar.existsByEmail(abean.getEmail()) & abean.getAdminid() == null)
            return "失敗,Email 已被使用";
        ar.save(abean);
        return "儲存成功,<a href='/CRM/time.jsp'>請重新登入</a>";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除員工
    public void delAdmin(List<Integer> id, HttpServletRequest sce) {
        for (Integer i : id) {
            ar.deleteById(i);
        }
        ServletContext app = sce.getServletContext();
        app.setAttribute("admin", ar.findByStateOrState("在職", "新"));
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取公佈欄列表
    public List<BillboardBean> getBillboardList(String state, AdminBean adminBean, Integer pag, Sort sort) {
//		Sort sort = Sort.by(Direction.DESC, "lastmodified");
//		分頁
//		Page<BillboardBean> page = br.findAll( PageRequest.of(pag, 12, sort));
//		page.getSize();每頁條數
//		page.getNumber();當前頁
//		page.getNumberOfElements();本頁條數
//		page.getTotalElements();全部幾筆
//		page.getTotalPages();全部有幾頁		
//		List<BillboardBean> result = page.getContent();

        Pageable p = PageRequest.of(pag, 40, sort);
        // 結果容器
        List<BillboardBean> resulet = new ArrayList<>();
        // 把系統置頂抓出來
        List<BillboardBean> billboardBeanList = br.findByStateAndTop(state, "置頂", p);
        resulet.addAll(billboardBeanList);
        boolean boo = true;
        if (adminBean != null && pag == 0) {// 如果有登入
            for (BillboardTopBean btb : adminBean.getTop()) {// 讀取個人追蹤 追蹤迴圈
                for (BillboardBean bean : billboardBeanList) {// 列表迴圈
                    if (Objects.equals(bean.getBillboardid(), btb.getBillboardid())) {// 如果追蹤id == 列表id
                        boo = false;
                        break;
                    }
                }
                if (boo)
                    resulet.add(br.getById(btb.getBillboardid()));
                boo = true;
            }
        }

        // 沒有系統置頂
        List<BillboardBean> list = br.findByStateAndTop(state, "", p);
        for (BillboardBean b : list) {
            for (BillboardBean bean : resulet) {// 找出已徑加入的
                if (Objects.equals(bean.getBillboardid(), b.getBillboardid())) {// 過濾已徑加入的
                    boo = false;
                    break;
                }
            }
            if (adminBean != null) {// 如果有登入
                for (BillboardTopBean btb : adminBean.getTop()) {// 找出個人追蹤
                    if (Objects.equals(btb.getBillboardid(), b.getBillboardid())) {// 過濾各人追蹤
                        boo = false;
                        break;
                    }
                }
            }
            if (boo)
                resulet.add(b);
            boo = true;
        }

        return resulet;
    }
    // 讀取公佈欄列表 依分類

    public List<BillboardBean> getBillboardList(String state, String billboardgroupid) {
        List<BillboardBean> resulet = new ArrayList<>();
        Sort sort = Sort.by(Direction.DESC, "billboardid");
        // 如果是 一般公告的全部
        if ("01dasgregrehvbcv一般公告".equals(billboardgroupid)) {
            List<BillboardBean> list = br.getByStateAndBilltowngroupAndTop(state, "一般公告", "置頂", sort);
            resulet.addAll(list);
            list = br.getByStateAndBilltowngroupAndTop(state, "一般公告", "", sort);
            resulet.addAll(list);
            return resulet;
        } else if ("01dasgregrehvbcvaaa研發".equals(billboardgroupid)) {
            List<BillboardBean> list = br.getByStateAndBilltowngroupAndTop(state, "研發", "置頂", sort);
            resulet.addAll(list);
            list = br.getByStateAndBilltowngroupAndTop(state, "研發", "", sort);
            resulet.addAll(list);
            return resulet;
        } else if ("01dasgregrehvbcvbbb業務".equals(billboardgroupid)) {
            List<BillboardBean> list = br.getByStateAndBilltowngroupAndTop(state, "業務", "置頂", sort);
            resulet.addAll(list);
            list = br.getByStateAndBilltowngroupAndTop(state, "業務", "", sort);
            resulet.addAll(list);
            return resulet;
        } else if ("01dasgregrehvbcvccc行銷".equals(billboardgroupid)) {
            List<BillboardBean> list = br.getByStateAndBilltowngroupAndTop(state, "行銷", "置頂", sort);
            resulet.addAll(list);
            list = br.getByStateAndBilltowngroupAndTop(state, "行銷", "", sort);
            resulet.addAll(list);
            return resulet;
        } else if ("01dasgregrehvbcvddd生產".equals(billboardgroupid)) {
            List<BillboardBean> list = br.getByStateAndBilltowngroupAndTop(state, "生產", "置頂", sort);
            resulet.addAll(list);
            list = br.getByStateAndBilltowngroupAndTop(state, "生產", "", sort);
            resulet.addAll(list);
            return resulet;
        } else if ("01dasgregrehvbcvfggg採購".equals(billboardgroupid)) {
            List<BillboardBean> list = br.getByStateAndBilltowngroupAndTop(state, "採購", "置頂", sort);
            resulet.addAll(list);
            list = br.getByStateAndBilltowngroupAndTop(state, "採購", "", sort);
            resulet.addAll(list);
            return resulet;
        } else if ("01dasgregrehvbcvaaa財務".equals(billboardgroupid)) {
            List<BillboardBean> list = br.getByStateAndBilltowngroupAndTop(state, "財務", "置頂", sort);
            resulet.addAll(list);
            list = br.getByStateAndBilltowngroupAndTop(state, "財務", "", sort);
            resulet.addAll(list);
            return resulet;
        } else {// 不是的話 根據billboardgroupid尋找
            List<BillboardBean> list = br.getByStateAndBillboardgroupidAndTop(state, billboardgroupid, "置頂", sort);
            resulet.addAll(list);
            list = br.getByStateAndBillboardgroupidAndTop(state, billboardgroupid, "", sort);
            resulet.addAll(list);
            return resulet;

        }

//		return resulet;

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存公佈欄
    public BillboardBean SaveBillboard(BillboardBean bean, HttpSession session) {
        AdminMailBean adminMailBean = new AdminMailBean();
        // 插入換行
//		String content = bean.getContent();
//		bean.setContent(content.replaceAll("\\n", "<br>"));
        // 插入群組id
        BillboardGroupBean bgb = bgr.findByBillboardgroupAndBillboardoption(bean.getBilltowngroup(),
                bean.getBillboardgroupid());
        bean.setBillboardgroupid(bgb.getBillboardgroupid());

        // 儲存
        bean.setLastmodified(new Date());
        BillboardBean save = br.save(bean);
        // 如果封存 mail未讀全刪
        if (save.getState().equals("封存")) {
            amr.deleteAllByBillboardid(save.getBillboardid());
            return save;
        }
        //// 未讀處理
        adminMailBean.setBillboardid(save.getBillboardid());
        // 郵件
        AdminBean adminBean = (AdminBean) session.getAttribute("user");
//		String mailTo = adminBean.getEmail();
//		String Subject = bean.getTheme();
//		String text = bean.getContent();
        StringBuilder maillist = new StringBuilder();
        // 抓出所有人
        for (AdminBean a : ar.findAll()) {
            // 抓出所有人群發郵件
            maillist.append(a.getEmail());
            maillist.append(",");
            // 抓出所有人插入maill
            // 如果maill沒資料 //如果不是發布者
            if (!amr.existsByBillboardidAndAdminid(save.getBillboardid(), a.getAdminid())
                    && !Objects.equals(a.getAdminid(), adminBean.getAdminid())) {
                adminMailBean.setAdminmail(ZeroTools.getUUID());// maill插入uuid
                System.out.println("插入maill Name" + a.getName());
                adminMailBean.setAdminid(a.getAdminid());// maill插入 人id
                amr.save(adminMailBean);// 儲存maill
            }
        }
        maillist.append("jeter.tony56@gmail.com");
//		zTools.mail(mailTo, text, Subject, maillist.toString());

        return save;

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取公佈欄細節 公佈欄用
    public BillboardBean getBillboardById(Integer id, AdminBean adminBean) {

        if (adminBean != null) {// 如果有登入
            // 如果mail有資料 如果advice沒資料
            if (amr.existsByBillboardidAndAdminid(id, adminBean.getAdminid())
                    && !bar.existsByAdvicetoAndBillboardid(adminBean.getAdminid(), id)) {
                amr.deleteByBillboardidAndAdminid(id, adminBean.getAdminid());// 如果有登入就已讀
            }
        }
        //		bean.setContent(bean.getContent().replaceAll("<br>", "\n"));
        return br.getById(id);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取公佈欄細節 後台用
    public BillboardBean getBillboard(Integer id) {
        return br.getById(id);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除公佈欄
    public void delBillboard(List<Integer> id) {
        for (Integer i : id) {
            if (amr.existsByBillboardid(i))
                amr.deleteAllByBillboardid(i);
            btr.deleteAllByBillboardid(i);
            br.deleteById(i);
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//點擊已讀
    public String saveRead(Integer billboardid, Integer adminid) {
        // 如果mail有資料 刪除mail 插入read
        if (amr.existsByBillboardidAndAdminid(billboardid, adminid)) {
            amr.deleteByBillboardidAndAdminid(billboardid, adminid);
            AdminBean adminBean = ar.getById(adminid);
            if (brr.existsByBillboardidAndName(billboardid, adminBean.getName())) {
                brr.deleteByBillboardidAndName(billboardid, adminBean.getName());
            }
            BillboardReadBean brb = new BillboardReadBean();
            brb.setBillboardid(billboardid);
            brb.setReadid(ZeroTools.getUUID());
            brb.setName(adminBean.getName());
            brr.save(brb);
            // @ 如果存在 就取出 插入reply=1
            if (bar.existsByAdvicetoAndBillboardid(adminid, billboardid)) {
                BillboardAdviceBean bab = bar.getByAdvicetoAndBillboardid(adminid, billboardid);
                bab.setReply("0");
                bar.save(bab);
            }
            return "成功已讀  “請刷新頁面“  ";
        } else {
            return "找不到資料";
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//取消已讀
    public void ReRead(Integer billboardid, Integer adminid) {
        // 刪除read 插入mail
        if (!amr.existsByBillboardidAndAdminid(billboardid, adminid)) {
            AdminMailBean aBean = new AdminMailBean();
            aBean.setAdminid(adminid);
            aBean.setBillboardid(billboardid);
            aBean.setAdminmail(ZeroTools.getUUID());
            amr.save(aBean);
            AdminBean adminBean = ar.getById(adminid);
            if (brr.existsByBillboardidAndName(billboardid, adminBean.getName())) {
                brr.deleteByBillboardidAndName(billboardid, adminBean.getName());
            }
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存公佈欄留言
    public BillboardReplyBean SaveReply(BillboardReplyBean bean) {
        if (bean.getReplyid() == null || bean.getReplyid().length() == 0) {
            bean.setReplyid(ZeroTools.getUUID());
        }

        // 插入換行
//        String content = bean.getContent();
//        bean.setContent(content.replaceAll("\\n", "<br>"));
        bean.setLastmodified(new Date());
        return billboardReplyRepository.save(bean);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//新增群組子項
    public String saveOption(String group, String option) {
        if (bgr.existsByBillboardgroupAndBillboardoption(group, option)) {
            return "改項目存在";
        } else {
            BillboardGroupBean bean = new BillboardGroupBean();
            bean.setBillboardgroup(group);
            bean.setBillboardoption(option);
            bean.setBillboardgroupid(ZeroTools.getUUID());
            bgr.save(bean);
            return group + " " + option + "" + "新增成功";
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除群組子項
    public String delOption(String group, String option) {
        if (bgr.existsByBillboardgroupAndBillboardoption(group, option)) {
            BillboardGroupBean bgBean = bgr.findByBillboardgroupAndBillboardoption(group, option);
            if (br.existsByBillboardgroupid(bgBean.getBillboardgroupid())) {
                return "該項目還有留言  不能刪除";
            }
            bgr.delete(bgBean);
            return "刪除成功";
        } else {
            return "找不到項目,請聯絡資訊人員";
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//更新群組
    public void updataOption(HttpServletRequest sce) {
        ServletContext app = sce.getServletContext();
        app.setAttribute("billboardgroup", bgr.findAll());
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 3. 儲存檔案名稱到資料庫
    public void saveUrl(BillboardFileBean billBoardFileBean) {
        bfr.save(billBoardFileBean);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除型錄
    public void removefile(String fileid) {
        BillboardFileBean billBoardFileBean = bfr.getById(fileid);
        File file = new File("E:/CRMfile/" + billBoardFileBean.getUrl());
        System.out.println("刪除檔案" + file.delete());
        file = new File("E:/CRMfile/" + billBoardFileBean.getName());
        System.out.println("刪除檔案" + file.delete());
        // 獲取Tomcat伺服器所在的路徑
        String tomcat_path = System.getProperty("user.dir");
        System.out.println("Tomcat伺服器所在的路徑: " + tomcat_path);
        // 獲取Tomcat伺服器所在路徑的最後一個檔案目錄
        String bin_path = tomcat_path.substring(tomcat_path.lastIndexOf("\\") + 1, tomcat_path.length());
        System.out.println("Tomcat伺服器所在路徑的最後一個檔案目錄: " + bin_path);
        // 判斷最後一個檔案目錄是否為bin目錄
        if (("bin").equals(bin_path)) {
            // 獲取儲存上傳圖片的檔案路徑
            String pic_path = tomcat_path.substring(0, System.getProperty("user.dir").lastIndexOf("\\"))
                    + "/webapps/CRM" + "/file/";
            file = new File(pic_path + billBoardFileBean.getUrl());
            System.out.println(file.delete());
            file = new File(pic_path + billBoardFileBean.getName());
            System.out.println(file.delete());
        }
        bfr.delete(billBoardFileBean);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索公布欄
    public List<BillboardBean> selectBillboardt(String search) {
        boolean boo = true;
        // 搜索主題
        Sort sort = Sort.by(Direction.DESC, "lastmodified");
        List<BillboardBean> result = new ArrayList<>(br.findByThemeLikeIgnoreCaseAndState("%" + search + "%", "公開", sort));
        // 用發表人搜索
        for (BillboardBean p : br.findByUserLikeIgnoreCaseAndState("%" + search + "%", "公開", sort)) {
            for (BillboardBean bean : result) {
                if (Objects.equals(bean.getBillboardgroupid(), p.getBillboardgroupid())) {
                    boo = false;
                    break;
                }
            }
            if (boo){
                result.add(p);
            }
        }
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取留言ORDER BY時間
    public List<BillboardBean> getBillboardByTime() {
        return br.getBillboardByTime();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除留言
    public Integer delReply(String replyId) {
        BillboardReplyBean bean = billboardReplyRepository.getById(replyId);
        if (bean != null) {
            billboardReplyRepository.delete(bean);
            rrr.deleteByReplyid(replyId);
        }
        return bean.getBillboardid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//@他人
    public void saveAdvice(Integer[] adviceto, Integer adminid, Integer billboardid) {
        BillboardAdviceBean bab = new BillboardAdviceBean();
        AdminMailBean adminMailBean = new AdminMailBean();
        // 準備mail資料
        StringBuilder maillist = new StringBuilder();
        BillboardBean billboardBean = br.getById(billboardid);
        AdminBean bos = ar.getById(adminid);
        String mailTo = bos.getEmail();
        String Subject = billboardBean.getTheme() + "標記你了";
        String text = billboardBean.getContent();
        adminMailBean.setBillboardid(billboardid);
        //
        bab.setBillboardid(billboardid);
        bab.setAdvicefrom(adminid);
        bab.setReply("1");
        // 刪除舊資料
        bar.deleteAllByBillboardid(billboardid);
        for (Integer a : adviceto) {
            if (a != 0) {
                // 插入Advice
                AdminBean adminBean = ar.getById(a);
                bab.setAdviceto(a);
                bab.setAdviceid(ZeroTools.getUUID());
                bab.setFormname(adminBean.getName());
                //排除自己
                if (!a.equals(adminid)) {
                    bar.save(bab);
                }
                // 抓出所有人群發郵件
                maillist.append(adminBean.getEmail());
                maillist.append(",");
                // 抓出所有人插入maill
                // 如果maill沒資料 就儲存
                if (!amr.existsByBillboardidAndAdminid(billboardid, a)) {
                    adminMailBean.setAdminmail(ZeroTools.getUUID());
                    adminMailBean.setAdminid(a);
                    //排除自己
                    if (!a.equals(adminid)) {
                        amr.save(adminMailBean);
                    }
                }
            }
        }
        maillist.append("jeter.tony56@gmail.com");
        zTools.mail(mailTo, text, Subject, maillist.toString());
    }

    public void saveAdvice(Integer adminid, Integer billboardid) {
        bar.deleteAllByBillboardid(billboardid);
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//置頂設定
    public String setTop(Integer billboardid, Integer adminid) {
        if (btr.existsByBillboardidAndAdminid(billboardid, adminid)) {
            btr.deleteAllByBillboardidAndAdminid(billboardid, adminid);
            return "取消成功";
        } else {
            BillboardTopBean btb = new BillboardTopBean();
            btb.setAdminid(adminid);
            btb.setBillboardid(billboardid);
            btb.setTopid(ZeroTools.getUUID());
            btr.save(btb);
            return "追蹤成功";
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取回覆
    public List<BillboardReplyBean> getBillboardReply(Integer Billboardid) {
        Sort sort = Sort.by(Direction.DESC, "lastmodified");
        return billboardReplyRepository.getByBillboardid(Billboardid, sort);
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存留言
    public void saveMail(Integer adminid, Integer billboardid, String reply) {
        // 如果 mail 沒資料 就存儲
        if (!amr.existsByBillboardidAndAdminid(billboardid, adminid)) {
            AdminMailBean adminMailBean = new AdminMailBean();
            adminMailBean.setAdminmail(ZeroTools.getUUID());
            adminMailBean.setAdminid(adminid);
            adminMailBean.setBillboardid(billboardid);
            adminMailBean.setReply(reply);
            amr.save(adminMailBean);
        }

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存留言的留言
    public void saveReplyreply(ReplyreplyBean replyreplyBean) {
        replyreplyBean.setId(ZeroTools.getUUID());
        rrr.save(replyreplyBean);
        BillboardReplyBean bean = billboardReplyRepository.getById(replyreplyBean.getReplyid());// 找到留言bean
        AdminBean adminBean = ar.findByName(bean.getName());// 找到留研發布人Bean
        if (!adminBean.getName().equals(replyreplyBean.getName())) { // 如果留研發布人 不等於 評論人
            AdminMailBean adminMailBean = new AdminMailBean();
            adminMailBean.setAdminmail(ZeroTools.getUUID());
            adminMailBean.setAdminid(adminBean.getAdminid());
            adminMailBean.setBillboardid(bean.getBillboardid());
            adminMailBean.setReply("新回覆");
            amr.save(adminMailBean);
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除留言的留言
    public String removeReplyreply(String replyreplyId) {
        rrr.deleteById(replyreplyId);
        return "刪除成功";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取留言的@
    public List<ReplyAdviceBbean> replyAdvice(String replyId) {
        return rar.findByReplyid(replyId);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存留言的@
    public String saveReplyAdvice(ReplyAdviceBbean raBean) {
        rar.save(raBean);
        return null;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除留言的@
    public String delReplyAdviceByReplyid(String replyId) {
        rar.deleteAllByReplyid(replyId);
        return "全部刪除";

    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除檔案
    public void delBbillboardFfile() {
//		List<BillboardFileBean> fileList = bfr.findByBillboardid(0);
        bfr.deleteAllByBillboardid(0);
        rfr.deleteAllByReplyid("0");

    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
//登入驗證
    public void auth(Authentication authentication, HttpSession session) {
        System.out.println("********************");
        System.out.println("********登入驗證***********");
        AdminBean adminBean = (AdminBean) session.getAttribute("user");
        if (adminBean == null) {
            if (ar.existsByEmail(authentication.getName())){
                AdminBean admin = ar.findByEmail(authentication.getName());

                session.setAttribute("user", zTools.getPermit(admin));
            }

        }

    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //儲存 忘記密碼 認證碼?
    public void saveAuthorize(String uuid, String email) {
        ForgetAuthorizeBean faBean = new ForgetAuthorizeBean();
        faBean.setEmail(email);
        faBean.setId(uuid);
        far.save(faBean);

    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
//取得密碼驗證
    public ForgetAuthorizeBean getForgetAuthorize(String forgetAuthorizeId) {
        ForgetAuthorizeBean forgetAuthorizeBean = far.getById(forgetAuthorizeId);
        try {
            System.out.println(forgetAuthorizeBean);
            return far.getById(forgetAuthorizeId);


        } catch (Exception e) {
            return null;
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存修改
    public void saveChangeMesssage(ChangeMessageBean cmbean) {
        cmr.save(cmbean);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取圖書館
    public List<LibraryBean> getlibrary(String librarygroup) {
        Sort sort = Sort.by(Direction.DESC, "libraryoption");
        return lr.findByLibrarygroup(librarygroup, sort);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//新增圖書館子項
    public void addLibrary(String librarygroup, String libraryoption, String name) {
        String remark;
        switch (librarygroup) {
            case "position":
                remark = "員工管理 - 職位";
                break;
            case "department":
                remark = "員工管理 - 部門";
                break;
            case "producttype":
                remark = "銷售機會 - 產品類別";
                break;
            case "MarketType":
                remark = "銷售機會 - 產業";
                break;
            case "MarketSource":
                remark = "銷售機會 - 來源";
                break;
            case "MarketCreateTime":
                remark = "銷售機會 - 案件類型";
                break;
            default:
                remark = "錯誤";
        }
        if (!lr.existsByLibrarygroupAndLibraryoption(librarygroup, libraryoption)) {
            LibraryBean bean = new LibraryBean(ZeroTools.getUUID(), librarygroup, libraryoption, remark);
            lr.save(bean);
            LibraryChangeBean lcBeam = new LibraryChangeBean(ZeroTools.getUUID(), librarygroup, libraryoption, "新增", ZeroTools.getTime(new Date()));
            lcBeam.setAdmin(name);
            lcr.save(lcBeam);
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 刪除圖書館子項
    public String delLibrary(String libaryid, String name) {
        Optional<LibraryBean> op = lr.findById(libaryid);
        String librarygroup = null;
        if (op.isPresent()) {
            librarygroup = op.get().getLibrarygroup();
            LibraryChangeBean lcBeam = new LibraryChangeBean(ZeroTools.getUUID(), op.get().getLibrarygroup(), op.get().getLibraryoption(), "刪除", ZeroTools.getTime(new Date()));
            lcBeam.setAdmin(name);
            lcr.save(lcBeam);
            lr.delete(op.get());
        }
        return librarygroup;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 查詢圖書館紀錄
    public List<LibraryChangeBean> SetectLibraryRecord(String librarygroup) {
        Sort sort = Sort.by(Direction.DESC, "aaa");
        Optional<List<LibraryChangeBean>> op = lcr.findByLibrarygroup(librarygroup, sort);
        return op.orElse(null);
    }
}
