package com.example.sanpa_com.biz.non_helper.impl;

import com.example.sanpa_com.biz.helper.HelperVO;
import com.example.sanpa_com.biz.mother.MotherVO;

public interface SanpaService {

    public void insertHelper(HelperVO vo);
    public HelperVO login(HelperVO vo);
    public HelperVO checkDuplicationIdWhenInsertHelper(HelperVO vo);
    public HelperVO findId(HelperVO vo);
    public HelperVO getEmailFromId(HelperVO vo);
    public void changePassword(HelperVO vo);
    public void insertMother(MotherVO vo2);


}
