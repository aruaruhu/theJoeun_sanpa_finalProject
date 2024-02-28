package com.example.sanpa_com.biz.helper.impl;

import com.example.sanpa_com.biz.helper.HelperVO;
import com.example.sanpa_com.biz.mother.MotherVO;

public interface HelperService {

    public HelperVO helper_setUpdateForm(HelperVO vo);
    public MotherVO mother_setUpdateForm(MotherVO vo2);
    public void helper_update(HelperVO vo);
    public MotherVO changeHelperToMother(MotherVO vo2);
    public void mother_dismissMother(HelperVO vo);


}
