<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="/js/jquery-3.7.1.min.js"></script>
    <title>myPage</title>
</head>
<body align="center" style="margin:0;">

<div class=”mainFrame”  style="position: relative; width: 480px; height: 1030px; border:1px solid black; display: inline-block; overflow: hidden;">

    <div style="text-align: left; margin: 40px 10px; ">
        <button onclick="location.href='mother_mainPage'" style="background: white; border:none;"><span style="font-size: 45px; font-weight: bolder">< </span><span style="font-size: 25px; font-weight: bolder; position: relative; bottom: 6px;">마이페이지</span></button>
    </div>

    <div style="text-align: left; margin: 50px 40px 20px 40px;">

        <div style="border: none; border-bottom: 2px solid #A9E5FF; margin: 10px auto; width: 372px;padding-bottom: 10px;">

            <div style="display: inline-block; margin: 10px;">
                <img src="/img/sanpaIcon.png" style="width: 70px; height: 70px;">

            </div>

            <div style="display: inline-block; margin: 10px;">
                <span style="letter-spacing: 1px; font-weight: bolder; font-size: 23px; margin: 5px 3px; display: inline-block;">${helper.helper_name} 님</span>
                <br>
                <span style="display: inline-block; font-weight: bold; font-size: 18px; color: rgba(0, 0, 0, 0.6); margin: 5px 3px;">산모 회원</span>
            </div>

            <div style="display: inline-block; margin: 10px; text-align: right; position: relative; left: 38px; bottom: 20px;">
                <form action="helper_setUpdateForm" method="post">
                    <input type="hidden" name="helper_id" value="${helper.helper_id}">
                    <button style="font-size: 15px; border:2px solid rgba(0, 0, 0, 0.1); font-weight: bold; color: rgba(0, 0, 0, 0.4); background: white; border-radius: 7px; padding: 5px; text-decoration: none;">내 정보 수정</button>
                </form>
            </div>

        </div>

        <div style="margin-top: 100px;">

            <div onclick="location.href='#'" style="display: flex; justify-content: space-between; border: none; border-bottom: 2px solid rgba(0, 0, 0, 0.18); cursor: pointer;
                            margin: 30px auto; width: 372px;padding-bottom: 10px; color: rgba(0, 0, 0, 0.4); font-weight: bold; font-size: 19px;">
                <span>설정</span><span style="font-size: 25px; font-weight: bolder; color: rgba(0, 0, 0, 0.2); position: relative; bottom: 3px;">> </span>
            </div>


            <div id="btnToMother" onclick="location.href='changeMotherToHelper'" style="display: flex; justify-content: space-between; border: none; border-bottom: 2px solid rgba(0, 0, 0, 0.18); cursor: pointer;
                            margin: 30px auto; width: 372px;padding-bottom: 10px; color: rgba(0, 0, 0, 0.4); font-weight: bold; font-size: 19px;">
                <span>헬퍼 계정으로 변경</span><span style="font-size: 25px; font-weight: bolder; color: rgba(0, 0, 0, 0.2); position: relative; bottom: 3px;">> </span>
            </div>

            <div id="dismissBtn" style="display: flex; justify-content: space-between; border: none; border-bottom: 2px solid rgba(0, 0, 0, 0.18); cursor: pointer;
                            margin: 30px auto; width: 372px;padding-bottom: 10px; color: rgba(0, 0, 0, 0.4); font-weight: bold; font-size: 19px;">
                <span>산모 서비스 이용 해지</span><span style="font-size: 25px; font-weight: bolder; color: rgba(0, 0, 0, 0.2); position: relative; bottom: 3px;">> </span>
            </div>

            <script>

                $('#dismissBtn').click(function () {
                    if(confirm("산모 서비스 이용을 해지하시겠습니까?\n\n해지를 진행해도\n기존 산모 데이터는 유지할 수 있습니다.")) {
                        alert("이용 해지가 완료됐습니다.");
                        location.href='dismissMother';
                    } else {
                        return false;
                    }
                })

            </script>


            <div onclick="location.href='#'" style="display: flex; justify-content: space-between; border: none; border-bottom: 2px solid rgba(0, 0, 0, 0.18); cursor: pointer;
                            margin: 30px auto; width: 372px;padding-bottom: 10px; color: rgba(0, 0, 0, 0.4); font-weight: bold; font-size: 19px;">
                <span>고객센터</span><span style="font-size: 25px; font-weight: bolder; color: rgba(0, 0, 0, 0.2); position: relative; bottom: 3px;">> </span>
            </div>

            <div onclick="location.href='logout'" style="display: flex; justify-content: space-between; border: none; border-bottom: 2px solid rgba(0, 0, 0, 0.18); cursor: pointer;
                            margin: 30px auto; width: 372px;padding-bottom: 10px; color: rgba(0, 0, 0, 0.4); font-weight: bold; font-size: 19px;">
                <span>로그아웃</span><span style="font-size: 25px; font-weight: bolder; color: rgba(0, 0, 0, 0.2); position: relative; bottom: 3px;">> </span>
            </div>


        </div>

    </div>




    <div style="position: relative; margin-top: 155px; margin-bottom: 0px;">
        <img src="/img/sanpaLogo.png">
    </div>

</div>

</body>
</html>












