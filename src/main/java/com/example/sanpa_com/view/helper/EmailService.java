package com.example.sanpa_com.view.helper;

import lombok.RequiredArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring5.SpringTemplateEngine;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Random;
@Service
@RequiredArgsConstructor
public class EmailService {

    //의존성 주입을 통해서 필요한 객체를 가져온다.
    private final JavaMailSender emailSender;

    // 타임리프를사용하기 위한 객체를 의존성 주입으로 가져온다
    private final SpringTemplateEngine templateEngine;
    //랜덤 인증 코드
    private String authNum;





    public boolean CheckAuthNum(String inputAuthNum, HttpServletResponse response){
        if(inputAuthNum == null || inputAuthNum.equals("")){
            String msg = "인증코드가 일치하지 않습니다.";
            try {
                response.setContentType("text/html; charset=utf-8");
                PrintWriter w = response.getWriter();
                w.write("<script>alert('"+msg+"');</script>");
                w.flush();
                w.close();
            } catch (Exception e) {
                e.printStackTrace();
            }


        } else if (!inputAuthNum.equals(authNum)){
            return false;
        }
        CheckAuthAlert();
        return true;

    }

    public void CheckAuthAlert() {
        System.out.println("이메일 인증이 확인되었습니다.");
    }









    //랜덤 인증 코드 생성
    public void createCode() {
        Random random = new Random();
        StringBuffer key = new StringBuffer();

        for(int i=0;i<8;i++) {
            int index = random.nextInt(3);

            switch (index) {
                case 0 :
                    key.append((char) ((int)random.nextInt(26) + 97));
                    break;
                case 1:
                    key.append((char) ((int)random.nextInt(26) + 65));
                    break;
                case 2:
                    key.append(random.nextInt(9));
                    break;
            }
        }
        authNum = key.toString();
    }

    //메일 양식 작성
    public MimeMessage createEmailForm(String email) throws MessagingException, UnsupportedEncodingException {

        createCode(); //인증 코드 생성
        String setFrom = "dnjfemwlffjt1@gmail.com"; //email-config에 설정한 자신의 이메일 주소(보내는 사람)
        String toEmail = email; //받는 사람
        String title = "SANmo PArtner 회원가입 인증 번호"; //제목

        MimeMessage message = emailSender.createMimeMessage();
        message.addRecipients(MimeMessage.RecipientType.TO, toEmail); //보낼 이메일 설정
        message.setSubject(title); //제목 설정
        message.setFrom(new InternetAddress(setFrom)); //보내는 이메일
        message.setText(setContext(authNum), "utf-8", "html");

        return message;
    }

    //실제 메일 전송
    public String sendEmail(String toEmail) throws MessagingException, UnsupportedEncodingException {

        //메일전송에 필요한 정보 설정
        MimeMessage emailForm = createEmailForm(toEmail);
        //실제 메일 전송
        emailSender.send(emailForm);
        return authNum; //인증 코드 반환
    }

    //타임리프를 이용한 context 설정
    public String setContext(String code) {
        Context context = new Context();
        context.setVariable("code", code);
        return templateEngine.process("mail", context); //mail.html
    }

}