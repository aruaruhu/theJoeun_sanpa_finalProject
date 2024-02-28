package com.example.sanpa_com.biz.helper.impl;

import com.example.sanpa_com.biz.helper.HelperVO;
import com.example.sanpa_com.biz.mother.MotherVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HelperDAO_mybatis {

    @Autowired
    SqlSessionTemplate mybatis;

    public HelperVO helper_setUpdateForm(HelperVO vo) {
        System.out.println("MyBatis의 helper_setUpdateForm을 실행합니다.");
        return mybatis.selectOne("HelperDAO_mybatis.helper_setUpdateForm", vo);
    }//helper_setUpdateForm()-end

    public MotherVO mother_setUpdateForm(MotherVO vo2) {
        System.out.println("MyBatis의 mother_setUpdateForm을 실행합니다.");
        return mybatis.selectOne("HelperDAO_mybatis.mother_setUpdateForm", vo2);
    }//mother_setUpdateForm()-end

    public void helper_update(HelperVO vo) {
        System.out.println("MyBatis의 helper_update을 실행합니다.");
        mybatis.update("HelperDAO_mybatis.helper_update", vo);
    }//helper_update()-end

    public MotherVO changeHelperToMother(MotherVO vo2) {
        System.out.println("MyBatis의 changeHelperToMother을 실행합니다.");
        return mybatis.selectOne("HelperDAO_mybatis.changeHelperToMother", vo2);
    }//changeHelperToMother()-end

    public void mother_dismissMother(HelperVO vo) {
        System.out.println("MyBatis의 mother_dismissMother을 실행합니다.");
        mybatis.update("HelperDAO_mybatis.mother_dismissMother", vo);
    }//mother_dismissMother()-end



}//HelperDAO_mybatis()-end
