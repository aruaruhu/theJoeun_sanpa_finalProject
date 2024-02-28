package com.example.sanpa_com.biz.mother;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;
import org.hibernate.validator.constraints.Length;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.Future;
import javax.validation.constraints.PastOrPresent;
import java.time.LocalDate;

@Getter
@Setter
@Alias("MotherVO")
public class MotherVO {

    /* 산모 테이블 */

    // 외래키는 helper 테이블에서 helper_id를 가져옴
    public String helper_id;

    public String mother_id;

    public String mother_babyName;

    @Future
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    public LocalDate mother_due_date;

    public int mother_d_day;

    public int mother_info;

    public int mother_emergency_alaram;



    /* 산모 오늘의 상태 테이블 */

    // 외래키는 mother 테이블에서 mother_id를 가져옴

    @PastOrPresent
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    public LocalDate report_date;

    public String general_status;

    @Length(max = 300, message = "최소 1글자에서 300글자를 넘지 말아주세요.")
    public String status_detail;



    /* 산모의 개인 검진 일지 테이블 */

    // 외래키는 mother 테이블에서 mother_id를 가져옴

    public MultipartFile prescription; // 처방전 사진, 현재 복용중인 약봉투 사진으로써, 올리기 위한 경로 컬럼

    public String hospital_name;

    public String medicine_name;

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    public LocalDate visited_date;

    @Length(max = 30, message = "최소 1글자에서 30글자를 넘지 말아주세요.")
    public String result;

    @Length(max = 100, message = "최소 1글자에서 100글자를 넘지 말아주세요.")
    public String condition_detail;
    
    
    
    
    /* 병원 테이블과 약 테이블은 개인 검진 일지 테이블에 모두 포함됨 */
    
    
    
    /* 초대 수락 대기중인 리스트 테이블 */
    public int accept;
    
    
    /* 초대를 수락한 사용자들 테이블도 중복된 필드 값임 */
    
    
    
    /* 나머지 테이블도 중복된 필드값 */






}
