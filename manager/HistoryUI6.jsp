<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Member6, dao.ReceptionSlip6DAO, model.ReceptionSlip6, model.Customer6, model.Car6, java.util.List, java.text.SimpleDateFormat, java.text.DecimalFormat" %>
<%
    Member6 currentUser = (Member6) session.getAttribute("user");
    if (currentUser == null || !"Manager".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect("../index.jsp");
        return;
    }
    request.setCharacterEncoding("UTF-8");
    String custIdStr = request.getParameter("customerId");
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");

    int customerId = -1;
    if (custIdStr != null && !custIdStr.trim().isEmpty()) {
        try {
            customerId = Integer.parseInt(custIdStr.trim());
        } catch (Exception e) {
            customerId = -1;
        }
    }

    Customer6 cust = null;
    List<ReceptionSlip6> history = null;
    if (customerId > 0) {
        ReceptionSlip6DAO dao = new ReceptionSlip6DAO();
        cust = dao.getCustomerInfo(customerId);
        if (cust != null) {
            history = dao.getCustomerHistory(customerId);
        }
    }
    DecimalFormat df = new DecimalFormat("#,##0");
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

    String custCode = (cust != null) ? cust.getCustomerCode() : "";
    String custName = (cust != null) ? cust.getDisplayName() : "";
    String custTel = (cust != null && cust.getTel() != null && !cust.getTel().trim().isEmpty()) ? cust.getTel() : "Chưa cập nhật";

    String ownedCarDisplay = "Chưa đăng ký thông tin xe";
    if (cust != null && cust.getCars() != null && !cust.getCars().isEmpty()) {
        StringBuilder sbCars = new StringBuilder();
        for (int i = 0; i < cust.getCars().size(); i++) {
            Car6 c = cust.getCars().get(i);
            if (i > 0) sbCars.append("; ");
            sbCars.append(c.getBrand() != null ? c.getBrand() + " " : "")
                  .append(c.getModel() != null ? c.getModel() : "")
                  .append(" | Biển số: ")
                  .append(c.getPlateNumber() != null ? c.getPlateNumber() : "");
        }
        ownedCarDisplay = sbCars.toString();
    } else if (history != null && !history.isEmpty() && history.get(0).getCar() != null && history.get(0).getCar().getPlateNumber() != null) {
        Car6 c = history.get(0).getCar();
        ownedCarDisplay = (c.getBrand() != null ? c.getBrand() + " " : "")
                        + (c.getModel() != null ? c.getModel() : "")
                        + " | Biển số: "
                        + c.getPlateNumber();
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử sửa xe của khách hàng</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <div class="window-card">
            <div class="window-header">
                <h2>Lịch sử sửa xe của khách hàng</h2>
            </div>
            
            <div class="window-body">
                <% if (cust == null) { %>
                    <div style="padding: 24px; color: #DC2626; text-align: center;">
                        Không tìm thấy thông tin khách hàng hợp lệ<%= (custIdStr != null && !custIdStr.trim().isEmpty()) ? " (mã yêu cầu: " + custIdStr.trim() + ")" : "" %>.
                    </div>
                <% } else { %>
                    <div class="info-bar" style="background: #EFF6FF; border: 1px solid #BFDBFE; border-radius: 8px; padding: 14px 18px; margin-bottom: 18px; color: #1E40AF;">
                        <div style="font-weight: 700;">Khách hàng: <%= custName %> (Mã KH: <%= custCode %>) | SĐT: <%= custTel %></div>
                        <div style="margin-top: 4px; color: #374151;">Xe sở hữu: <strong><%= ownedCarDisplay %></strong></div>
                    </div>

                    <table class="data-table">
                        <thead>
                            <tr>
                                <th style="width: 50px;" class="text-center">TT</th>
                                <th style="width: 110px;" class="text-center">Mã phiếu</th>
                                <th style="width: 120px;" class="text-center">Ngày đến</th>
                                <th style="width: 130px;" class="text-center">Biển số</th>
                                <th style="width: 140px;" class="text-center">Trạng thái</th>
                                <th style="width: 160px;" class="text-right">Tổng tiền</th>
                                <th style="width: 130px;" class="text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            if (history == null || history.isEmpty()) {
                        %>
                            <tr>
                                <td colspan="7" class="text-center" style="padding: 24px; color: #6B7280;">
                                    Khách hàng chưa có lịch sử sửa chữa nào trên hệ thống.
                                </td>
                            </tr>
                        <%
                            } else {
                                int idx = 1;
                                for (ReceptionSlip6 slip : history) {
                                    String plate = (slip.getCar() != null && slip.getCar().getPlateNumber() != null) ? slip.getCar().getPlateNumber() : "";
                                    String statusText = slip.getStatus() != null ? slip.getStatus() : "";
                                    String badgeStyle = "background:#F1F5F9; color:#475569;";
                                    if ("Đã hoàn thành".equalsIgnoreCase(statusText)) {
                                        badgeStyle = "background:#DCFCE7; color:#15803D;";
                                    } else if ("Đang sửa".equalsIgnoreCase(statusText)) {
                                        badgeStyle = "background:#FEF3C7; color:#B45309;";
                                    }
                        %>
                            <tr>
                                <td class="text-center"><%= idx++ %></td>
                                <td class="text-center"><%= slip.getSlipCode() %></td>
                                <td class="text-center"><%= slip.getReceiveDate() != null ? sdf.format(slip.getReceiveDate()) : "" %></td>
                                <td class="text-center"><%= plate %></td>
                                <td class="text-center"><span class="badge-service" style="<%= badgeStyle %> padding: 4px 8px; border-radius: 4px; font-size: 0.85rem; font-weight: 600;"><%= statusText %></span></td>
                                <td class="text-right" style="font-weight: 700; color: #047857;"><%= df.format(slip.getTotalAmount()) %> đ</td>
                                <td class="text-center">
                                    <a href="InvoiceDetailUI6.jsp?slipId=<%= slip.getId() %>&customerId=<%= customerId %>&startDate=<%= startDate != null ? startDate : "" %>&endDate=<%= endDate != null ? endDate : "" %>" class="btn-action">Xem chi tiết</a>
                                </td>
                            </tr>
                        <%
                                }
                            }
                        %>
                        </tbody>
                    </table>
                <% } %>

                <div style="margin-top: 24px; border-top: 1px solid #E5E7EB; padding-top: 16px;">
                    <a href="CustomerStatsUI6.jsp<%= (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) ? "?startDate=" + startDate + "&endDate=" + endDate : "" %>" class="btn btn-secondary">Quay lại</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
