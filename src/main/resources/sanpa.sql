/*


	★	0226 변경 사항	  ★

- 테이블 전화번호 속성에 "-" 문자열 값이 있으면 오류가 발생해서 수정
- 헬퍼에서 산모로 변경하는 실험을 위한 test1~test9까지 helper테이블에 값 입력
- 맨 밑 하단 부분에 검색을 위한 select문 기입
- insert문 중간에 기입돼 있던 select문 삭제하여 정리함
- helper 테이블에 기입 된 admin 계정의 helper_status를 9로 지정 (로그인할 때 유효성 검사)

- mother 테이블에 값이 있으면 helper 테이블 값 변경 불가 수정




-- 트리거 생성이 안되기에, 자바에서 구현해야될 기능 --

1. invite_list에서 accept의 값이 0에서 다른 숫자로 변할 때 
친구리스트에 등록은 되지만 invite_list에서 값이 변하지 않고 테이블에서 사라지지 않음.
accept의 값이 2로 변하면(거절을 누르면) invite_list에서 삭제되도록 해야함


*/




drop database sanpa;

/*	헬퍼 테이블 생성     */
create database sanpa;

use sanpa;

create table helper (
                        helper_id varchar(30) primary key comment '아이디',
                        helper_password varchar(30) not null comment '비밀번호',
                        helper_name varchar(30) not null comment '이름',
                        helper_email varchar(30) unique not null comment '이메일',
                        helper_tel varchar(14) unique not null comment '연락처',
                        helper_address varchar(50) not null comment '주소',
                        helper_address_detail varchar(50) comment '상세주소',
                        helper_birth date not null comment '생년월일',
                        helper_alaram int default 0 comment '알림설정 0이면 거부, 1이면 동의',
                        helper_location int default 1 comment '위치동의 0이면 거부, 1이면 동의',
                        helper_info int default 1 comment '개인정보동의 0이면 거부, 1이면 동의',
                        helper_status int default 0 comment '0이면 헬퍼, 1이면 산모, 9면 관리자'
);





/*	산모 테이블 생성     */
create table mother (
                        helper_id varchar(30),
                        mother_id varchar(30) primary key comment '산모아이디',
                        mother_babyName varchar(30) default 'baby' comment '태명',
                        mother_due_date date comment '출산 예정일',
                        mother_d_day int comment '출산까지의 d-day, 출산 예정일을 입력하면 트리거가 자동으로 날짜를 계산해줌',
                        mother_info int default 1 comment '산모개인정보 1이면 동의, 0이면 거부',
                        mother_emergency_alaram int default 0 comment '0일 경우 이상없음, 1일 경우 A버튼, 2일 경우 B버튼',
                        constraint helper_id foreign key (helper_id) references helper (helper_id)
);




/* 산모 오늘의 상태 테이블 생성 */
create table mother_daily_report (
                                     mother_id varchar(30) not null comment '산모아이디',
                                     report_date date comment '오늘의 상태 입력 날짜',
                                     general_status varchar(30) comment '상태란, 예: 좋음, 나쁨, 그냥그럼, 어디가 아픔',
                                     status_detail varchar(300) comment '상태에 대한 자세한 설명(비고)',
                                     constraint daily_report_mother_id foreign key (mother_id) references mother (mother_id)
);




/* 산모의 개인 검진 일지 테이블 */
create table mother_health_report (
                                      mother_id varchar(30) not null comment '산모아이디',
                                      prescription varchar(100) comment '처방전 사진, 현재 복용중인 약봉투 사진으로써, 올리기 위한 경로 컬럼',
                                      hospital_name varchar(30) comment '산모가 다녀온 병원',
                                      medicine_name varchar(30) comment '병원에서 처방해준 약',
                                      visited_date date comment '산모가 병원에 다녀온 날짜',
                                      result varchar(30) comment '당일 컨디션 상태 danger(위험), bad(조금위험), caution(주의), good(양호), very good(매우양호)',
                                      condition_detail varchar(100) comment '상태에 대한 자세한 설명 (비고)',
                                      constraint report_mother_id foreign key (mother_id) references mother (mother_id)
);



/* 병원 테이블 */
create table hospital (
                          mother_id varchar(30) not null comment '산모아이디',
                          hospital_name varchar(30) comment '산모가 다녀온 병원',
                          visited_date date comment '산모가 병원에 다녀온 날짜',
                          constraint hospital_mother_id foreign key (mother_id) references mother (mother_id)
);



/* 약 테이블 */
create table medicine (
                          mother_id varchar(30) not null comment '산모아이디',
                          medicine_name varchar(30) comment '병원에서 처방해준 약',
                          visited_date date comment '산모가 병원에 다녀온 날짜',
                          constraint medicine_mother_id foreign key (mother_id) references mother (mother_id)
);




/* 초대 수락 대기중인 리스트 */
/* accept값이 1로 변하면 connection_list에 자동 추가되는 트리거만 제작함, 2로 변하면 삭제되는건 java에서 진행해야함 */
/* accept의 값이 0에서 변하면 invite_list에서 삭제되는것도 제작해야함 */
create table invite_list (
                             helper_id varchar(30) not null comment '헬퍼테이블에서의 기본키',
                             mother_id varchar(30) not null comment '산모테이블에서의 기본키',
                             accept int default 0 comment '0일때는 대기중, 1일때는 수락, 2일때는 거절 ',
                             constraint invite_list_helper_id foreign key (helper_id) references helper (helper_id),
                             constraint invite_list_mother_id foreign key (mother_id) references mother (mother_id)
);



/* 초대를 수락한 사용자들 테이블 */
create table connection_list (
                                 helper_id varchar(30) not null comment '헬퍼테이블에서의 기본키',
                                 mother_id varchar(30) not null comment '산모테이블에서의 기본키',
                                 constraint connection_list_helper_id foreign key (helper_id) references helper (helper_id),
                                 constraint connection_list_mother_id foreign key (mother_id) references mother (mother_id)
);



/* A버튼을 누른 산모들 테이블(emergency_alaram이 1인 상태) // connection_list에서 엮인 헬퍼들 묶어서 사용 */
create table A_button_list (
                               mother_id varchar(30) not null comment '산모테이블에서의 기본키',
                               constraint A_button_mother_id foreign key (mother_id) references mother (mother_id)
);



/* B버튼을 누른 산모들 테이블(emergency_alaram이 2인 상태) // connection_list에서 엮인 헬퍼들 묶어서 사용 */
create table B_button_list (
                               mother_id varchar(30) not null comment '산모테이블에서의 기본키',
                               constraint B_button_mother_id foreign key (mother_id) references mother (mother_id)
);







/* 트리거 부분	트리거 부분		트리거 부분	트리거 	부분	트리거 부분 */
/* 트리거 부분	트리거 부분		트리거 부분	트리거 	부분	트리거 부분 */
/* 트리거 부분	트리거 부분		트리거 부분	트리거 	부분	트리거 부분 */


/* 헬퍼id가 생성되면 mother테이블에 자동 id생성 */
DELIMITER $$
CREATE TRIGGER helper_after_insert
    AFTER insert ON helper
    FOR EACH ROW
BEGIN
    IF NEW.helper_status = 1 THEN
        SET @new_mother_id = NEW.helper_id;
        INSERT INTO mother (mother_id, helper_id)
        VALUES (@new_mother_id, NEW.helper_id);
    END IF;
END; $$
DELIMITER ;



/* 헬퍼의 status가 0에서 1이 될 때 mother테이블에 자동 id생성 */
DELIMITER $$
CREATE TRIGGER helper_after_update
    AFTER update ON helper
    FOR EACH ROW
BEGIN
    IF NEW.helper_status = 1 THEN
        SET @new_mother_id = NEW.helper_id;

        IF (SELECT COUNT(*) FROM mother WHERE mother_id = @new_mother_id) = 0 THEN
            INSERT INTO mother (mother_id, helper_id)
            VALUES (@new_mother_id, NEW.helper_id);
        END IF;
    END IF;
END; $$
DELIMITER ;




/* 날짜로 바로 출력하는 프로시저 *//* 날짜로 바로 출력하는 프로시저 */
DELIMITER $$
CREATE TRIGGER mother_dDay_update
    BEFORE UPDATE ON mother
    FOR EACH ROW
BEGIN
    IF NEW.mother_due_date IS NOT NULL THEN
        SET NEW.mother_d_day = datediff(CURDATE(), new.mother_due_date);
    END IF;
END; $$
DELIMITER ;



/* mother_health_report에서 visited_date의 기본값이 current_date입력이 안돼서 트리거로 작성 */
DELIMITER $$
CREATE TRIGGER before_insert_mother_health_report
    BEFORE INSERT ON mother_health_report
    FOR EACH ROW
BEGIN
    IF NEW.visited_date IS NULL THEN
        SET NEW.visited_date = CURDATE();
    END IF;
END$$
DELIMITER ;




/* invite_list에서 accept의 값이 1로 변하면 connection_list에 추가 */
DELIMITER $$
CREATE TRIGGER invite_list_after_update
    AFTER update ON invite_list
    FOR EACH ROW
BEGIN
    IF NEW.accept = 1 THEN
        INSERT INTO connection_list (helper_id, mother_id)
        VALUES (NEW.helper_id, NEW.mother_id);
    END IF;
END; $$
DELIMITER ;




/* 산모테이블에서 mother_emergency_alaram이 1이 되면 A_button_list에 자동 추가 */
DELIMITER $$
CREATE TRIGGER A_button_list_after_update
    AFTER update ON mother
    FOR EACH ROW
BEGIN
    IF NEW.mother_emergency_alaram = 1 THEN
        INSERT INTO A_button_list (mother_id)
        VALUES (NEW.mother_id);
    END IF;
END; $$
DELIMITER ;


/* 산모테이블에서 mother_emergency_alaram이 2이 되면 B_button_list에 자동 추가 */
DELIMITER $$
CREATE TRIGGER B_button_list_after_update
    AFTER update ON mother
    FOR EACH ROW
BEGIN
    IF NEW.mother_emergency_alaram = 2 THEN
        INSERT INTO B_button_list (mother_id)
        VALUES (NEW.mother_id);
    END IF;
END; $$
DELIMITER ;



/* A_button_list에서 id가 지워지면 mother테이블의 E_alaram의 값이 0으로 바뀐다. */
DELIMITER $$
CREATE TRIGGER motherTable_update_E_alaram_into_0_2
    AFTER delete ON A_button_list
    FOR EACH ROW
BEGIN
    IF old.mother_id is not null THEN
        update mother set mother_emergency_alaram = '0' where old.mother_id = mother.mother_id;
    END IF;
END; $$
DELIMITER ;




/* B_button_list에서 id가 지워지면 mother테이블의 E_alaram의 값이 0으로 바뀐다. */
DELIMITER $$
CREATE TRIGGER motherTable_update_E_alaram_into_0
    AFTER delete ON B_button_list
    FOR EACH ROW
BEGIN
    IF old.mother_id is not null THEN
        update mother set mother_emergency_alaram = '0' where old.mother_id = mother.mother_id;
    END IF;
END; $$
DELIMITER ;




/* 산모의 개인 검진 일지 테이블에서 병원과 약 값이 할당되면 hospital 테이블에 자동 입력 */
DELIMITER $$
CREATE TRIGGER mother_health_report_after_insert_hospital
    AFTER insert ON mother_health_report
    FOR EACH ROW
BEGIN
    IF NEW.hospital_name IS NOT NULL THEN
        INSERT INTO hospital (mother_id, hospital_name, visited_date)
        VALUES (NEW.mother_id, NEW.hospital_name, NEW.visited_date);
    END IF;
END; $$
DELIMITER ;



/* 산모의 개인 검진 일지 테이블에서 병원과 약 값이 할당되면 medicine 테이블에 자동 입력 */
DELIMITER $$
CREATE TRIGGER mother_health_report_after_insert_medicine
    AFTER insert ON mother_health_report
    FOR EACH ROW
BEGIN
    IF NEW.medicine_name IS NOT NULL THEN
        INSERT INTO medicine (mother_id, medicine_name, visited_date)
        VALUES (NEW.mother_id, NEW.medicine_name, NEW.visited_date);
    END IF;
END; $$
DELIMITER ;




/* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 */
/* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 */






/* helper 테이블에 값 입력 & 산모아이디도 같이 생성*/
insert into helper(helper_id, helper_password, helper_name, helper_email, helper_tel, helper_address, helper_address_detail, helper_birth, helper_alaram, helper_location, helper_info, helper_status)
values
    ('test1', '1234', '테스터1', '1@1', '00000000001', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test2', '1234', '테스터2', '1@2', '00000000002', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test3', '1234', '테스터3', '1@3', '00000000003', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test4', '1234', '테스터4', '1@4', '00000000004', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test5', '1234', '테스터5', '1@5', '00000000005', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test6', '1234', '테스터6', '1@6', '00000000006', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test7', '1234', '테스터7', '1@7', '00000000007', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test8', '1234', '테스터8', '1@8', '00000000008', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test9', '1234', '테스터9', '1@9', '00000000009', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper1', '1234', '헬퍼1', '1111@1111', '01000001111', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper2', '1234', '헬퍼2', '2222@2222', '01000002222', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper3', '1234', '헬퍼3', '3333@3333', '01000003333', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper4', '1234', '헬퍼4', '4444@4444', '01000004444', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper5', '1234', '헬퍼5', '5555@5555', '01000005555', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper6', '1234', '헬퍼6', '6666@6666', '01000006666', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper7', '1234', '헬퍼7', '7777@7777', '01000007777', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper8', '1234', '헬퍼8', '8888@8888', '01000008888', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper9', '1234', '헬퍼9', '9999@9999', '01000009999', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('mother1', '1234', '산모1', '11111@11111', '01011111111', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother2', '1234', '산모2', '22222@22222', '01011112222', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother3', '1234', '산모3', '33333@33333', '01011113333', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother4', '1234', '산모4', '44444@44444', '01011114444', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother5', '1234', '산모5', '55555@55555', '01011115555', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother6', '1234', '산모6', '66666@66666', '01011116666', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother7', '1234', '산모7', '77777@77777', '01011117777', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother8', '1234', '산모8', '88888@88888', '01011118888', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother9', '1234', '산모9', '99999@99999', '01011119999', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('admin', 'admin', '관리자', 'admin@admin', '99999999999', '관리실', '205호', '950616', 1, 1, 1, 9);



/* mother 테이블에 값 추가 // 자바에서 넣을 때의 쿼리문 = update mother set mother_babyName = '하늘이', mother_due_date = '2024-10-01' where mother_id = 'mother1'; */
update mother set mother_babyName = case mother_id
                                        when 'mother1' then '하늘이'
                                        when 'mother2' then '사랑이'
                                        when 'mother3' then '튼튼이'
                                        when 'mother4' then '꼬물이'
                                        when 'mother5' then '별'
                                        when 'mother6' then '초롱이'
                                        when 'mother7' then '혜성이'
                                        when 'mother8' then '대한이'
                                        when 'mother9' then '민국이'
    end,
                  mother_due_date = case mother_id
                                        when 'mother1' then '2024-10-01'
                                        when 'mother2' then '2024-10-21'
                                        when 'mother3' then '2024-11-11'
                                        when 'mother4' then '2024-10-11'
                                        when 'mother5' then '2025-01-03'
                                        when 'mother6' then '2024-09-12'
                                        when 'mother7' then '2024-12-24'
                                        when 'mother8' then '2025-02-17'
                                        when 'mother9' then '2025-03-01'
                      end
where mother_id in ('mother1', 'mother2', 'mother3', 'mother4', 'mother5', 'mother6', 'mother7', 'mother8', 'mother9');








/* mother_daily_report 테이블 값 추가 */
insert into mother_daily_report (mother_id, report_date, general_status, status_detail)
values
    ('mother1', '2024-01-01', '그냥그럼', '특별한 이상이 없음'),
    ('mother1', '2024-01-11', '문제없음', '특별한 이상이 없음'),
    ('mother1', '2024-01-21', '아랫배가 땡김', '아프긴 하지만 참을만 한정도임'),
    ('mother1', '2024-02-05', '괜찮음', '특별한 이상이 없음'),
    ('mother1', '2024-02-15', '좋음', '기분이 좋음'),
    ('mother2', '2024-01-23', '그냥그럼', '특별한 이상이 없음'),
    ('mother2', '2024-01-25', '문제없음', '특별한 이상이 없음'),
    ('mother2', '2024-01-30', '아랫배가 땡김', '통증이 있지만 가벼워서 병원에 갈 필요는 없어보임'),
    ('mother2', '2024-02-01', '좋음', '아랫배 통증이 사라지고 편안함'),
    ('mother2', '2024-02-15', '문제없음', '특별한 이상이 없음'),
    ('mother2', '2024-02-20', '문제없음', '특별한 이상이 없음'),
    ('mother3', '2024-01-19', '문제없음', '특별한 이상이 없음'),
    ('mother3', '2024-02-19', '문제없음', '특별한 이상이 없음'),
    ('mother4', '2024-01-19', '문제없음', '특별한 이상이 없음'),
    ('mother4', '2024-01-20', '문제없음', '특별한 이상이 없음');




/* mother_health_report 테이블에 값 추가 */
insert into mother_health_report (mother_id, hospital_name, medicine_name, visited_date, result, condition_detail)
values
    ('mother1', '아이조아산부인과', '', '2024-01-01', 'good', '혹시나 해서 산부인과에 다녀왔는데 임신 사실을 알게 되었다. 상태는 아이와 나 모두 건강하다고 했다.'),
    ('mother1', '아이조아산부인과', '', '2024-01-08', 'good', '정기점검차 산부인과에 방문함'),
    ('mother1', '아이조아산부인과', '', '2024-01-15', 'good', '정기점검차 산부인과에 방문함'),
    ('mother1', '아이조아산부인과', '', '2024-01-20', 'good', '정기점검차 산부인과에 방문함'),
    ('mother1', '아이조아산부인과', '약1', '2024-01-21', 'not bad', '아랫배에 근육통이 있어 병원을 방문했지만 가벼운 증상이라 태아에는 무해한 간단한 약을 처방받음'),
    ('mother1', '아이조아산부인과', '', '2024-01-29', 'good', '기존의 통증은 완전히 사라졌으며 정기점검차 산부인과에 방문함'),
    ('mother1', '아이조아산부인과', '', '2024-02-08', 'good', '정기점검차 산부인과에 방문함'),
    ('mother2', '순풍산부인과', '', '2024-01-23', 'good', '정기점검차 산부인과에 방문함'),
    ('mother2', '순풍산부인과', '진통제', '2024-01-27', 'bad', '아랫배 통증이 심하여 산부인과에 방문했고 통증 완화를 위해 태아에는 영향이 없는 가벼운 진통제를 처방받음'),
    ('mother2', '순풍산부인과', '진통제', '2024-02-01', 'caution', '며칠이 지나도 통증이 사라지지 않아 산부인과에 재 방문을 하였고 초음파 및 각종 검사를 받았지만 이상이 없어서 가벼운 진통제를 다시 처방받음'),
    ('mother2', '순풍산부인과', '', '2024-02-15', 'good', '정기점검차 산부인과에 방문함'),
    ('mother2', '순풍산부인과', '', '2024-03-01', 'good', '정기점검차 산부인과에 방문함'),
    ('mother2', '순풍산부인과', '', '2024-03-23', 'good', '정기점검차 산부인과에 방문함'),
    ('mother3', '산인부과', '', '2024-01-19', 'good', '정기점검차 산부인과에 방문함'),
    ('mother3', '산인부과', '', '2024-02-05', 'good', '정기점검차 산부인과에 방문함'),
    ('mother3', '산인부과', '', '2024-02-15', 'good', '정기점검차 산부인과에 방문함'),
    ('mother3', '산인부과', '', '2024-02-25', 'good', '정기점검차 산부인과에 방문함'),
    ('mother3', '산인부과', '', '2024-03-05', 'good', '정기점검차 산부인과에 방문함'),
    ('mother3', '산인부과', '', '2024-03-15', 'good', '정기점검차 산부인과에 방문함');







/* 헬퍼가 산모를 추가(친구등록 요청)할 때 사용 (디비용)*/
INSERT INTO invite_list (helper_id, mother_id)
VALUES
    ('helper1', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011111111')),
    ('helper1', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011112222')),
    ('helper1', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011113333')),
    ('helper2', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011113333')),
    ('helper3', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011113333')),
    ('helper4', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011113333')),
    ('helper5', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011113333')),
    ('helper6', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011113333'));


/* 산모가 헬퍼를 추가(친구등록 요청)할 때 사용 (디비용)*/
INSERT INTO invite_list (helper_id, mother_id)
VALUES
    ((select helper_id from helper where helper_tel = '01000006666'), 'mother1'),
    ((select helper_id from helper where helper_tel = '01000007777'), 'mother1'),
    ((select helper_id from helper where helper_tel = '01000008888'), 'mother1'),
    ((select helper_id from helper where helper_tel = '01000009999'), 'mother1'),
    ((select helper_id from helper where helper_tel = '01000009999'), 'mother2'),
    ((select helper_id from helper where helper_tel = '01000009999'), 'mother3'),
    ((select helper_id from helper where helper_tel = '01000009999'), 'mother4');




/* invite_list(친구등록 대기목록 테이블)에서 친구 수락하기 */
UPDATE invite_list
SET accept = CASE
                 WHEN helper_id = 'helper1' AND mother_id = 'mother3' THEN '1'
                 WHEN helper_id = 'helper2' AND mother_id = 'mother3' THEN '1'
                 WHEN helper_id = 'helper3' AND mother_id = 'mother3' THEN '1'
                 WHEN helper_id = 'helper4' AND mother_id = 'mother3' THEN '1'
                 WHEN helper_id = 'helper5' AND mother_id = 'mother3' THEN '1'
                 WHEN helper_id = 'helper6' AND mother_id = 'mother3' THEN '1'
                 WHEN helper_id = 'helper9' AND mother_id = 'mother1' THEN '1'
                 WHEN helper_id = 'helper9' AND mother_id = 'mother2' THEN '1'
                 WHEN helper_id = 'helper9' AND mother_id = 'mother3' THEN '1'
                 WHEN helper_id = 'helper9' AND mother_id = 'mother4' THEN '1'
                 ELSE accept
    END
WHERE (helper_id, mother_id) IN (
                                 ('helper1', 'mother3'),
                                 ('helper2', 'mother3'),
                                 ('helper3', 'mother3'),
                                 ('helper4', 'mother3'),
                                 ('helper5', 'mother3'),
                                 ('helper6', 'mother3'),
                                 ('helper9', 'mother1'),
                                 ('helper9', 'mother2'),
                                 ('helper9', 'mother3'),
                                 ('helper9', 'mother4')
    );






/* 산모가 A 버튼을 누르는 쿼리문 // 자바에서 넣을 때의 쿼리문 = update mother set mother_emergency_alaram = '1' where mother_id = 'mother1'; */
UPDATE mother
SET mother_emergency_alaram = CASE
                                  WHEN mother_id IN ('mother1', 'mother2', 'mother3', 'mother4') THEN '1'
                                  ELSE mother_emergency_alaram
    END
WHERE mother_id IN ('mother1', 'mother2', 'mother3', 'mother4');




/* 산모가 B 버튼을 누르는 쿼리문 // 자바에서 넣을 때의 쿼리문 = update mother set mother_emergency_alaram = '2' where mother_id = 'mother5'; */
UPDATE mother
SET mother_emergency_alaram = CASE
                                  WHEN mother_id IN ('mother5', 'mother6', 'mother7', 'mother8') THEN '2'
                                  ELSE mother_emergency_alaram
    END
WHERE mother_id IN ('mother5', 'mother6', 'mother7', 'mother8');




select * from helper;
select * from mother;
select * from mother_daily_report;
select * from mother_health_report;
select * from hospital;



/* 약을 처방 받은 산모만 출력하기 위해 not을 붙임 */
select * from medicine where not medicine_name = "";

select * from invite_list;
select distinct * from connection_list;
select * from A_button_list;
select * from B_button_list;




/* 현재 산모와 친구등록 돼있는 헬퍼 검색 */
select distinct helper_id from connection_list where mother_id = 'mother1';



/* A 상황 해제 쿼리문 // button_list 테이블에서 행이 사라지면 mother_emergency_alaram도 자동으로 0으로 바뀜 */
delete from A_button_list where mother_id = 'mother1';


/* B 상황 해제 쿼리문 // button_list 테이블에서 행이 사라지면 mother_emergency_alaram도 자동으로 0으로 바뀜 */
delete from B_button_list where mother_id = 'mother5';





