package com.example.sanpa_com.biz.non_helper.impl;

import com.example.sanpa_com.biz.helper.HelperVO;
import com.example.sanpa_com.biz.mother.MotherVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("sanpaService")
public class SanpaServiceImpl implements SanpaService {

    @Autowired
    private SanpaDAO_mybatis sanpaDAO;

    @Override
    public void insertHelper(HelperVO vo) {
        System.out.println("SanpaServiceImpl의 insertHelper()를 실행합니다.");
        sanpaDAO.insertHelper(vo);
    }//insertHelper()-end

    @Override
    public void insertMother(MotherVO vo2) {
        System.out.println("SanpaServiceImpl의 insertMother()를 실행합니다.");
        sanpaDAO.insertMother(vo2);
    }

    @Override
    public HelperVO login(HelperVO vo) {
        System.out.println("SanpaServiceImpl의 login()를 실행합니다.");
        return sanpaDAO.login(vo);
    }//login()-end

    @Override
    public HelperVO checkDuplicationIdWhenInsertHelper(HelperVO vo) {
        System.out.println("SanpaServiceImpl의 checkDuplicationIdWhenInsertHelper()를 실행합니다.");
        return sanpaDAO.checkDuplicationIdWhenInsertHelper(vo);
    }//checkDuplicationIdWhenInsertHelper()-end

    @Override
    public HelperVO findId(HelperVO vo) {
        System.out.println("SanpaServiceImpl의 findId()를 실행합니다.");
        return sanpaDAO.findId(vo);
    }//logout()-end

    @Override
    public HelperVO getEmailFromId(HelperVO vo) {
        System.out.println("SanpaServiceImpl의 getEmailFromId()를 실행합니다.");
        return sanpaDAO.getEmailFromId(vo);
    }//getEmailFromId()-end

    @Override
    public void changePassword(HelperVO vo) {
        System.out.println("SanpaServiceImpl의 changePassword()를 실행합니다.");
        sanpaDAO.changePassword(vo);
    }//changePassword()-end



}
