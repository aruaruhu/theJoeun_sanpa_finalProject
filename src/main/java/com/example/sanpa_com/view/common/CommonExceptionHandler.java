package com.example.sanpa_com.view.common;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice("com.example.sanpa.view")
public class CommonExceptionHandler {

    @ExceptionHandler(ArithmeticException.class)
    public ModelAndView handleArithmeticException(Exception e) {

        ModelAndView mav = new ModelAndView();

        mav.addObject("exception", e);
        mav.setViewName("../common/arithmeticError");

        return mav;

    }//handleArithmeticException()-end

    @ExceptionHandler(NullPointerException.class)
    public ModelAndView handleNullPointException(Exception e) {

        ModelAndView mav = new ModelAndView();

        mav.addObject("exception", e);
        mav.setViewName("../common/nullPointError");

        return mav;
    }//handleNullPointException()-end

    @ExceptionHandler(Exception.class)
    public ModelAndView handleException(Exception e) {

        ModelAndView mav = new ModelAndView();

        mav.addObject("exception", e);
        mav.setViewName("../common/error"); //

        return mav;
    }//exception()-end

}//CommonExceptionHandler()-end
