package com.jetec.CRM.controler.service;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.model.MarketFileBean;
import com.jetec.CRM.model.ZeroMailBean;
import com.jetec.CRM.repository.MarketFileRepository;
import com.jetec.CRM.repository.ZeroMailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.time.LocalDate;
import java.util.List;

@Service
@Transactional
public class UpfileService {

    @Autowired
    MarketFileRepository MFR;
    @Autowired
    ZeroMailRepository zmr;

    public MarketFileBean save(MarketFileBean fileBean) {
        return MFR.save(fileBean);
    }

    public MarketFileBean getByid(String id) {
        return MFR.getById(id);
    }

    public List<MarketFileBean> getByfileForeignid(String fileforeignid) {
        return MFR.findByFileforeignid(fileforeignid);
    }

    public boolean existsByFileforeignid(String fileforeignid) {
        return MFR.existsByFileforeignid(fileforeignid);
    }

    public List<MarketFileBean> getByName(String name) {
        return MFR.findByName(name);
    }

    ////////////////////////////////////////////////////////
//刪除型錄
    public void delByName(String name) {
        MFR.deleteAllByName(name);
        File file = new File("c:/CRMfile/" + name);
        file.delete();
        File file2 = new File("e:/CRMfile/" + name);
        file2.delete();
    }
    ////////////////////////////////////////////////////////
//取得今天已經寄件數量
    public Integer getZeroMailnum() {
        LocalDate ld = LocalDate.now();
        if(zmr.existsByCreatetime(ld+"")){
            ZeroMailBean zeroMailBean =  zmr.findByCreatetime(ld.toString());
            return zeroMailBean.getNum();
        }else {
            return 0;
        }
    }

    public void saveZeroMailnum(Integer i) {

        LocalDate ld = LocalDate.now();
        if(zmr.existsByCreatetime(ld.toString())){
            ZeroMailBean zeroMailBean =  zmr.findByCreatetime(ld.toString());
           zeroMailBean.setNum(i);
            zmr.save(zeroMailBean);
        }else {

            zmr.save(new ZeroMailBean(ZeroTools.getUUID(),ld.toString(),i));
        }
    }
}
