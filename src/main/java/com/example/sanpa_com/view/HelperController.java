package com.example.sanpa_com.view;

import com.example.sanpa_com.biz.helper.HelperVO;
import com.example.sanpa_com.biz.helper.impl.HelperService;
import com.example.sanpa_com.biz.mother.MotherVO;
import com.example.sanpa_com.biz.non_helper.impl.SanpaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
public class HelperController {

    @Autowired
    HelperService helperService;

    @Autowired
    SanpaService sanpaService;


    @GetMapping("/helper_mainPage")
    public String helper_mainPage(HelperVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setHelper_id(helper_id);
        HelperVO helper = helperService.helper_setUpdateForm(vo);
        model.addAttribute("helper", helper);
        return "helper/mainPage";
    }




    @GetMapping("/helper_myPage")
    public String helper_myPage(HelperVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");
        if(helper_id != null) {
            vo.setHelper_id(helper_id);
            HelperVO helper = helperService.helper_setUpdateForm(vo);
            model.addAttribute("helper", helper);
            return "helper/myPage";
        }
        return "redirect:login";
    }

    @PostMapping("/helper_setUpdateForm")
    public String helper_update(HelperVO vo, MotherVO vo2 , HttpSession session, Model model) {
        String helper_id = (String)session.getAttribute("helper_id");
        if(helper_id.equals(vo.getHelper_id())) {
            // 헬퍼의 정보를 가져와 뿌리기
            vo.setHelper_id(helper_id);
            HelperVO helper = helperService.helper_setUpdateForm(vo);
            model.addAttribute("helper", helper);

            // 산모의 정보를 가져와 뿌리기
            vo2.setHelper_id(helper_id);
            MotherVO mother = helperService.mother_setUpdateForm(vo2);
            model.addAttribute("mother", mother);

            return "helper/update";
        } else {
            return null;
        }
    }


    @PostMapping("/helper_update")
    public String helper_update(@Valid HelperVO vo, @Valid MotherVO vo2) {
        if(vo != null) {
            helperService.helper_update(vo);
            sanpaService.insertMother(vo2);

            return "redirect:helper_myPage";
        }
        return null;
    }


    @GetMapping("/joinMother")
    public String joinMother(HelperVO vo, HttpSession session, Model model) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setHelper_id(helper_id);
        HelperVO helper = helperService.helper_setUpdateForm(vo);
        model.addAttribute("helper", helper);
        if(helper.getHelper_status()==0) {
            return "helper/joinMother";
        }

        return null;
    }



    @GetMapping("/changeHelperToMother")
    public String changeHelperToMother(HelperVO vo, HttpSession session, Model model) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setHelper_id(helper_id);
        HelperVO helper = helperService.helper_setUpdateForm(vo);
        model.addAttribute("helper", helper);
        if(helper.getHelper_status()==1) {
            return "mother/mainPage";
        }

        return null;
    }



    @GetMapping("/logout")
    public String logout(HttpSession session) {

        if(session.getAttribute("helper_id") != null) {
            session.invalidate();
            return "non_helper/index";
        }
        return null;
    }



}//HelperController()-end
