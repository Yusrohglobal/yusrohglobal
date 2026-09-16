<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String phone = request.getParameter("phone");
    List<Map<String,Object>> results = new ArrayList<Map<String,Object>>();
    boolean searched = false;
    String error = null;
    
    if(phone != null && !phone.trim().isEmpty()) {
        searched = true;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yusrohglobal", "root", "");
            
            // Clean phone: remove spaces, dashes
            String cleanPhone = phone.replaceAll("[\\s-]", "");
            
            // Check inquiries
            ps = conn.prepareStatement("SELECT i.id, i.created_at, i.customer_name, i.location, i.status, p.name as product_name, p.grade, 'Granite Order' as type FROM inquiries i LEFT JOIN products p ON i.product_id = p.id WHERE REPLACE(REPLACE(i.phone, ' ', ''), '-', '') LIKE ? ORDER BY i.created_at DESC");
            ps.setString(1, "%" + cleanPhone + "%");
            rs = ps.executeQuery();
            while(rs.next()) {
                Map<String,Object> row = new HashMap<String,Object>();
                row.put("id", rs.getInt("id"));
                row.put("date", rs.getTimestamp("created_at"));
                row.put("name", rs.getString("customer_name"));
                row.put("details", rs.getString("product_name") + " - " + rs.getString("grade") + " to " + rs.getString("location"));
                row.put("status", rs.getString("status"));
                row.put("type", rs.getString("type"));
                results.add(row);
            }
            rs.close();
            ps.close();
            
            // Check haulage
            ps = conn.prepareStatement("SELECT id, created_at, customer_name, pickup_location, dropoff_location, material_type, status, 'Haulage Request' as type FROM haulage_requests WHERE REPLACE(REPLACE(phone, ' ', ''), '-', '') LIKE ? ORDER BY created_at DESC");
            ps.setString(1, "%" + cleanPhone + "%");
            rs = ps.executeQuery();
            while(rs.next()) {
                Map<String,Object> row = new HashMap<String,Object>();
                row.put("id", rs.getInt("id"));
                row.put("date", rs.getTimestamp("created_at"));
                row.put("name", rs.getString("customer_name"));
                row.put("details", rs.getString("material_type") + ": " + rs.getString("pickup_location") + " → " + rs.getString("dropoff_location"));
                row.put("status", rs.getString("status"));
                row.put("type", rs.getString("type"));
                results.add(row);
            }
            
        } catch(Exception e) {
            error = "Error searching. Please call us: +234 803 000 0000";
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(ps != null) ps.close(); } catch(Exception e) {}
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Track Your Order - Yusroh Global</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <style>
        .track-hero { background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%); color: white; padding: 60px 0; text-align: center; }
        .track-hero h1 { margin: 0 0 15px; font-size: 36px; }
        .track-hero p { margin: 0; font-size: 18px; opacity: 0.9; }
        .track-section { padding: 60px 0; background: #f8f9fa; min-height: 50vh; }
        .track-box { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); max-width: 700px; margin: 0 auto; }
        .track-box h2 { margin: 0 0 20px; color: #2c3e50; text-align: center; }
        .track-form { display: flex; gap: 12px; margin-bottom: 30px; }
        .track-form input { flex: 1; padding: 14px; border: 2px solid #e1e8ed; border-radius: 8px; font-size: 16px; }
        .track-form input:focus { outline: none; border-color: #ff9800; }
        .track-form button { padding: 14px 30px; background: #ff9800; color: white; border: none; border-radius: 8px; font-weight: 700; cursor: pointer; font-size: 16px; }
        .track-form button:hover { background: #f57c00; }
        .result-item { background: #f8f9fa; padding: 20px; border-radius: 10px; margin-bottom: 15px; border-left: 4px solid #ff9800; }
        .result-header { display: flex; justify-content: space-between; align-items: start; margin-bottom: 10px; }
        .result-type { font-size: 12px; font-weight: 700; text-transform: uppercase; color: #7f8c8d; letter-spacing: 0.5px; }
        .result-date { font-size: 13px; color: #95a5a6; }
        .result-details { margin: 8px 0; color: #2c3e50; font-size: 15px; line-height: 1.6; }
        .status-badge { display: inline-block; padding: 6px 14px; border-radius: 20px; font-size: 13px; font-weight: 700; }
        .status-new { background: #fff4e6; color: #d35400; }
        .status-done { background: #e8f8f0; color: #1e8449; }
        .no-results { text-align: center; padding: 40px 20px; color: #7f8c8d; }
        .no-results-icon { font-size: 48px; margin-bottom: 15px; }
        .error-box { background: #f8d7da; color: #721c24; padding: 15px; border-radius: 8px; margin-bottom: 20px; text-align: center; }
        @media (max-width: 768px) {
            .track-form { flex-direction: column; }
            .track-box { padding: 25px; }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
     <div class="page-content">
    <section class="track-hero">
        <div class="container">
            <h1>Track Your Order</h1>
            <p>Enter your phone number to see status of granite orders and haulage requests</p>
        </div>
    </section>
    
    <section class="track-section">
        <div class="container">
            <div class="track-box">
                <h2>Check Status</h2>
                
                <% if(error != null) { %>
                    <div class="error-box"><%= error %></div>
                <% } %>
                
                <form method="GET" class="track-form">
                    <input type="tel" name="phone" placeholder="0803 000 0000" value="<%= phone != null ? phone : "" %>" required>
                    <button type="submit">Track</button>
                </form>
                
                <% if(searched) { %>
                    <% if(results.isEmpty()) { %>
                        <div class="no-results">
                            <div class="no-results-icon">📭</div>
                            <h3>No orders found</h3>
                            <p>We couldn't find any orders with that phone number.<br>
                            Call us on <a href="tel:+2348030000000">+234 803 000 0000</a> to check.</p>
                        </div>
                    <% } else { %>
                        <h3 style="margin: 30px 0 20px; color: #2c3e50;">Found <%= results.size() %> result<%= results.size() != 1 ? "s" : "" %>:</h3>
                        <% for(Map<String,Object> r : results) { 
                            boolean isDone = "Done".equals(r.get("status"));
                        %>
                            <div class="result-item">
                                <div class="result-header">
                                    <div>
                                        <div class="result-type"><%= r.get("type") %> #<%= r.get("id") %></div>
                                        <div class="result-date"><%= r.get("date") %></div>
                                    </div>
                                    <span class="status-badge <%= isDone ? "status-done" : "status-new" %>"><%= r.get("status") %></span>
                                </div>
                                <div class="result-details"><%= r.get("details") %></div>
                            </div>
                        <% } %>
                    <% } %>
                <% } %>
            </div>
        </div>
    </section>
</div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>