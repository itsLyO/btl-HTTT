<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Member6, dao.SparePart6DAO, model.SparePart6, java.text.DecimalFormat, java.net.URLEncoder" %>
<%
    Member6 currentUser = (Member6) session.getAttribute("user");
    if (currentUser == null || !"Customer".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect("../index.jsp");
        return;
    }
    request.setCharacterEncoding("UTF-8");
    String idStr = request.getParameter("sparePartId");
    if (idStr == null || idStr.trim().isEmpty()) {
        idStr = request.getParameter("id");
    }
    String keyWord = request.getParameter("keyWord");
    String backUrl = "SearchUI6.jsp";
    if (keyWord != null && !keyWord.trim().isEmpty()) {
        backUrl = "SearchUI6.jsp?keyWord=" + URLEncoder.encode(keyWord.trim(), "UTF-8");
    }

    int sparePartId = -1;
    if (idStr != null && !idStr.trim().isEmpty()) {
        try {
            sparePartId = Integer.parseInt(idStr.trim());
        } catch (Exception e) {
            sparePartId = -1;
        }
    }

    SparePart6 sp = null;
    if (sparePartId > 0) {
        SparePart6DAO dao = new SparePart6DAO();
        sp = dao.getSparePartDetail(sparePartId);
    }
    DecimalFormat df = new DecimalFormat("#,##0");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết phụ tùng</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container" style="max-width: 750px;">
        <div class="window-card">
            <div class="window-header">
                <h2>Chi tiết phụ tùng</h2>
            </div>
            
            <div class="window-body">
                <% if (sp == null) { %>
                    <div style="padding: 24px; color: #DC2626; text-align: center;">
                        Không tìm thấy phụ tùng hợp lệ<%= (idStr != null && !idStr.trim().isEmpty()) ? " (mã yêu cầu: " + idStr.trim() + ")" : "" %>.
                    </div>
                <% } else { %>
                    <table class="detail-table">
                        <tbody>
                            <tr>
                                <th style="width: 200px;">ID phụ tùng:</th>
                                <td><%= sp.getCode() %></td>
                            </tr>
                            <tr>
                                <th>Tên phụ tùng:</th>
                                <td><strong style="font-size: 1.1rem;"><%= sp.getName() %></strong></td>
                            </tr>
                            <tr>
                                <th>Nhà sản xuất / Xuất xứ:</th>
                                <td><%= sp.getManufacturer() != null ? sp.getManufacturer() : "Chính hãng" %></td>
                            </tr>
                            <tr>
                                <th>Đơn vị tính:</th>
                                <td><%= sp.getUnit() != null ? sp.getUnit() : "Chiếc" %></td>
                            </tr>
                            <tr>
                                <th>Đơn giá bán:</th>
                                <td><strong style="color: #B91C1C; font-size: 1.1rem;"><%= df.format(sp.getUnitPrice()) %> đ</strong></td>
                            </tr>
                            <tr>
                                <th>Số lượng tồn kho:</th>
                                <td><%= sp.getStockQuantity() %> (<%= sp.getUnit() != null ? sp.getUnit() : "" %>)</td>
                            </tr>
                            <tr>
                                <th>Mô tả kỹ thuật:</th>
                                <td><%= sp.getDesc() != null ? sp.getDesc() : "Đang cập nhật..." %></td>
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
