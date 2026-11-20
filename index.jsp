<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.Member6DAO, model.Member6" %>
<%
    request.setCharacterEncoding("UTF-8");
    String logout = request.getParameter("logout");
    if ("true".equals(logout)) {
        session.removeAttribute("user");
        session.invalidate();
    }

    String errorMsg = null;
    String action = request.getParameter("action");
    String usernameInput = request.getParameter("username");

    if ("login".equals(action)) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            errorMsg = "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!";
        } else {
            Member6DAO memberDAO = new Member6DAO();
            Member6 member = memberDAO.checkLogin(username, password);

            if (member != null) {
                session.setAttribute("user", member);
                String role = member.getRole();
                if ("Customer".equalsIgnoreCase(role)) {
                    response.sendRedirect("customer/MainUI6.jsp");
                    return;
                } else if ("Manager".equalsIgnoreCase(role)) {
                    response.sendRedirect("manager/MainUI6.jsp");
                    return;
                } else {
                    errorMsg = "Tài khoản có vai trò '" + role + "' không thuộc phạm vi truy cập Modul 1 hoặc Modul 2!";
                }
            } else {
                errorMsg = "Tên đăng nhập hoặc mật khẩu không chính xác!";
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GaraMan - Đăng nhập hệ thống</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        #password::-ms-reveal,
        #password::-ms-clear {
            display: none;
        }
        #togglePasswordBtn:hover {
            color: #1F2937 !important;
        }
    </style>
</head>
<body>
    <div class="container" style="max-width: 500px; margin-top: 50px;">
        <div class="window-card">
            <div class="window-header">
                <h2>Đăng nhập hệ thống (GaraMan)</h2>
            </div>
            
            <div class="window-body">
                <% if (errorMsg != null) { %>
                    <div style="background: #FEE2E2; border: 1px solid #F87171; color: #B91C1C; padding: 12px 16px; border-radius: 6px; margin-bottom: 20px; font-size: 0.95rem;">
                        ⚠️ <%= errorMsg %>
                    </div>
                <% } %>

                <form action="index.jsp" method="post">
                    <input type="hidden" name="action" value="login">
                    
                    <div style="margin-bottom: 18px;">
                        <label for="username" style="display: block; font-weight: 600; margin-bottom: 8px; color: #1F2937;">Tên đăng nhập:</label>
                        <input type="text" id="username" name="username" value="<%= usernameInput != null ? usernameInput : "" %>" placeholder="Nhập tên đăng nhập..." autocomplete="username" style="width: 100%; padding: 12px 14px; border: 1px solid #CBD5E1; border-radius: 6px; font-size: 1rem; box-sizing: border-box;" required autofocus>
                    </div>

                    <div style="margin-bottom: 24px;">
                        <label for="password" style="display: block; font-weight: 600; margin-bottom: 8px; color: #1F2937;">Mật khẩu:</label>
                        <div style="position: relative; display: flex; align-items: center;">
                            <input type="password" id="password" name="password" placeholder="Nhập mật khẩu..." autocomplete="current-password" style="width: 100%; padding: 12px 44px 12px 14px; border: 1px solid #CBD5E1; border-radius: 6px; font-size: 1rem; box-sizing: border-box;" required>
                            <button type="button" id="togglePasswordBtn" onclick="togglePassword()" aria-label="Hiện mật khẩu" title="Hiện/Ẩn mật khẩu" style="position: absolute; right: 10px; background: transparent; border: none; cursor: pointer; padding: 4px; display: flex; align-items: center; justify-content: center; color: #6B7280;">
                                <svg id="eyeIconShow" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                    <circle cx="12" cy="12" r="3"></circle>
                                </svg>
                                <svg id="eyeIconHide" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="display: none;">
                                    <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
                                    <line x1="1" y1="1" x2="23" y2="23"></line>
                                </svg>
                            </button>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary" style="width: 100%; padding: 14px; font-size: 1.05rem; justify-content: center; cursor: pointer;">
                        Đăng nhập
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const eyeShow = document.getElementById('eyeIconShow');
            const eyeHide = document.getElementById('eyeIconHide');
            const toggleBtn = document.getElementById('togglePasswordBtn');

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                eyeShow.style.display = 'none';
                eyeHide.style.display = 'block';
                toggleBtn.setAttribute('aria-label', 'Ẩn mật khẩu');
            } else {
                passwordInput.type = 'password';
                eyeShow.style.display = 'block';
                eyeHide.style.display = 'none';
                toggleBtn.setAttribute('aria-label', 'Hiện mật khẩu');
            }
        }
    </script>
</body>
</html>
