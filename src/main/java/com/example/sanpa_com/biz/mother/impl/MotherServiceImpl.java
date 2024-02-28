package com.example.sanpa_com.biz.mother.impl;

import com.example.sanpa_com.biz.mother.MotherVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("motherService")
public class MotherServiceImpl implements MotherService{

    @Autowired
    MotherDAO_mybatis motherDAO;




}
