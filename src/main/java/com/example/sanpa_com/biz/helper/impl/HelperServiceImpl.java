package com.example.sanpa_com.biz.helper.impl;

import com.example.sanpa_com.biz.helper.HelperVO;
import com.example.sanpa_com.biz.mother.MotherVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("helperService")
public class HelperServiceImpl implements HelperService{


    @Autowired
    HelperDAO_mybatis helperDAO;

    @Override
    public HelperVO helper_setUpdateForm(HelperVO vo) {
        System.out.println("HelperServiceImpl의 helper_setUpdateForm()를 실행합니다.");
        return helperDAO.helper_setUpdateForm(vo);
    }//helper_setUpdateForm()-end

    @Override
    public MotherVO mother_setUpdateForm(MotherVO vo2) {
        System.out.println("HelperServiceImpl의 mother_setUpdateForm()를 실행합니다.");
        return helperDAO.mother_setUpdateForm(vo2);
    }//mother_setUpdateForm()-end

    @Override
    public void helper_update(HelperVO vo) {
        System.out.println("HelperServiceImpl의 helper_update()를 실행합니다.");
        helperDAO.helper_update(vo);
    }//helper_update()-end

    @Override
    public MotherVO changeHelperToMother(MotherVO vo2) {
        System.out.println("HelperServiceImpl의 helper_update()를 실행합니다.");
        return helperDAO.changeHelperToMother(vo2);
    }//changeHelperToMother()-end

    @Override
    public void mother_dismissMother(HelperVO vo) {
        System.out.println("HelperServiceImpl의 mother_dismissMother()를 실행합니다.");
        helperDAO.mother_dismissMother(vo);
    }//mother_dismissMother()-end



}//HelperServiceImpl()-end
