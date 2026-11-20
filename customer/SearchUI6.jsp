<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Member6, dao.Service6DAO, dao.SparePart6DAO, model.Service6, model.SparePart6, java.util.List, java.text.DecimalFormat, java.net.URLEncoder" %>
<%
    Member6 currentUser = (Member6) session.getAttribute("user");
    if (currentUser == null || !"Customer".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect("../index.jsp");
        return;
    }
    request.setCharacterEncoding("UTF-8");
    String keyWord = request.getParameter("keyWord");
    boolean isSubmitted = (keyWord != null);
    boolean isEmptyKeyword = (isSubmitted && keyWord.trim().isEmpty());
    boolean hasSearched = (isSubmitted && !keyWord.trim().isEmpty());

    List<Service6> svcList = null;
    List<SparePart6> spList = null;
    String encodedKw = "";

    if (hasSearched) {
        String trimmedKw = keyWord.trim();
        encodedKw = URLEncoder.encode(trimmedKw, "UTF-8");
        Service6DAO svcDAO = new Service6DAO();
        SparePart6DAO spDAO = new SparePart6DAO();
        svcList = svcDAO.searchService(trimmedKw);
        spList = spDAO.searchSparePart(trimmedKw);
    }
    DecimalFormat df = new DecimalFormat("#,##0");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm kiếm thông tin dịch vụ &amp; phụ tùng</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <div class="window-card">
            <div class="window-header">
                <h2>Tìm kiếm thông tin dịch vụ &amp; phụ tùng</h2>
            </div>
            
            <div class="window-body">
                <% if (isEmptyKeyword) { %>
                    <div style="background: #FEE2E2; border: 1px solid #F87171; color: #B91C1C; padding: 12px 16px; border-radius: 6px; margin-bottom: 18px; font-size: 0.95rem;">
                        ⚠️ Vui lòng nhập từ khóa tìm kiếm trước khi nhấn nút <strong>Tìm kiếm</strong>!
                    </div>
                <% } %>

                <!-- Thanh tim kiem: Khong dien truoc tu khoa -->
                <form action="SearchUI6.jsp" method="get">
                    <div class="search-box">
                        <label for="keyWord">Từ khóa:</label>
                        <input type="text" id="keyWord" name="keyWord" value="<%= hasSearched ? keyWord.trim() : "" %>" placeholder="Nhập từ khóa tìm kiếm (ví dụ: Dầu, phanh, lốp...)" required>
                        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                    </div>
                </form>

                <!-- Bang ket qua tim kiem gop duy nhat (100% khop final.docx Hinh 13) -->
                <div class="section-title">
                    Danh sách kết quả tìm kiếm phù hợp:
                </div>

                <table class="data-table">
                    <thead>
                        <tr>
                            <th style="width: 60px;" class="text-center">TT</th>
                            <th style="width: 120px;" class="text-center">Mã DV/PT</th>
                            <th>Tên dịch vụ / phụ tùng</th>
                            <th style="width: 180px;" class="text-right">Đơn giá tham khảo</th>
                            <th style="width: 120px;" class="text-center">Loại</th>
                            <th style="width: 130px;" class="text-center">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        if (!hasSearched) {
                    %>
                        <tr>
                            <td colspan="6" class="text-center" style="padding: 28px; color: #64748B;">
                                Vui lòng nhập từ khóa và nhấn <strong>Tìm kiếm</strong> để xem danh sách dịch vụ và phụ tùng.
                            </td>
                        </tr>
                    <%
                        } else if ((svcList == null || svcList.isEmpty()) && (spList == null || spList.isEmpty())) {
                    %>
                        <tr>
                            <td colspan="6" class="text-center" style="padding: 24px; color: #64748B;">
                                Không tìm thấy dịch vụ hoặc phụ tùng nào phù hợp với từ khóa "<strong><%= keyWord.trim() %></strong>".
                            </td>
                        </tr>
                    <%
                        } else {
                            int idx = 1;
                            // 1. Danh sach dich vu
                            if (svcList != null) {
                                for (Service6 s : svcList) {
                    %>
                        <tr>
                            <td class="text-center"><%= idx++ %></td>
                            <td class="text-center"><%= s.getCode() %></td>
                            <td><%= s.getName() %></td>
                            <td class="text-right"><%= df.format(s.getPrice()) %> đ</td>
                            <td class="text-center">Dịch vụ</td>
                            <td class="text-center">
                                <a href="ServiceDetailUI6.jsp?serviceId=<%= s.getId() %>&keyWord=<%= encodedKw %>" class="btn-action">Chi tiết</a>
                            </td>
                        </tr>
                    <%
                                }
                            }
                            // 2. Danh sach phu tung
                            if (spList != null) {
                                for (SparePart6 sp : spList) {
                    %>
                        <tr>
                            <td class="text-center"><%= idx++ %></td>
                            <td class="text-center"><%= sp.getCode() %></td>
                            <td><%= sp.getName() %></td>
                            <td class="text-right"><%= df.format(sp.getUnitPrice()) %> đ</td>
                            <td class="text-center">Phụ tùng</td>
                            <td class="text-center">
                                <a href="SparePartDetailUI6.jsp?sparePartId=<%= sp.getId() %>&keyWord=<%= encodedKw %>" class="btn-action">Chi tiết</a>
                            </td>
                        </tr>
                    <%
                                }
                            }
                        }
                    %>
                    </tbody>
                </table>

                <div style="margin-top: 24px; border-top: 1px solid #E5E7EB; padding-top: 16px;">
                    <a href="MainUI6.jsp" class="btn btn-secondary">Quay lại</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
