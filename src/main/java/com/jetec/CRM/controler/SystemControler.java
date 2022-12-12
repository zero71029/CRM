package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.SystemService;
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
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/system")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')OR hasAuthority('謝姍妤')")
public class SystemControler {

    @Autowired
    SystemService ss;
    @Autowired
    AdminRepository ar;
    @Autowired
    BillboardRepository br;
    @Autowired
    AuthorizeRepository authorizeRepository;
    @Autowired
    BillboardFileRepository bfr;
    @Autowired
    ZeroTools zTools;


    @Autowired
    LibraryRepository lr;
    Logger logger = LoggerFactory.getLogger("SystemControler");

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取員工列表
    @RequestMapping("/adminList/{so}")
    public String adminList(Model model, @PathVariable("so") String so) {
        logger.info("進入員工列表");
        model.addAttribute("list", ss.getAdminList(so));
        return "/system/adminList";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @SuppressWarnings("unchecked")
    // 員工列表排序
    @RequestMapping("/adminList/{so}/{name}")
    public String adminListSort(Model model, @PathVariable("so") String so, @PathVariable("name") String name,
                                HttpServletRequest sce) {
        logger.info("員工列表排序");
        ServletContext app = sce.getServletContext();
        List<LibraryBean> list = (List<LibraryBean>) app.getAttribute("library");//拿列表
        List<String> department = new ArrayList<>();//部門列表
        List<String> nnn = new ArrayList<>();
        if (so.equals("department")) {
            for (LibraryBean library : list) {//把要排的單獨拿出來
                if (library.getLibrarygroup().equals("department"))
                    department.add(library.getLibraryoption());
            }
            boolean index = false;
            for (String a : department) {//如果列表 = 輸入的 先加
                if (index) {
                    nnn.add(a);
                }
                if (a.equals(name)) {
                    index = true;
                }
            }
            for (String a : department) { //如果列表 !=輸入的 後加
                if (a.equals(name)) {
                    index = false;
                }
                if (index) {
                    nnn.add(a);
                }
            }
        }
        // 如果是依照position排序
        if (so.equals("position")) {
            // 從library 抓取position列表
            for (LibraryBean library : list) {
                if (library.getLibrarygroup().equals("position"))
                    department.add(library.getLibraryoption());
            }
            // 從輸入開始抓取
            boolean index = false;
            for (String a : department) {
                if (index) {
                    nnn.add(a);
                }
                if (a.equals(name)) {
                    index = true;
                }
            }
            // 填充前面資料
            for (String a : department) {
                if (a.equals(name)) {
                    index = false;
                }
                if (index) {
                    nnn.add(a);
                }
            }
        }

        nnn.add(name);
        System.out.println(nnn);
        List<AdminBean> Billboard = new ArrayList<>();
        List<AdminBean> dList;
        for (String d : nnn) {///再根據列表去脂料庫拿取
            if (so.equals("department")) {
                dList = ar.getByDepartment(d);
            } else {
                dList = ar.getByPosition(d);
            }
            Billboard.addAll(dList);
        }
        model.addAttribute("list", Billboard);
        return "/system/adminList";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取員工細節
    @RequestMapping("/adminDetail/{id}")
    public String adminDetail(Model model, @PathVariable("id") Integer id) {
        logger.info("進入員工細節 {}", id);
        model.addAttribute("bean", ss.getById(id));
        return "/system/admin";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除員工
    @RequestMapping("/delAdmin")
    @ResponseBody
    public String delAdmin(@RequestParam("id") List<Integer> id, HttpServletRequest sce) {
        logger.info("刪除員工 {}", id);
        ss.delAdmin(id, sce);
        return "刪除成功";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取公佈欄列表
    @RequestMapping("/billboardList")
    public String billboardList(Model model, HttpSession session, @RequestParam("pag") Integer pag) {
        AdminBean adminBean = (AdminBean) session.getAttribute("user");
        logger.info("{} 進入公佈欄列表", adminBean.getName());
        if (pag < 1)
            pag = 1;
        pag--;
        // 分頁 全部有幾頁
        Pageable p = PageRequest.of(pag, 30, Direction.DESC, "lastmodified");
        Page<BillboardBean> page = br.getByStateAndTop("公開", "", p);
        model.addAttribute("TotalPages", page.getTotalPages());
        // 公佈欄列表
        Sort sort = Sort.by(Direction.DESC, "lastmodified");
        model.addAttribute("list", ss.getBillboardList("公開", adminBean, pag, sort));
        return "/system/billboardList";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取公佈欄列表 封存
    @RequestMapping("/OffShelf")
    public String OffShelf(Model model, HttpSession session) {
        AdminBean adminBean = (AdminBean) session.getAttribute("user");
        logger.info("{} 進入公佈欄列表 封存", adminBean.getName());
        Sort sort = Sort.by(Direction.DESC, "lastmodified");
        model.addAttribute("list", ss.getBillboardList("封存", adminBean, 0, sort));
        return "/system/OffShelf";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//修改公佈欄
    @RequestMapping("/SaveBillboard")
    public String SaveBillboard(BillboardBean bean, HttpSession session) {
        logger.info("修改公佈欄");
        // 儲存公佈欄
        BillboardBean save = ss.SaveBillboard(bean, session);
        return "redirect:/system/billboard/" + save.getBillboardid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取公佈欄細節
    @RequestMapping("/billboard/{id}")
    public String billboard(Model model, @PathVariable("id") Integer id) {
        logger.info("進入公佈欄細節 {}", id);
        BillboardBean bean = ss.getBillboard(id);
        bean.setContent(bean.getContent().replaceAll("<br>", "\n"));
        model.addAttribute("bean", bean);
        model.addAttribute("uuid", ZeroTools.getUUID());
        return "/system/billboard";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除公佈欄
    @RequestMapping("/delBillboard")
    @ResponseBody
    public String delMarket(@RequestParam("id") List<Integer> id) {
        logger.info("刪除公佈欄 {}", id);
        ss.delBillboard(id);
        return "刪除成功";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//公佈欄授權
    @RequestMapping("/authorize")
    @ResponseBody
    public String authorize(@RequestParam("adminid") Integer adminid) {
        System.out.println("*****公佈欄授權*****");
        logger.info("產生公佈欄授權 {}", adminid);
        String uuid = ZeroTools.getUUID();
        if (adminid != 0) {
            AdminBean aBean = ar.getById(adminid);
            String mailTo = aBean.getEmail();
            String Subject = "公佈欄授權";
            AuthorizeBean authorizeBean = new AuthorizeBean();
            authorizeBean.setId(uuid);
            authorizeBean.setUsed(aBean.getName());
            authorizeRepository.save(authorizeBean);
            String text = String.format("<a href='http://192.168.11.100:8080/CRM/authorize/%s'>點擊鍊接留言</a>", uuid);
            String maillist = "";
            zTools.mail(mailTo, text, Subject, maillist);
        } else {
            AuthorizeBean authorizeBean = new AuthorizeBean();
            authorizeBean.setId(uuid);
            authorizeBean.setUsed("所有人");
            authorizeRepository.save(authorizeBean);
        }
        return String.format("http://192.168.11.100:8080/CRM/authorize/%s", uuid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//新增群組子項
    @RequestMapping("/addOption/{group}/{option}")
    @ResponseBody
    public String addOption(@PathVariable("group") String group, @PathVariable("option") String option,
                            HttpServletRequest sce) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 新增公佈欄群組子項 {}:{}", adminBean.getName(), group, option);
        String resuly = ss.saveOption(group, option);
        //上傳新資料
        ss.updataOption(sce);
        return resuly;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除群組子項
    @RequestMapping("/delOption/{group}/{option}")
    @ResponseBody
    public String delOption(@PathVariable("group") String group, @PathVariable("option") String option,
                            HttpServletRequest sce) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 刪除群組子項 {}:{}", adminBean.getName(), group, option);
        if (option.equals("全部")) return "全部 不能刪除";
        String result = ss.delOption(group, option);
        //上傳新資料
        ss.updataOption(sce);
        return result;
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//上傳型錄
    @RequestMapping("/upFile/{billboardid}")
    @ResponseBody
    public String upFile(MultipartHttpServletRequest multipartRequest, @PathVariable("billboardid") Integer billboardid) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 上傳公佈欄型錄 {}", adminBean.getName(), billboardid);
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
                    String path2 = "C:/CRMfile/";
//					String path2 = "E:/CRMfile/";
                    String path3 = "C:\\Users\\Rong\\Desktop\\tomcat-9.0.41\\webapps\\CRM\\WEB-INF\\classes\\static\\file\\";


                    // 檔案輸出
                    System.out.println("檔案輸出到" + path2 + fileMap.get("file" + i).getOriginalFilename());
                    fileMap.get("file" + i).transferTo(new File(path2 + fileMap.get("file" + i).getOriginalFilename()));
                    // 檔案複製
                    String pic_path;
                    try {
                        // 判斷最後一個檔案目錄是否為bin目錄
                        if (("bin").equals(bin_path)) {
                            // 獲取儲存上傳圖片的檔案路徑
                            pic_path = tomcat_path.substring(0, System.getProperty("user.dir").lastIndexOf("\\"))
                                    + "/webapps/CRM/WEB-INF/classes/static/file/";
                            // 列印路徑
                            System.out.println(pic_path + fileMap.get("file" + i).getOriginalFilename());
                            File source = new File(path3 + fileMap.get("file" + i).getOriginalFilename());
                            File dest = new File(pic_path + fileMap.get("file" + i).getOriginalFilename());
                            Files.copy(source.toPath(), dest.toPath());
                            System.out.println("複製成功");
                        } else {
                            File source = new File(path2 + fileMap.get("file" + i).getOriginalFilename());
                            File dest = new File(path3 + fileMap.get("file" + i).getOriginalFilename());
                            System.out.println(path2 + fileMap.get("file" + i).getOriginalFilename());
                            Files.copy(source.toPath(), dest.toPath());
                            System.out.println("複製成功");
                        }

                    } catch (Exception e) {
                        System.out.println("複製失敗");
                    }

//3. 儲存檔案名稱到資料庫
                    BillboardFileBean billBoardFileBean = new BillboardFileBean();
                    billBoardFileBean.setBillboardid(billboardid);
                    billBoardFileBean.setFileid(uuid);
//					billBoardFileBean.setUrl(uuid + lastname); //使用uuid建檔名
                    billBoardFileBean.setUrl(fileMap.get("file" + i).getOriginalFilename());
                    billBoardFileBean.setName(fileMap.get("file" + i).getOriginalFilename());
                    ss.saveUrl(billBoardFileBean);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "儲存失敗 請聯絡管理員";
        }
        return "上傳成功";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除型錄
    @RequestMapping("/remove/{fileid}/{billboardid}")
    public String remove(@PathVariable("fileid") String fileid, @PathVariable("billboardid") String billboardid) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 刪除公佈欄型錄 {}", adminBean.getName(), billboardid);
        ss.removefile(fileid);
        return "redirect:/system/billboard/" + billboardid;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//@他人
    @RequestMapping("/advice/{adminid}/{billboardid}")
    public String advice(@RequestParam("adviceto") Integer[] adviceto, @PathVariable("adminid") Integer adminid,
                         @PathVariable("billboardid") Integer billboardid) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} @他人 {}", adminBean.getName(), billboardid);
        if (adviceto.length == 1 & adviceto[0] == 0) {
            // 沒有人 就刪除資料
            ss.saveAdvice(adminid, billboardid);
        } else {
            ss.saveAdvice(adviceto, adminid, billboardid);
        }
        return "redirect:/system/billboard/" + billboardid;
    }


    @RequestMapping("/adviceBody/{adminid}/{billboardid}")
    @ResponseBody
    public String adviceBody(@RequestParam("adviceto") Integer[] adviceto, @PathVariable("adminid") Integer adminid,
                         @PathVariable("billboardid") Integer billboardid) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} @他人 {}", adminBean.getName(), billboardid);
        if (adviceto.length == 1 & adviceto[0] == 0) {
            // 沒有人 就刪除資料
            ss.saveAdvice(adminid, billboardid);
        } else {
            ss.saveAdvice(adviceto, adminid, billboardid);
        }
        return "redirect:/system/billboard/" + billboardid;
    }





    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//進入新增頁面
    @RequestMapping("/billboard/new")
    public String billboard(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 進入公佈欄新增頁面", adminBean.getName());
        model.addAttribute("uuid", ZeroTools.getUUID());
        return "/system/NewBillboard";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 新增
    @RequestMapping("/saveNewBillboard/{uuid}")
    public String saveNewBillboard(@PathVariable("uuid") String uuid, BillboardBean bean, HttpSession session) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 新增公佈欄 {}", adminBean.getName(), uuid);
//存檔		
        BillboardBean save = ss.SaveBillboard(bean, session);
//附件處理
        List<BillboardFileBean> list = bfr.findByAuthorize(uuid);
        for (BillboardFileBean b : list) {
            b.setBillboardid(save.getBillboardid());
            bfr.save(b);
        }

        return "redirect:/system/billboard/" + save.getBillboardid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索公布欄
    @RequestMapping("/selectBillboard")
    public String selectMarket(Model model, @RequestParam("search") String search) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 搜索公布欄 {}", adminBean.getName(), search);
        model.addAttribute("list", ss.selectBillboardt(search));
        return "/system/billboardList";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//修改員工
    @RequestMapping("/SaveAdmin")
    public String SaveAdmin(AdminBean abean, HttpServletRequest req) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 修改員工", adminBean.getName());
        logger.info(abean.toString());
        ar.save(abean);
        ServletContext sce = req.getServletContext();
        sce.setAttribute("admin", ar.findByStateOrState("在職", "新"));
        return "redirect:/system/adminList/adminid";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取圖書館
    @RequestMapping("/getlibrary")
    @ResponseBody
    public List<LibraryBean> getlibrary(@RequestParam("librarygroup") String librarygroup) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 讀取圖書館 {}", adminBean.getName(),librarygroup);
        return ss.getlibrary(librarygroup);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//新增圖書館子項
    @RequestMapping("/addLibrary")
    @ResponseBody
    public List<LibraryBean> addLibrary(@RequestParam("librarygroup") String librarygroup, @RequestParam("libraryoption") String libraryoption, HttpServletRequest req, HttpSession session) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 新增圖書館子項 {}:{}", adminBean.getName(), librarygroup, libraryoption);
        //取得使用者
        AdminBean ad = (AdminBean) session.getAttribute("user");
        System.out.println(ad);
        //儲存
        ss.addLibrary(librarygroup, libraryoption, ad.getName());
        //更新application
        ServletContext sce = req.getServletContext();
        Sort sort = Sort.by(Sort.Direction.DESC, "libraryoption");
        sce.setAttribute("library", lr.findAll(sort));
        return ss.getlibrary(librarygroup);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 刪除圖書館子項
    @RequestMapping("/delLibrary/{libaryid}")
    @ResponseBody
    public List<LibraryBean> delLibrary(@PathVariable("libaryid") String libaryid, HttpServletRequest req, HttpSession session) {
        System.out.println("*****刪除圖書館子項*****");
        //取得使用者
        AdminBean ad = (AdminBean) session.getAttribute("user");
        logger.info("{} 刪除圖書館子項 {}",ad.getName(),libaryid);
        //刪除
        String librarygroup = ss.delLibrary(libaryid, ad.getName());
        //更新application
        ServletContext sce = req.getServletContext();
        Sort sort = Sort.by(Sort.Direction.DESC, "libraryoption");
        sce.setAttribute("library", lr.findAll(sort));
        return ss.getlibrary(librarygroup);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 查詢圖書館紀錄
    @RequestMapping("/SetectLibraryRecord/{librarygroup}")
    @ResponseBody
    public List<LibraryChangeBean> SetectLibraryRecord(@PathVariable("librarygroup") String librarygroup) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 查詢圖書館修改紀錄 {}", adminBean.getName(), librarygroup);
        return ss.SetectLibraryRecord(librarygroup);
    }


}
