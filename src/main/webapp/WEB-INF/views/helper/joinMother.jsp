<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert title here</title>
    <script src="/js/jquery-3.7.1.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
    <%
        String logo = "<svg width='180' height='56' viewBox='0 0 180 56' fill='none' xmlns='http://www.w3.org/2000/svg'><path d='M52.1368 13.7176C55.9554 13.7176 59.0509 10.6468 59.0509 6.85878C59.0509 3.07078 55.9554 0 52.1368 0C48.3182 0 45.2227 3.07078 45.2227 6.85878C45.2227 10.6468 48.3182 13.7176 52.1368 13.7176Z' fill='#FF578B' fill-opacity='0.8'/><path d='M15.66 23.8194C11.9497 23.8194 10.0664 25.4213 10.0101 27.6074C9.95812 30.0082 12.322 31.1849 15.8202 31.9322L19.2102 32.7311C26.6871 34.3846 31.0469 38.0695 31.0988 44.2583C31.0469 51.568 25.3407 56.0002 15.66 56.0002C7.64186 56.0002 1.94863 52.9982 0.134595 46.9382C-0.488846 44.851 1.1347 42.7637 3.32973 42.7637H5.76288C7.118 42.7637 8.28695 43.6184 8.80215 44.8596C9.78494 47.2131 12.2311 48.4199 15.5518 48.4199C19.4266 48.4199 21.7386 46.7106 21.7905 44.2583C21.7386 42.0164 19.747 40.8439 15.4435 39.8819L11.3565 38.9199C4.63289 37.3737 0.541563 34.0625 0.541563 28.2473C0.48961 21.0965 6.88854 16.2949 15.712 16.2949C22.5871 16.2949 27.5747 19.1381 29.5835 23.682C30.5447 25.8594 28.9428 28.3031 26.5486 28.3031H24.202C22.9205 28.3031 21.8122 27.5387 21.2277 26.4091C20.3704 24.7514 18.4828 23.8194 15.66 23.8194Z' fill='#FF578B' fill-opacity='0.8'/><path d='M105.28 55.4673H102.535C101.448 55.4673 100.427 54.9391 99.8074 54.0501L84.9791 32.7866H84.7106V52.1775C84.7106 53.9942 83.2256 55.4673 81.3943 55.4673H78.8789C77.0475 55.4673 75.5625 53.9942 75.5625 52.1775V20.117C75.5625 18.3003 77.0475 16.8271 78.8789 16.8271H81.7233C82.8187 16.8271 83.8404 17.364 84.4595 18.2573L99.1277 39.5079H99.4524V20.117C99.4524 18.3003 100.937 16.8271 102.769 16.8271H105.284C107.116 16.8271 108.601 18.3003 108.601 20.117V52.1775C108.601 53.9942 107.116 55.4673 105.284 55.4673H105.28Z' fill='#FF578B' fill-opacity='0.8'/><path d='M114.516 20.117C114.516 18.3003 116.001 16.8271 117.832 16.8271H130.44C139.207 16.8271 144.588 22.2686 144.588 30.1152C144.588 37.9618 139.103 43.3518 130.171 43.3518H126.976C125.145 43.3518 123.66 44.8249 123.66 46.6416V52.1775C123.66 53.9942 122.175 55.4673 120.343 55.4673H117.828C115.997 55.4673 114.512 53.9942 114.512 52.1775V20.117H114.516ZM128.505 36.1451C132.808 36.1451 135.12 33.7443 135.12 30.1152C135.12 26.4861 132.808 24.1927 128.505 24.1927H126.981C125.149 24.1927 123.664 25.6658 123.664 27.4825V32.8596C123.664 34.6763 125.149 36.1494 126.981 36.1494H128.505V36.1451Z' fill='#FF578B' fill-opacity='0.8'/><path d='M144.226 51.1206L155.206 19.0601C155.665 17.7244 156.925 16.8311 158.345 16.8311H165.748C167.168 16.8311 168.432 17.7287 168.887 19.0643L179.823 51.1249C180.55 53.2594 178.953 55.467 176.684 55.467H173.892C172.446 55.467 171.164 54.535 170.731 53.1693L169.558 49.4929C169.121 48.1229 167.843 47.1952 166.397 47.1952H157.7C156.253 47.1952 154.972 48.1272 154.539 49.4929L153.366 53.1693C152.928 54.5393 151.651 55.467 150.205 55.467H147.365C145.092 55.467 143.495 53.2509 144.226 51.1206ZM166.038 38.4124L163.531 30.5271C163.116 29.2172 161.254 29.2 160.808 30.4971L158.119 38.3823C157.803 39.3014 158.496 40.2591 159.475 40.2591H164.67C165.635 40.2591 166.328 39.3272 166.034 38.4124H166.038Z' fill='#FF578B' fill-opacity='0.8'/><path d='M67.208 43.1241C70.914 40.5902 72.6804 35.8616 71.2301 31.3908C69.7451 26.8211 65.3723 23.9823 60.7571 24.2056L59.0037 19.0604C58.5491 17.7248 57.2849 16.8271 55.8648 16.8271H48.4615C47.0414 16.8271 45.7772 17.7248 45.3226 19.0604L34.3432 51.121C33.6115 53.2555 35.2134 55.4673 37.482 55.4673H40.3221C41.7682 55.4673 43.0497 54.5354 43.4826 53.1696L44.6559 49.4933C45.0932 48.1233 46.3704 47.1956 47.8164 47.1956H56.5143C57.9603 47.1956 59.2418 48.1276 59.6748 49.4933L60.848 53.1696C61.2853 54.5397 62.5625 55.4673 64.0085 55.4673H66.801C69.0697 55.4673 70.6716 53.2555 69.9399 51.1253L67.2123 43.1241H67.208ZM62.2681 37.0857C55.2457 37.0857 49.5352 31.4208 49.5352 24.4547C49.5352 23.0331 50.6998 21.8778 52.1329 21.8778C53.5659 21.8778 54.7305 23.0331 54.7305 24.4547C54.7305 28.5777 58.1118 31.9319 62.2681 31.9319C63.7012 31.9319 64.8658 33.0872 64.8658 34.5088C64.8658 35.9304 63.7012 37.0857 62.2681 37.0857Z' fill='#FF578B' fill-opacity='0.8'/></svg>";
    %>
    <style type="text/css">
        .head {
            font-weight: bolder;
            text-align: left;
            color: rgba(0, 0, 0, 0.6);
            margin-bottom: 3px;
            font-size: 21px;
        }
        .body_input {
            border: 2px solid rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            outline: none;
            padding : 5px 12px;
            margin-top: 3px;
            margin-bottom: 15px;
            width: 342px;
            font-weight: 500;
            font-size: 15px;
        }
        .body_input_short {
            width: 260px;
        }
        .body_input_short2 {
            width: 258px;
        }
        .body_btn {
            border: 2px solid rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            background: white;
            color: rgba(0, 0, 0, 0.4);
            font-weight: bold;
            font-size: 15px;
            padding: 3px;
        }
        .address_input {
            border: 2px solid rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            outline: none;
            padding : 5px 12px;
            font-weight: 400;
            font-size: 15px;
        }

        .address_input:nth-child(5) {
            width: 342px;
            margin: 5px auto;
        }
        .address_input:nth-child(7) {
            width: 342px;
        }

        .clause_container {
            background: rgba(135, 206, 235, 0.6);
            margin: 15px auto;
            margin-top: 0px;
            width: 342px;
            padding: 15px;
            border-radius: 7px;
            color: rgba(0, 0, 0, 0.5);
            font-weight: 500;
            font-size: 16px;
        }

        .clause_container > div {
            display: flex;
            justify-content: space-between;
            margin : 10px;
        }

        .r_span {
            font-size: 14px;
            text-decoration: underline;
        }

        .birth_input{
            border: 2px solid rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            background: white;
            color: rgba(0, 0, 0, 0.6);
            font-size: 15px;
            padding: 3px;
            font-weight: 500;
            font-size: 15px;
        }

        .mother_input {
            border: 2px solid rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            background: white;
            color: rgba(0, 0, 0, 0.45);
            padding: 3px;
            width: 113px;
            margin-top: 10px;
            font-weight: 500;
            font-size: 15px;
        }

        .insertMother_container1 {
            background: #FF9595;
            color: white;
            text-align: center;
            padding: 15px;
            border-radius: 5px;
            width: 342px;
            margin: 55px auto;
            font-size: 22px;
            line-height: 35px;
        }

        .insertMother_container1 p {
            margin: 0px auto;
        }
        .insertMother_container1 > p:first-child {
            font-weight: bold;
        }

        .insertMother_container1 > p:nth-child(2) {
            font-size: 12px;
            padding-top: 8px;
        }

        .insertMother_container2 {
            background: #F1EFEF;
            width: 342px;
            text-align: center;
            padding: 15px;
            border-radius: 5px;
            padding: 5px 15px;
            margin: 15px auto;
            border: 1px solid rgba(0, 0, 0, 0.1);
            color: rgba(0, 0, 0, 0.4);
            font-weight: bold;
            line-height: 30px;
        }

        .mother_hidden_container {
            margin-top: 70px;
        }

        .register_container {
            background: #FF9595;
            border-radius: 5px;
            border: 1px solid rgba(0, 0, 0, 0.1);
            padding: 5px 15px;
            margin: 50px auto;
            text-align: center;
        }

        .register_container > input {
            margin: 0px;
            padding: 10px;
            font-weight: 600;
            color: white;
            background: #FF9595;
            border: none;
            font-size: 19px;
        }

    </style>
</head>
<body align="center" style="margin:0;">

<div class=”mainFrame”  style="position: relative; width: 480px; height: 1030px; border:1px solid black; display: inline-block; overflow: scroll;">

    <div style="text-align: left; margin: 40px 10px; ">
        <button onclick="javascript:history.go(-1)" style="background: white; border:none;"><span style="font-size: 45px; font-weight: bolder">< </span><span style="font-size: 25px; font-weight: bolder; position: relative; bottom: 6px;">마이 페이지</span></button>
    </div>

    <div style="text-align: left; margin: 50px 40px 20px 40px">

        <form action="helper_update" method="post">

                <input id="idInput" name="helper_id" class="body_input_short body_input" type="hidden" value="${helper.helper_id}" readonly>
                <input id="motherIdInput" name="mother_id" type="hidden" >
                <input type="hidden" name="helper_password" value="${helper.helper_password}">
                <input type="hidden" name="helper_name" value="${helper.helper_name}">
                <input type="hidden" name="helper_email" value="${helper.helper_email}">
                <input type="hidden" name="helper_tel" value="${helper.helper_tel}">
                <input type="hidden" name="helper_address" value="${helper.helper_address}">
                <input type="hidden" name="helper_address_detail" value="${helper.helper_address_detail}">

                <div onclick="motherInsert()" class="insertMother_container1">
                    <p>산모이신가요?<br><span style="font-size: 20px">산모 서비스 가입을 진행하여<br>다양한 서비스를 이용해보세요.</span></p>
                </div>


                <div class="insertMother_container2">
                    <p>산모 서비스 가입하기<br>29,800/월</p>
                </div>


                <div class="mother_hidden_container">

                    <div>
                        <h2 style="font-style: italic; color: rgba(0, 0, 0, 0.7); text-align: center;">< 산모 정보 입력 ></h2><br>
                        <p class="head">출산 예정일</p>
                        <input name="mother_due_date" id="mother_due_date" class="birth_input" type="date" placeholder="출산 예정일"  onchange="notPastDateForDueDate()"><br>

                        <script>
                            function notPastDateForDueDate() {
                                var mother_due_date = new Date(document.getElementById('mother_due_date').value);
                                var now = new Date();

                                // 'now'의 시간을 00:00:00으로 설정
                                now.setHours(0,0,0,0);

                                if (mother_due_date < now) {
                                    alert("과거의 날짜는 선택하실 수 없습니다.");
                                    document.getElementById('mother_due_date').value = null;
                                }
                            }
                        </script>


                        <input name="mother_babyName" class="mother_input" type="text" placeholder="태명"><br><Br>

                        <p class="head">약관 동의</p>
                        <div class="clause_container">
                            <div>
              <span><input id="mother_info_chkbox" name="mother_info" type="checkbox" value="0" onclick="this.value=this.checked?1:0">&nbsp;
                    <input id="helper_status_chkbox" name="helper_status" type="hidden" value="0">산모의 개인 정보 이용 동의</span><span class="r_span">약관보기</span>
                            </div>
                        </div>
                        <br>


                        <script type="text/javascript">

                            $(document).ready(function() {
                                $('#mother_info_chkbox').change(motherInsert);
                            });

                            function motherInsert() {

                                let $mother_info = $('#mother_info_chkbox');
                                let $helper_status = $('#helper_status_chkbox');
                                if($mother_info.prop('checked')) {
                                    $helper_status.val(1);
                                } else {
                                    $helper_status.val(0);
                                }

                            }

                            $("form").submit(function(e) {
                                if($('#mother_info_chkbox').prop('checked') && $('#mother_info_chkbox').val() == '1') {
                                    alert(`환영합니다 ${helper.helper_name}님!\n\n산모 서비스 이용 가입이 완료됐습니다.`);
                                } else {
                                    e.preventDefault();
                                    alert("약관에 동의 해주세요.");
                                }
                            });

                        </script>



                        <p style="text-align: center; color: rgba(0, 0, 0, 0.6);">병원 및 복용약 등 기타 정보는 가입 후 <br>
                            <span style="text-decoration: underline;">검진 일지</span>에 기록하실 수 있습니다.
                        </p>
                    </div>
                </div>



            <br>
            <div class="register_container">
                <input id="insertHelperBtn" type="submit" value="가입하기" >
            </div>

        </form>
        <br><br>
    </div>

    <%=logo %><br><br><br><br>

</div>





</body>
</html>





