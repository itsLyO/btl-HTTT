<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Member6, dao.Invoice6DAO, model.Invoice6, model.ReceptionSlip6, model.ServiceAssignment6, model.UsedSparePart6, java.util.List, java.text.SimpleDateFormat, java.text.DecimalFormat" %>
<%
    Member6 currentUser = (Member6) session.getAttribute("user");
    if (currentUser == null || !"Manager".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect("../index.jsp");
        return;
    }
    request.setCharacterEncoding("UTF-8");
    String slipIdStr = request.getParameter("slipId");
    String custIdStr = request.getParameter("customerId");
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");

    int slipId = -1;
    if (slipIdStr != null && !slipIdStr.trim().isEmpty()) {
        try {
            slipId = Integer.parseInt(slipIdStr.trim());
        } catch (Exception e) {
            slipId = -1;
        }
    }

    Invoice6 inv = null;
    if (slipId > 0) {
        Invoice6DAO dao = new Invoice6DAO();
        inv = dao.getInvoiceDetail(slipId);
    }
    DecimalFormat df = new DecimalFormat("#,##0");
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

    ReceptionSlip6 slip = (inv != null) ? inv.getReceptionSlip() : null;
    String staffName = (inv != null && inv.getSalesStaff() != null && inv.getSalesStaff().getFullName() != null && !inv.getSalesStaff().getFullName().getFullName().isEmpty()) 
                       ? inv.getSalesStaff().getFullName().getFullName() : "Chưa cập nhật";
    String custName = (slip != null && slip.getCustomer() != null && slip.getCustomer().getFullName() != null && !slip.getCustomer().getFullName().getFullName().isEmpty())
                      ? slip.getCustomer().getFullName().getFullName() : "Chưa cập nhật";
    String carInfo = (slip != null && slip.getCar() != null && slip.getCar().getPlateNumber() != null)
                     ? slip.getCar().getBrand() + " " + slip.getCar().getModel() + " (" + slip.getCar().getPlateNumber() + ")" : "Chưa cập nhật";

    String resolvedCustId = (custIdStr != null && !custIdStr.trim().isEmpty())
                            ? custIdStr.trim()
                            : ((slip != null && slip.getCustomer() != null && slip.getCustomer().getId() > 0)
                                ? String.valueOf(slip.getCustomer().getId()) : "");
    String backUrl = !resolvedCustId.isEmpty()
                     ? "HistoryUI6.jsp?customerId=" + resolvedCustId + "&startDate=" + (startDate != null ? startDate : "") + "&endDate=" + (endDate != null ? endDate : "")
                     : "CustomerStatsUI6.jsp";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết hóa đơn thanh toán</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <div class="window-card">
            <div class="window-header">
                <h2>Chi tiết hóa đơn thanh toán</h2>
            </div>
            
            <div class="window-body">
                <% if (inv == null) { %>
                    <div style="padding: 24px; color: #DC2626; text-align: center;">
                        Không tìm thấy hóa đơn thanh toán gắn với phiếu tiếp nhận<%= (slipIdStr != null && !slipIdStr.trim().isEmpty()) ? " #" + slipIdStr.trim() : "" %>.
                    </div>
                <% } else { %>
                    <div class="info-bar" style="background: #EFF6FF; border: 1px solid #BFDBFE; border-radius: 8px; padding: 14px 18px; margin-bottom: 12px; color: #1E40AF;">
                        <div>Mã HĐ: <%= inv.getInvoiceCode() %> | Ngày thanh toán: <strong><%= inv.getPaymentDate() != null ? sdf.format(inv.getPaymentDate()) : "Chưa cập nhật" %></strong> | Nhân viên bán hàng: <strong><%= staffName %></strong></div>
                    </div>

                    <div style="margin-bottom: 20px; font-size: 0.95rem; color: #374151;">
                        Khách hàng: <strong><%= custName %></strong> | Phiếu: <%= slip.getSlipCode() %> | Xe: <strong><%= carInfo %></strong>
                    </div>

                    <!-- Bang 1: Dich vu sua chua / bao duong -->
                    <div class="section-title" style="margin-top: 18px; font-weight: 700; color: #0F172A;">
                        1. Dịch vụ sửa chữa / bảo dưỡng:
                    </div>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th style="width: 50px;" class="text-center">TT</th>
                                <th style="width: 100px;" class="text-center">Mã DV</th>
                                <th>Tên dịch vụ</th>
                                <th style="width: 180px;" class="text-right">Tiền công</th>
                                <th style="width: 180px;" class="text-center">Kỹ thuật viên</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            List<ServiceAssignment6> saList = slip.getServiceAssignments();
                            if (saList == null || saList.isEmpty()) {
                        %>
                            <tr><td colspan="5" class="text-center text-muted">Không có hạng mục dịch vụ nào.</td></tr>
                        <%
                            } else {
                                int i = 1;
                                for (ServiceAssignment6 sa : saList) {
                                    String svcCode = sa.getService() != null ? sa.getService().getCode() : "";
                                    String svcName = sa.getService() != null ? sa.getService().getName() : "";
                                    String techName = (sa.getTechnician() != null && sa.getTechnician().getFullName() != null)
                                                      ? sa.getTechnician().getFullName().getFullName() : "";
                        %>
                            <tr>
                                <td class="text-center"><%= i++ %></td>
                                <td class="text-center"><%= svcCode %></td>
                                <td><%= svcName %></td>
                                <td class="text-right"><%= df.format(sa.getActualPrice()) %> đ</td>
                                <td class="text-center"><%= techName %></td>
                            </tr>
                        <%
                                }
                            }
                        %>
                        </tbody>
                    </table>

                    <!-- Bang 2: Phu tung linh kien thay the -->
                    <div class="section-title" style="margin-top: 18px; font-weight: 700; color: #0F172A;">
                        2. Phụ tùng linh kiện thay thế:
                    </div>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th style="width: 50px;" class="text-center">TT</th>
                                <th style="width: 100px;" class="text-center">Mã PT</th>
                                <th>Tên phụ tùng</th>
                                <th style="width: 80px;" class="text-center">SL</th>
                                <th style="width: 150px;" class="text-right">Đơn giá</th>
                                <th style="width: 170px;" class="text-right">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            List<UsedSparePart6> uspList = slip.getUsedSpareParts();
                            if (uspList == null || uspList.isEmpty()) {
                        %>
                            <tr><td colspan="6" class="text-center text-muted">Không sử dụng phụ tùng thay thế.</td></tr>
                        <%
                            } else {
                                int j = 1;
                                for (UsedSparePart6 usp : uspList) {
                                    String partCode = usp.getSparePart() != null ? usp.getSparePart().getCode() : "";
                                    String partName = usp.getSparePart() != null ? usp.getSparePart().getName() : "";
                        %>
                            <tr>
                                <td class="text-center"><%= j++ %></td>
                                <td class="text-center"><%= partCode %></td>
                                <td><%= partName %></td>
                                <td class="text-center"><%= usp.getQuantity() %></td>
                                <td class="text-right"><%= df.format(usp.getActualPrice()) %> đ</td>
                                <td class="text-right font-bold"><%= df.format(usp.getSubTotal()) %> đ</td>
                            </tr>
                        <%
                                }
                            }
                        %>
                        </tbody>
                    </table>

                    <!-- Hop tong tien -->
                    <div class="total-box" style="margin-top: 20px; background: #FFFFFF; border: 1px solid #CBD5E1;">
                        <div>
                            <div>Hình thức thanh toán: <strong><%= inv.getPaymentMethod() != null ? inv.getPaymentMethod() : "Chưa cập nhật" %></strong></div>
                            <div style="font-size: 0.85rem; color: #047857; margin-top: 4px;">Ghi chú: <%= inv.getNote() != null ? inv.getNote() : "Đã thanh toán đủ" %></div>
                        </div>
                        <div style="text-align: right;">
                            <div style="font-size: 0.85rem; color: #4B5563; text-transform: uppercase;">TỔNG TIỀN THANH TOÁN</div>
                            <div class="total-amount" style="font-size: 1.4rem; font-weight: 800; color: #B91C1C;"><%= df.format(inv.getTotalAmount()) %> đ</div>
                        </div>
                    </div>
                <% } %>

                <div style="margin-top: 24px; border-top: 1px solid #E5E7EB; padding-top: 16px;">
                    <a href="<%= backUrl %>" class="btn btn-secondary">Quay lại</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
