package com.example.sanpa_com.biz.admin;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@Alias("AdminVO")
public class AdminVO {

    public String admin_id;

    public String admin_password;
}
