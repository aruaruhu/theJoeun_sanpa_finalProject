package com.example.sanpa_com.view;

import com.example.sanpa_com.biz.helper.HelperVO;
import com.example.sanpa_com.biz.mother.MotherVO;
import com.example.sanpa_com.biz.non_helper.impl.SanpaDAO_mybatis;
import com.example.sanpa_com.biz.non_helper.impl.SanpaService;
import com.example.sanpa_com.view.helper.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

@Controller
public class SanpaController {

    @Autowired
    private SanpaService sanpaService;
    @Autowired
    private SanpaDAO_mybatis sanpaDAO;
    @Autowired
    private EmailService emailService;


    // 인증코드 받기
    @RequestMapping(value = "/getEmailCode", method = RequestMethod.POST)
    public @ResponseBody String mailConfirm(@RequestParam String email) throws MessagingException, UnsupportedEncodingException {

        String authCode = emailService.sendEmail(email);
        return authCode;
    }


    // 인덱스 페이지 진입
    @GetMapping("/login_move")
    public String loginMove(@RequestParam("status") int status, HttpSession session) {
        switch (status) {
            case 0:
                // helper_status가 0인 경우 helper/mainPage 경로 반환
                return "helper/mainPage";
            case 1:
                // helper_status가 1인 경우 Mother/motherMainPage 경로 반환
                return "mother/mainPage";
            case 9:
                // helper_status가 9인 경우 admin/dashboard 경로 반환
                return "admin/dashboard";
            default:
                // 알 수 없는 helper_status인 경우 400 Bad Request 반환
                return "../common/error";
        }
    }




    @PostMapping("/checkDuplicatedIdWhenInsertHelper")
    @ResponseBody
    public String checkDuplicatedIdWhenInsertHelper(@RequestBody HelperVO vo) throws IOException {

        HelperVO result = sanpaService.checkDuplicationIdWhenInsertHelper(vo);

        if(result != null) {
            return "Duplicated";
        } else if (result == null){
            return "Not Duplicated";
        } else {
            return "";
        }
    }//checkDuplicatedIdWhenInsertHelper()-end


    @RequestMapping("/insertHelper")
    public String insertHelper(@Valid HelperVO vo, @Valid MotherVO vo2, Model model) {

        if(vo.getHelper_id() == null || vo.getHelper_id().isEmpty() ||
            vo.getHelper_password() == null || vo.getHelper_password().isEmpty() ||
            vo.getHelper_name() == null || vo.getHelper_name().isEmpty() ||
            vo.getHelper_email() == null || vo.getHelper_email().isEmpty()) {

            return "non_helper/insertHelper";
        } else {
            sanpaService.insertHelper(vo);
            model.addAttribute("helper_name", vo.getHelper_name());
            if(vo.getHelper_status() == 1 && vo2.getMother_info() == 1) {
                sanpaService.insertMother(vo2);
            }




            return "non_helper/insertHelper_succeed";
        }
    }//insertHelper()-end


    @GetMapping("/findId")
    public String findId() { return "non_helper/findId"; }


    @PostMapping("findId")
    public String findId(HelperVO vo, Model model) {
        if(vo.getHelper_name() != null && !vo.getHelper_name().isEmpty() &&
           vo.getHelper_email() != null && !vo.getHelper_email().isEmpty()) {
            sanpaService.findId(vo);
            model.addAttribute("info", sanpaService.findId(vo));
            return "non_helper/foundId";
        } else {
            return null;
        }
    }

    @GetMapping("/findPassword")
    public String findPassword() { return "non_helper/findPassword"; }


    @RequestMapping(value = "/getEmailFromId", method = RequestMethod.POST)
    public ModelAndView getEmailFromId(HelperVO vo, ModelAndView model) throws MessagingException, UnsupportedEncodingException {
        if(vo.getHelper_id() != null && !vo.getHelper_id().isEmpty()) {
            sanpaService.getEmailFromId(vo);
            String helper_email = sanpaService.getEmailFromId(vo).getHelper_email();

            String authNum = emailService.sendEmail(helper_email);
            model.setViewName("non_helper/foundPassword");
            model.addObject("helper_email", helper_email);
            model.addObject("authNum", authNum);

            return model;
        }
        model.setViewName("non_helper/index");
        return model;
    }


    @PostMapping("/foundPassword")
    public String foundPassword(HelperVO vo, Model model) {
        model.addAttribute("helper_email", vo.getHelper_email());
        return "non_helper/changePassword";
    }


    @PostMapping("/changePassword")
    public String changePassword(HelperVO vo, Model model) {
        if(vo.getHelper_password() != null && !vo.getHelper_password().isEmpty() &&
           vo.getHelper_email() != null && !vo.getHelper_email().isEmpty()) {
            sanpaService.changePassword(vo);
            model.addAttribute("password", vo.getHelper_password());
            return "non_helper/changedPassword";
        }
        return null;
    }





}//SanpaController()-end
