import React, { useState } from 'react';

const LoginInputPage = ({ handleLogin, loggedInUser, helperStatus }) => {
    // 아이디와 비밀번호를 입력받을 상태 변수들
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [loggedIn_User, setLoggedIn_User] = useState('');
    const [helper_Status, setHelper_Status] = useState(5); // 초기값은 적절하게 설정해주세요.

// 폼 제출 핸들러
    const handleSubmit = async (event) => {
        event.preventDefault(); // 기본 제출 동작 방지
        try {
            // handleLogin 함수 호출하여 로그인 처리
            const response = await handleLogin(username, password);
            if (response && response.helper_id != null) {
                console.log("Logged in as:", response.helper_id);
                // 서버에서 받은 응답 데이터를 이용하여 상태 업데이트
                setLoggedIn_User(response.helper_id);
                setHelper_Status(response.helper_status);
                // 로그인 후 이동할 URL 생성
                const redirectUrl = `/login_move?status=${response.helper_status}&id=${response.helper_id}`;
                // 해당 URL로 페이지 이동
                window.location.href = redirectUrl;
            } else {
                // 로그인 실패 시에는 적절한 에러 처리
                console.error('Login failed:', response);
            }
        } catch (error) {
            console.error('Login error:', error);
            // 로그인 실패 시 예외 처리
        }
    };

    return (
        <div style={{ marginTop: '200px' }}>
            <img src="/img/sanpaLogo.png" alt="Logo" />
            <h1 style={{ color: 'rgba(0, 0, 0, 0.5)', margin: '40px auto' }}>로그인</h1>
            <form onSubmit={handleSubmit}>
                <input
                    type="text"
                    placeholder="아이디"
                    name="helper_id"
                    required
                    value={username}
                    onChange={(e) => setUsername(e.target.value)}
                    style={{
                        background: '#fffcfc',
                        color: 'rgba(0, 0, 0, 0.5)',
                        padding: '10px',
                        margin: '10px',
                        fontSize: '20px',
                        fontWeight: 'bold',
                        borderRadius: '15px',
                        border: '1px solid rgba(0, 0, 0, 0.5)',
                    }}
                />
                <input
                    type="password"
                    placeholder="비밀번호"
                    name="helper_password"
                    required
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    style={{
                        background: '#fffcfc',
                        color: 'rgba(0, 0, 0, 0.5)',
                        padding: '10px',
                        margin: '10px',
                        fontSize: '20px',
                        fontWeight: 'bold',
                        borderRadius: '15px',
                        border: '1px solid rgba(0, 0, 0, 0.5)',
                    }}
                />
                <p style={{ textAlign: 'left', marginLeft: '100px', fontWeight: 'bold', color: 'rgba(0, 0, 0, 0.4)', marginTop: '50px', marginBottom: '50px' }}>
                    <input type="checkbox" />&nbsp;로그인 유지
                </p>
                <button
                    type="submit"
                    className="btn2"
                    style={{
                        width: '287px',
                        height: '44px',
                        color: 'white',
                        background: '#A9E5FF',
                        textAlign: 'center',
                        fontSize: '25px',
                        padding: '25px auto',
                        borderRadius: '15px',
                        boxShadow: '2px 4px 4px 0px rgba(0,0,0,0.4)',
                        border: 'none',
                    }}
                >로 그 인</button>
            </form>
            <br />
            <div style={{ display: 'flex', justifyContent: 'center' }}>
                <button onClick={() => window.location.href='insertHelper'} className="btn2" style={{ fontWeight: 'bold', fontSize: '16px', color: 'rgba(0, 0, 0, 0.3)', margin: '40px 20px', background: 'white', border: 'none' }}>
                    회원가입
                </button>
                <button onClick={() => {}} className="btn2" style={{ fontWeight: 'bold', fontSize: '16px', color: 'rgba(0, 0, 0, 0.3)', margin: '40px 20px', background: 'white', border: 'none' }}>
                    아이디 찾기
                </button>
                <button onClick={() => {}} className="btn2" style={{ fontWeight: 'bold', fontSize: '16px', color: 'rgba(0, 0, 0, 0.3)', margin: '40px 20px', background: 'white', border: 'none' }}>
                    비밀번호 찾기
                </button>
            </div>
            <style type="text/css">
                {`
                input::placeholder {
                    color: rgba(0, 0, 0, 0.4);
                }
                .btn2:hover {
                    background: rgba(0, 0, 0, 0.1) !important;
                    border-radius: 15px;
                }
                `}
            </style>
        </div>
    );
};

export default LoginInputPage;