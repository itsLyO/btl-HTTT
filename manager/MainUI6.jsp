<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Member6" %>
<%
    Member6 user = (Member6) session.getAttribute("user");
    if (user == null || !"Manager".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("../index.jsp");
        return;
    }
    String mgrName = "Nguyễn Văn Quản";
    if (user != null && user.getFullName() != null) {
        mgrName = user.getFullName().getFullName();
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giao diện chính nhân viên quản lí</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container" style="max-width: 650px;">
        <div class="window-card">
            <div class="window-header">
                <h2>Giao diện chính nhân viên quản lí</h2>
            </div>
            
            <div class="window-body">
                <!-- Thanh thong tin chao mung gia lap -->
                <div class="info-bar">
                    <div>Người đăng nhập: <strong><%= mgrName %></strong></div>
                    <div>Vai trò: <strong>Nhân viên quản lí (Manager)</strong></div>
                </div>

                <div class="section-title" style="margin-bottom: 18px; font-weight: 700;">
                    Menu chức năng quản lí:
                </div>

                <div style="display: flex; flex-direction: column; gap: 14px; margin: 20px 0;">
                    <a href="StatsSelectionUI6.jsp" class="btn btn-primary" style="padding: 16px; font-size: 1.05rem; justify-content: flex-start; text-decoration: none;">
                        📊 Xem báo cáo thống kê
                    </a>
                    <a href="#" class="btn btn-secondary" style="padding: 14px; justify-content: flex-start; text-decoration: none; color: #4B5563; background: #F3F4F6;" onclick="alert('Chức năng quản lý dịch vụ & phụ tùng đang phát triển'); return false;">
                        ⚙️ Quản lý dịch vụ & phụ tùng
                    </a>
                </div>

                <div style="margin-top: 24px; border-top: 1px solid #E5E7EB; padding-top: 16px; display: flex; justify-content: space-between; align-items: center;">
                    <a href="../index.jsp?logout=true" class="btn btn-secondary">Đăng xuất</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
