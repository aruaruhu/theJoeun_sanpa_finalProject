package com.example.sanpa_com.view;

import com.example.sanpa_com.biz.helper.HelperVO;
import com.example.sanpa_com.biz.helper.impl.HelperService;
import com.example.sanpa_com.biz.mother.impl.MotherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class MotherController {

    @Autowired
    HelperService helperService;

    @Autowired
    MotherService motherService;


    @GetMapping("/mother_mainPage")
    public String mother_mainPage(HelperVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setHelper_id(helper_id);
        HelperVO helper = helperService.helper_setUpdateForm(vo);
        model.addAttribute("helper", helper);
        return "mother/mainPage";
    }



    @GetMapping("/mother_myPage")
    public String mother_myPage(HelperVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");
        if(helper_id != null) {
            vo.setHelper_id(helper_id);
            HelperVO helper = helperService.helper_setUpdateForm(vo);
            model.addAttribute("helper", helper);
            return "mother/myPage";
        }
        return "redirect:login";
    }


    @GetMapping("/changeMotherToHelper")
    public String changeHelperToMother(HelperVO vo, HttpSession session, Model model) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setHelper_id(helper_id);
        HelperVO helper = helperService.helper_setUpdateForm(vo);
            model.addAttribute("helper", helper);
            return "helper/mainPage";

    }


    @GetMapping("/dismissMother")
    public String dismissMother(HelperVO vo, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setHelper_id(helper_id);
        helperService.mother_dismissMother(vo);
        return "redirect:helper_myPage";
    }



}//MotherController()-end
