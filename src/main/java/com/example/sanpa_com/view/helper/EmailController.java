package com.example.sanpa_com.view.helper;

import com.example.sanpa_com.biz.non_helper.EmailCheckDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;

@RestController
public class EmailController {

    @Autowired
    private EmailService emailService;

    @PostMapping("/emailauthCheck")
    public String authCheck(@ModelAttribute EmailCheckDto emailCheckDto, HttpServletResponse response){
        Boolean Checked=emailService.CheckAuthNum(emailCheckDto.getAuthNum(), response);
        if(Checked){
            return "ok";
        }
        else{
            throw new IllegalArgumentException("인증코드가 잘못됐습니다.!");
        }
    }

}
