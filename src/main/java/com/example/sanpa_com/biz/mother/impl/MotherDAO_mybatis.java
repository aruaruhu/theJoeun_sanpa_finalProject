package com.example.sanpa_com.biz.mother.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MotherDAO_mybatis {

    @Autowired
    SqlSessionTemplate mybatis;


}
