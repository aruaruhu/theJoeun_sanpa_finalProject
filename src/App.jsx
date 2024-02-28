import React, { useState } from 'react';
import { HashRouter as Router, Routes, Route } from "react-router-dom";
import LoadingScreen from "./LoadingScreen";
import LoginInputPage from "./LoginInputPage";

const App = () => {
    const [loggedInUser, setLoggedInUser] = useState(null);
    const [helperStatus, setHelperStatus] = useState(null);

    const handleLogin = async (id, password) => {
        try {
            const response = await fetch('/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    helper_id: id,
                    helper_password: password,
                }),
            });
            if (response.ok) {
                const data = await response.json();
                console.log("Logged in as:", data.helper_id);
                setLoggedInUser(data.helper_id);
                setHelperStatus(data.helper_status);
                return data; // 로그인에 성공한 경우 데이터를 반환
            } else {
                // 로그인 실패 시 처리
                console.error('Login failed');
                setLoggedInUser(null);
                setHelperStatus(null);
                throw new Error('Login failed'); // 로그인 실패를 나타내는 에러 throw
            }
        } catch (error) {
            console.error('Login error:', error);
            setLoggedInUser(null);
            setHelperStatus(null);
            throw error; // 로그인 과정에서 발생한 오류 throw
        }
    };

    return (
        <div>
            {/* 라우팅 설정 */}
            <Router>
                <Routes>

                    <Route index element={
                        <LoginInputPage loggedInUser={loggedInUser} helperStatus={helperStatus} handleLogin={handleLogin}/>
                    } />


                </Routes>
            </Router>
            {/* 로딩 화면 */}
            <LoadingScreen />
        </div>
    );
}

export default App;