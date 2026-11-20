<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Member6, dao.CustomerStats6DAO, model.CustomerStats6, java.util.List, java.util.Date, java.text.SimpleDateFormat, java.text.DecimalFormat" %>
<%
    Member6 currentUser = (Member6) session.getAttribute("user");
    if (currentUser == null || !"Manager".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect("../index.jsp");
        return;
    }
    request.setCharacterEncoding("UTF-8");
    String startDateStr = request.getParameter("startDate");
    String endDateStr = request.getParameter("endDate");

    boolean isSubmitted = (startDateStr != null || endDateStr != null);
    String errorMsg = null;
    boolean hasValidFilter = false;

    Date startDate = null;
    Date endDate = null;
    List<CustomerStats6> list = null;

    if (isSubmitted) {
        if (startDateStr == null || startDateStr.trim().isEmpty() ||
            endDateStr == null || endDateStr.trim().isEmpty()) {
            errorMsg = "Vui lòng điền đầy đủ Ngày bắt đầu và Ngày kết thúc thống kê!";
        } else {
            SimpleDateFormat[] sdfs = new SimpleDateFormat[] {
                new SimpleDateFormat("dd-MM-yyyy"),
                new SimpleDateFormat("yyyy-MM-dd"),
                new SimpleDateFormat("dd/MM/yyyy")
            };
            for (SimpleDateFormat sdf : sdfs) {
                sdf.setLenient(false);
                if (startDate == null) {
                    try { startDate = sdf.parse(startDateStr.trim()); } catch (Exception e) {}
                }
                if (endDate == null) {
                    try { endDate = sdf.parse(endDateStr.trim()); } catch (Exception e) {}
                }
            }

            if (startDate == null || endDate == null) {
                errorMsg = "Định dạng thời gian không hợp lệ! Vui lòng nhập theo định dạng dd-MM-yyyy (ví dụ: 01-01-2026).";
            } else if (startDate.after(endDate)) {
                errorMsg = "Ngày bắt đầu không được lớn hơn ngày kết thúc! Vui lòng chọn lại khoảng thời gian hợp lệ.";
            } else {
                hasValidFilter = true;
                CustomerStats6DAO dao = new CustomerStats6DAO();
                list = dao.getCustomerStats(startDate, endDate);
            }
        }
    }

    DecimalFormat df = new DecimalFormat("#,##0");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê KH theo doanh thu</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <div class="window-card">
            <div class="window-header">
                <h2>Thống kê KH theo doanh thu</h2>
            </div>
            
            <div class="window-body">
                <% if (errorMsg != null) { %>
                    <div style="background: #FEE2E2; border: 1px solid #F87171; color: #B91C1C; padding: 12px 16px; border-radius: 6px; margin-bottom: 18px; font-size: 0.95rem;">
                        ⚠️ <%= errorMsg %>
                    </div>
                <% } %>

                <!-- Thanh tim kiem: Khong dien truoc thoi gian -->
                <form action="CustomerStatsUI6.jsp" method="get">
                    <div class="search-box" style="margin-bottom: 20px;">
                        <label for="startDate">Từ ngày:</label>
                        <input type="text" id="startDate" name="startDate" value="<%= startDateStr != null ? startDateStr.trim() : "" %>" placeholder="01-01-2026" style="max-width: 150px;" required>
                        <label for="endDate" style="margin-left: 10px;">Đến:</label>
                        <input type="text" id="endDate" name="endDate" value="<%= endDateStr != null ? endDateStr.trim() : "" %>" placeholder="24-09-2026" style="max-width: 150px;" required>
                        <button type="submit" class="btn btn-primary" style="margin-left: 10px;">Xem thống kê</button>
                    </div>
                </form>

                <table class="data-table">
                    <thead>
                        <tr>
                            <th style="width: 50px;" class="text-center">TT</th>
                            <th style="width: 100px;" class="text-center">Mã KH</th>
                            <th>Tên khách hàng</th>
                            <th style="width: 140px;" class="text-center">Số ĐT</th>
                            <th style="width: 90px;" class="text-center">Số lần</th>
                            <th style="width: 180px;" class="text-right">Doanh thu</th>
                            <th style="width: 100px;" class="text-center">Chi tiết</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        if (!hasValidFilter) {
                    %>
                        <tr>
                            <td colspan="7" class="text-center" style="padding: 28px; color: #64748B;">
                                Vui lòng nhập khoảng thời gian (Từ ngày, Đến) và nhấn <strong>Xem thống kê</strong> để hiển thị báo cáo.
                            </td>
                        </tr>
                    <%
                        } else if (list == null || list.isEmpty()) {
                    %>
                        <tr>
                            <td colspan="7" class="text-center" style="padding: 24px; color: #6B7280;">
                                Không có dữ liệu thống kê trong khoảng thời gian này.
                            </td>
                        </tr>
                    <%
                        } else {
                            int idx = 1;
                            for (CustomerStats6 cs : list) {
                                String code = String.format("KH%03d", cs.getId());
                    %>
                        <tr>
                            <td class="text-center"><%= idx++ %></td>
                            <td class="text-center"><%= code %></td>
                            <td style="font-weight: 600;"><%= cs.getDisplayName() %></td>
                            <td class="text-center"><%= cs.getTel() != null ? cs.getTel() : "" %></td>
                            <td class="text-center"><%= cs.getTotalVisits() %></td>
                            <td class="text-right" style="font-weight: 700; color: #047857;"><%= df.format(cs.getTotalRevenue()) %> đ</td>
                            <td class="text-center">
                                <a href="HistoryUI6.jsp?customerId=<%= cs.getId() %>&startDate=<%= startDateStr.trim() %>&endDate=<%= endDateStr.trim() %>" class="btn-action">Xem</a>
                            </td>
                        </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>

                <div style="margin-top: 24px; border-top: 1px solid #E5E7EB; padding-top: 16px;">
                    <a href="StatsSelectionUI6.jsp" class="btn btn-secondary">Quay lại</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
