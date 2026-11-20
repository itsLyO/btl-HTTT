<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Member6, dao.Service6DAO, model.Service6, java.text.DecimalFormat, java.net.URLEncoder" %>
<%
    Member6 currentUser = (Member6) session.getAttribute("user");
    if (currentUser == null || !"Customer".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect("../index.jsp");
        return;
    }
    request.setCharacterEncoding("UTF-8");
    String idStr = request.getParameter("serviceId");
    if (idStr == null || idStr.trim().isEmpty()) {
        idStr = request.getParameter("id");
    }
    String keyWord = request.getParameter("keyWord");
    String backUrl = "SearchUI6.jsp";
    if (keyWord != null && !keyWord.trim().isEmpty()) {
        backUrl = "SearchUI6.jsp?keyWord=" + URLEncoder.encode(keyWord.trim(), "UTF-8");
    }

    int serviceId = -1;
    if (idStr != null && !idStr.trim().isEmpty()) {
        try {
            serviceId = Integer.parseInt(idStr.trim());
        } catch (Exception e) {
            serviceId = -1;
        }
    }

    Service6 s = null;
    if (serviceId > 0) {
        Service6DAO dao = new Service6DAO();
        s = dao.getServiceDetail(serviceId);
    }
    DecimalFormat df = new DecimalFormat("#,##0");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết dịch vụ</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container" style="max-width: 750px;">
        <div class="window-card">
            <div class="window-header">
                <h2>Chi tiết dịch vụ</h2>
            </div>
            
            <div class="window-body">
                <% if (s == null) { %>
                    <div style="padding: 24px; color: #DC2626; text-align: center;">
                        Không tìm thấy dịch vụ hợp lệ<%= (idStr != null && !idStr.trim().isEmpty()) ? " (mã yêu cầu: " + idStr.trim() + ")" : "" %>.
                    </div>
                <% } else { %>
                    <table class="detail-table">
                        <tbody>
                            <tr>
                                <th style="width: 200px;">ID dịch vụ:</th>
                                <td><%= s.getCode() %></td>
                            </tr>
                            <tr>
                                <th>Tên dịch vụ:</th>
                                <td><strong style="font-size: 1.1rem;"><%= s.getName() %></strong></td>
                            </tr>
                            <tr>
                                <th>Tiền công định mức:</th>
                                <td><strong style="color: #B91C1C; font-size: 1.1rem;"><%= df.format(s.getPrice()) %> đ</strong></td>
                            </tr>
                            <tr>
                                <th>Thời gian dự kiến:</th>
                                <td><%= s.getEstDuration() %> phút</td>
                            </tr>
                            <tr>
                                <th>Mô tả quy trình:</th>
                                <td><%= s.getDesc() != null ? s.getDesc() : "Đang cập nhật..." %></td>
                            </tr>
                            <tr>
                                <th>Ghi chú bảo hành:</th>
                                <td><%= s.getWarrantyNote() != null ? s.getWarrantyNote() : "Kiểm tra lại miễn phí trong vòng 7 ngày" %></td>
                            </tr>
                        </tbody>
                    </table>
                <% } %>

                <div style="margin-top: 24px; border-top: 1px solid #E5E7EB; padding-top: 16px;">
                    <a href="<%= backUrl %>" class="btn btn-secondary">Quay lại</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
