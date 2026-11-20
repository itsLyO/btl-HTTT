<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Member6" %>
<%
    Member6 currentUser = (Member6) session.getAttribute("user");
    if (currentUser == null || !"Manager".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn báo cáo</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container" style="max-width: 650px;">
        <div class="window-card">
            <div class="window-header">
                <h2>Chọn báo cáo</h2>
            </div>
            
            <div class="window-body">
                <form action="CustomerStatsUI6.jsp" method="get" onsubmit="return validateReportType();">
                    <div style="margin: 20px 0 24px 0;">
                        <label for="reportType" style="font-weight: 600; display: block; margin-bottom: 10px; color: #1F2937;">
                            Chọn loại báo cáo thống kê:
                        </label>
                        <select id="reportType" name="reportType" style="width: 100%; padding: 12px 14px; border-radius: 6px; border: 1px solid #CBD5E1; font-size: 1rem; color: #1E3A8A; font-weight: 600; background: #FFFFFF;">
                            <option value="customer_revenue" selected>Khách hàng theo doanh thu</option>
                            <option value="service_revenue">Dịch vụ theo doanh thu</option>
                            <option value="sparepart_revenue">Phụ tùng theo doanh thu</option>
                            <option value="supplier_expense">Nhà cung cấp theo chi phí nhập</option>
                        </select>
                    </div>

                    <div style="display: flex; gap: 12px; align-items: center; border-top: 1px solid #E5E7EB; padding-top: 18px;">
                        <button type="submit" class="btn btn-primary" style="padding: 12px 24px; font-size: 1rem;">
                            Chọn loại thống kê
                        </button>
                        <a href="MainUI6.jsp" class="btn btn-secondary" style="padding: 12px 20px;">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script>
        function validateReportType() {
            var sel = document.getElementById('reportType').value;
            if (sel !== 'customer_revenue') {
                alert('Chức năng thống kê này đang trong giai đoạn phát triển. Vui lòng chọn "Khách hàng theo doanh thu"!');
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
