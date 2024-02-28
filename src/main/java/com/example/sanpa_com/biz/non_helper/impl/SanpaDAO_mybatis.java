package com.example.sanpa_com.biz.non_helper.impl;

import com.example.sanpa_com.biz.helper.HelperVO;
import com.example.sanpa_com.biz.mother.MotherVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SanpaDAO_mybatis {

    @Autowired
    private SqlSessionTemplate mybatis;

    public void insertHelper(HelperVO vo) {
        System.out.println("MyBatis의 insertHelper를 실행합니다.");
        mybatis.insert("Non_HelperDAO_mybatis.insertHelper", vo);
    }//insertHelper()-end

    public void insertMother(MotherVO vo2) {
        System.out.println("MyBatis의 insertMother를 실행합니다.");
        mybatis.update("Non_HelperDAO_mybatis.insertMother", vo2);
    }//=insertMother()-end

    public HelperVO login(HelperVO vo) {
        System.out.println("MyBatis의 login을 실행합니다.");
        return mybatis.selectOne("Non_HelperDAO_mybatis.login", vo);
    }

    public HelperVO  checkDuplicationIdWhenInsertHelper(HelperVO vo) {
        System.out.println("MyBatis의 checkDuplicationIdWhenInsertHelper을 실행합니다.");
        return mybatis.selectOne("Non_HelperDAO_mybatis.checkDuplicationIdWhenInsertHelper", vo);
    }//checkDuplicationIdWhenInsertHelper()-end

    public HelperVO findId(HelperVO vo) {
        System.out.println("MyBatis의 findId를 실행합니다.");
        return mybatis.selectOne("Non_HelperDAO_mybatis.findId", vo);
    }

    public HelperVO getEmailFromId(HelperVO vo) {
        System.out.println("MyBatis의 getEmailFromId를 실행합니다.");
        return mybatis.selectOne("Non_HelperDAO_mybatis.getEmailFromId", vo);
    }

    public void changePassword(HelperVO vo) {
        System.out.println("MyBatis의 changePassword를 실행합니다.");
        mybatis.update("Non_HelperDAO_mybatis.changePassword", vo);
    }




}//SanpaDAO_mybatis
