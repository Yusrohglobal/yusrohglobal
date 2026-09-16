<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.text.SimpleDateFormat, java.net.URLEncoder, java.util.*" %>
<%
    // --- CONFIG ---
    String adminPass = "yusroh2026";
    String dbUser = "root";   
    String dbPass = "";       
    String dbUrl = "jdbc:mysql://localhost:3306/yusrohglobal";
    
    // --- LOGIN ---
    String sessionPass = (String) session.getAttribute("admin_auth");
    
    if("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("login") != null) {
        if(adminPass.equals(request.getParameter("password"))) {
            session.setAttribute("admin_auth", adminPass);
            response.sendRedirect("admin.jsp");
            return;
        } else {
            request.setAttribute("loginError", "Wrong password");
        }
    }
    
    if(request.getParameter("logout") != null) {
        session.removeAttribute("admin_auth");
        response.sendRedirect("admin.jsp");
        return;
    }
    
    if(!adminPass.equals(sessionPass)) {
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - Yusroh Global</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { font-family: -apple-system, sans-serif; background: #f8f9fa; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0; }
        .login-box { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); width: 100%; max-width: 400px; }
        .login-box h2 { margin: 0 0 20px; color: #2c3e50; text-align: center; }
        .login-box input { width: 100%; padding: 12px; margin-bottom: 15px; border: 1px solid #ddd; border-radius: 6px; font-size: 15px; box-sizing: border-box; }
        .login-box button { width: 100%; padding: 12px; background: #2c3e50; color: white; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; }
        .error { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 6px; margin-bottom: 15px; text-align: center; }
    </style>
</head>
<body>
    
    <div class="login-box">
        <h2>Yusroh Admin</h2>
        <% if(request.getAttribute("loginError") != null) { %>
            <div class="error"><%= request.getAttribute("loginError") %></div>
        <% } %>
        <form method="POST">
            <input type="password" name="password" placeholder="Enter admin password" required autofocus>
            <input type="hidden" name="login" value="1">
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>
<%
        return;
    }
    
    // --- PARAMS ---
    String tab = request.getParameter("tab") != null ? request.getParameter("tab") : "inquiries";
    String searchTerm = request.getParameter("search") != null ? request.getParameter("search").trim() : "";
    String dateFrom = request.getParameter("date_from") != null ? request.getParameter("date_from") : "";
    String dateTo = request.getParameter("date_to") != null ? request.getParameter("date_to") : "";
    String statusFilter = request.getParameter("status") != null ? request.getParameter("status") : "";
    String editId = request.getParameter("edit");
    String editHaulId = request.getParameter("edit_haul");
    
    // --- POST ACTIONS ---
    if("POST".equalsIgnoreCase(request.getMethod())) {
        Connection connPost = null;
        PreparedStatement psPost = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connPost = DriverManager.getConnection(dbUrl, dbUser, dbPass);
            
            if(request.getParameter("update_inquiry") != null) {
                psPost = connPost.prepareStatement("UPDATE inquiries SET customer_name=?, phone=?, email=?, location=?, message=?, status=?, product_id=? WHERE id=?");
                psPost.setString(1, request.getParameter("customer_name"));
                psPost.setString(2, request.getParameter("phone"));
                psPost.setString(3, request.getParameter("email"));
                psPost.setString(4, request.getParameter("location"));
                psPost.setString(5, request.getParameter("message"));
                psPost.setString(6, request.getParameter("status"));
                psPost.setInt(7, Integer.parseInt(request.getParameter("product_id")));
                psPost.setInt(8, Integer.parseInt(request.getParameter("inquiry_id")));
                psPost.executeUpdate();
            } else if(request.getParameter("update_haulage") != null) {
                psPost = connPost.prepareStatement("UPDATE haulage_requests SET customer_name=?, phone=?, pickup_location=?, dropoff_location=?, material_type=?, tons=?, notes=?, status=?, estimated_cost=? WHERE id=?");
                psPost.setString(1, request.getParameter("customer_name"));
                psPost.setString(2, request.getParameter("phone"));
                psPost.setString(3, request.getParameter("pickup_location"));
                psPost.setString(4, request.getParameter("dropoff_location"));
                psPost.setString(5, request.getParameter("material_type"));
                psPost.setInt(6, Integer.parseInt(request.getParameter("tons")));
                psPost.setString(7, request.getParameter("notes"));
                psPost.setString(8, request.getParameter("status"));
                psPost.setDouble(9, Double.parseDouble(request.getParameter("estimated_cost")));
                psPost.setInt(10, Integer.parseInt(request.getParameter("haulage_id")));
                psPost.executeUpdate();
            } else if(request.getParameter("mark_done") != null) {
                String table = "haulage".equals(tab) ? "haulage_requests" : "inquiries";
                psPost = connPost.prepareStatement("UPDATE " + table + " SET status = 'Done' WHERE id = ?");
                psPost.setInt(1, Integer.parseInt(request.getParameter("item_id")));
                psPost.executeUpdate();
            } else if(request.getParameter("delete") != null) {
                String table = "haulage".equals(tab) ? "haulage_requests" : "inquiries";
                psPost = connPost.prepareStatement("DELETE FROM " + table + " WHERE id = ?");
                psPost.setInt(1, Integer.parseInt(request.getParameter("item_id")));
                psPost.executeUpdate();
            }
        } catch(Exception e) {
            // silent
        } finally {
            try { if(psPost != null) psPost.close(); } catch(Exception e) {}
            try { if(connPost != null) connPost.close(); } catch(Exception e) {}
        }
        response.sendRedirect("admin.jsp?tab=" + tab);
        return;
    }
    
    // --- LOAD DATA ---
    List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
    Map<String,Object> editData = null;
    List<Map<String,Object>> products = new ArrayList<Map<String,Object>>();
    int totalInq = 0, newInq = 0, doneInq = 0;
    
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        
        // Stats
        String table = "haulage".equals(tab) ? "haulage_requests" : "inquiries";
        ps = conn.prepareStatement("SELECT COUNT(*) as total, SUM(status='New') as new_count, SUM(status='Done') as done_count FROM " + table);
        rs = ps.executeQuery();
        if(rs.next()) {
            totalInq = rs.getInt("total");
            newInq = rs.getInt("new_count");
            doneInq = rs.getInt("done_count");
        }
        rs.close();
        ps.close();
        
        // Products
        ps = conn.prepareStatement("SELECT id, name, grade FROM products WHERE is_active = 1");
        rs = ps.executeQuery();
        while(rs.next()) {
            Map<String,Object> p = new HashMap<String,Object>();
            p.put("id", rs.getInt("id"));
            p.put("name", rs.getString("name"));
            p.put("grade", rs.getString("grade"));
            products.add(p);
        }
        rs.close();
        ps.close();
        
        // Edit data
        if(editId != null) {
            ps = conn.prepareStatement("SELECT * FROM inquiries WHERE id = ?");
            ps.setInt(1, Integer.parseInt(editId));
            rs = ps.executeQuery();
            if(rs.next()) {
                editData = new HashMap<String,Object>();
                editData.put("id", rs.getInt("id"));
                editData.put("customer_name", rs.getString("customer_name"));
                editData.put("phone", rs.getString("phone"));
                editData.put("email", rs.getString("email"));
                editData.put("location", rs.getString("location"));
                editData.put("message", rs.getString("message"));
                editData.put("status", rs.getString("status"));
                editData.put("product_id", rs.getInt("product_id"));
            }
            rs.close();
            ps.close();
        }
        
        if(editHaulId != null) {
            ps = conn.prepareStatement("SELECT * FROM haulage_requests WHERE id = ?");
            ps.setInt(1, Integer.parseInt(editHaulId));
            rs = ps.executeQuery();
            if(rs.next()) {
                editData = new HashMap<String,Object>();
                editData.put("id", rs.getInt("id"));
                editData.put("customer_name", rs.getString("customer_name"));
                editData.put("phone", rs.getString("phone"));
                editData.put("pickup_location", rs.getString("pickup_location"));
                editData.put("dropoff_location", rs.getString("dropoff_location"));
                editData.put("material_type", rs.getString("material_type"));
                editData.put("tons", rs.getInt("tons"));
                editData.put("notes", rs.getString("notes"));
                editData.put("status", rs.getString("status"));
                editData.put("estimated_cost", rs.getDouble("estimated_cost"));
            }
            rs.close();
            ps.close();
        }
        
        // Main list
        StringBuilder sql = new StringBuilder();
        if("haulage".equals(tab)) {
            sql.append("SELECT * FROM haulage_requests WHERE 1=1 ");
            if(!searchTerm.isEmpty()) sql.append("AND (customer_name LIKE ? OR phone LIKE ? OR pickup_location LIKE ? OR dropoff_location LIKE ?) ");
        } else {
            sql.append("SELECT i.*, p.name as product_name, p.grade FROM inquiries i LEFT JOIN products p ON i.product_id = p.id WHERE 1=1 ");
            if(!searchTerm.isEmpty()) sql.append("AND (i.customer_name LIKE ? OR i.phone LIKE ? OR i.location LIKE ?) ");
        }
        
        if(!dateFrom.isEmpty()) sql.append("AND DATE(created_at) >= ? ");
        if(!dateTo.isEmpty()) sql.append("AND DATE(created_at) <= ? ");
        if(!statusFilter.isEmpty()) sql.append("AND status = ? ");
        sql.append("ORDER BY created_at DESC");
        
        ps = conn.prepareStatement(sql.toString());
        int paramIdx = 1;
        if(!searchTerm.isEmpty()) {
            String like = "%" + searchTerm + "%";
            ps.setString(paramIdx++, like);
            ps.setString(paramIdx++, like);
            ps.setString(paramIdx++, like);
            if("haulage".equals(tab)) ps.setString(paramIdx++, like);
        }
        if(!dateFrom.isEmpty()) ps.setString(paramIdx++, dateFrom);
        if(!dateTo.isEmpty()) ps.setString(paramIdx++, dateTo);
        if(!statusFilter.isEmpty()) ps.setString(paramIdx++, statusFilter);
        
        rs = ps.executeQuery();
        while(rs.next()) {
            Map<String,Object> row = new HashMap<String,Object>();
            row.put("id", rs.getInt("id"));
            row.put("created_at", rs.getTimestamp("created_at"));
            row.put("customer_name", rs.getString("customer_name"));
            row.put("phone", rs.getString("phone"));
            row.put("status", rs.getString("status"));
            
            if("haulage".equals(tab)) {
                row.put("pickup_location", rs.getString("pickup_location"));
                row.put("dropoff_location", rs.getString("dropoff_location"));
                row.put("material_type", rs.getString("material_type"));
                row.put("tons", rs.getInt("tons"));
                row.put("estimated_cost", rs.getDouble("estimated_cost"));
            } else {
                row.put("email", rs.getString("email"));
                row.put("product_name", rs.getString("product_name"));
                row.put("grade", rs.getString("grade"));
                row.put("location", rs.getString("location"));
                row.put("message", rs.getString("message"));
            }
            dataList.add(row);
        }
        
    } catch(Exception e) {
        out.println("<!-- DB Error: " + e.getMessage() + " -->");
    } finally {
        try { if(rs != null) rs.close(); } catch(Exception e) {}
        try { if(ps != null) ps.close(); } catch(Exception e) {}
        try { if(conn != null) conn.close(); } catch(Exception e) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Yusroh Global</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <style>
        :root { --primary: #2c3e50; --accent: #ff9800; --success: #27ae60; --danger: #e74c3c; --info: #3498db; --light: #f8f9fa; --border: #e1e8ed; }
        body { background: #f4f6f9; }
        .admin-wrapper { padding: 30px 0 60px; }
        .admin-header { background: linear-gradient(135deg, var(--primary) 0%, #34495e 100%); color: white; padding: 30px; border-radius: 12px; margin-bottom: 25px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 20px; }
        .admin-header h1 { margin: 0 0 5px; font-size: 28px; }
        .admin-header p { margin: 0; opacity: 0.9; font-size: 15px; }
        .admin-actions { display: flex; gap: 12px; }
        .btn { padding: 10px 20px; text-decoration: none; border-radius: 8px; font-weight: 600; border: none; cursor: pointer; font-size: 14px; }
        .btn-logout { background: rgba(231, 76, 60, 0.9); color: white; }
        .tab-nav { display: flex; gap: 10px; margin-bottom: 25px; background: white; padding: 10px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); }
        .tab-btn { padding: 12px 28px; border: none; background: transparent; border-radius: 8px; font-weight: 600; cursor: pointer; color: #666; text-decoration: none; }
        .tab-btn.active { background: var(--primary); color: white; }
        .stats-row { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 25px; }
        .stat-card { background: white; padding: 20px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); border-left: 4px solid var(--accent); }
        .stat-card h4 { margin: 0 0 8px; font-size: 13px; color: #7f8c8d; text-transform: uppercase; letter-spacing: 0.5px; }
        .stat-card .num { font-size: 28px; font-weight: 700; color: var(--primary); }
        .filter-box { background: white; padding: 25px; border-radius: 12px; margin-bottom: 25px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); }
        .filter-form { display: grid; grid-template-columns: 2fr 1fr 1fr 1fr auto auto; gap: 15px; align-items: end; }
        .filter-group label { display: block; font-size: 12px; font-weight: 700; margin-bottom: 6px; color: #555; text-transform: uppercase; }
        .filter-group input, .filter-group select { width: 100%; padding: 11px; border: 1px solid var(--border); border-radius: 8px; font-size: 14px; box-sizing: border-box; }
        .btn-filter { background: var(--success); color: white; }
        .btn-clear { background: #95a5a6; color: white; text-align: center; }
        .edit-modal { background: white; padding: 35px; border-radius: 12px; margin-bottom: 25px; box-shadow: 0 8px 25px rgba(0,0,0,0.12); border-top: 4px solid var(--accent); }
        .edit-modal h3 { margin: 0 0 25px; color: var(--primary); font-size: 22px; }
        .edit-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 18px; }
        .edit-group { margin-bottom: 18px; }
        .edit-group label { display: block; font-size: 13px; font-weight: 600; margin-bottom: 6px; color: #555; }
        .edit-group input, .edit-group select, .edit-group textarea { width: 100%; padding: 11px; border: 1px solid var(--border); border-radius: 8px; font-size: 14px; box-sizing: border-box; font-family: inherit; }
        .edit-actions { display: flex; gap: 12px; margin-top: 25px; }
        .btn-save { background: var(--success); color: white; padding: 12px 28px; }
        .btn-cancel { background: #95a5a6; color: white; padding: 12px 28px; text-align: center; }
        .table-wrapper { background: white; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); overflow: hidden; }
        .admin-table { width: 100%; border-collapse: collapse; font-size: 14px; }
        .admin-table th { background: var(--primary); color: white; padding: 16px 12px; text-align: left; font-weight: 600; font-size: 13px; text-transform: uppercase; }
        .admin-table td { padding: 16px 12px; border-bottom: 1px solid #f1f3f5; vertical-align: middle; }
        .admin-table tr:last-child td { border-bottom: none; }
        .admin-table tr:hover { background: #fafbfc; }
        .admin-table a { color: var(--info); text-decoration: none; font-weight: 500; }
        .status-new { background: #fff4e6; color: #d35400; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 700; }
        .status-done { background: #e8f8f0; color: #1e8449; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 700; }
        .action-buttons { display: flex; gap: 8px; flex-wrap: wrap; }
        .btn-edit { background: var(--accent); color: white; }
        .btn-done { background: var(--success); color: white; }
        .btn-delete { background: var(--danger); color: white; }
        .msg-cell { max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color: #666; }
        .results-count { margin: 20px 0 0; color: #7f8c8d; font-size: 14px; text-align: right; }
        @media (max-width: 1100px) { .filter-form { grid-template-columns: 1fr 1fr; } .edit-grid { grid-template-columns: 1fr; } }
        @media (max-width: 768px) { .admin-header { padding: 20px; } .filter-form { grid-template-columns: 1fr; } .admin-table { font-size: 12px; } .tab-nav { flex-direction: column; } }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container admin-wrapper">
        <div class="admin-header">
            <div>
                <h1>Admin Dashboard</h1>
                <p>Manage granite orders and haulage requests</p>
            </div>
            <div class="admin-actions">
                <a href="admin.jsp?logout=1" class="btn btn-logout">Logout</a>
            </div>
        </div>
        
        <div class="tab-nav">
            <a href="admin.jsp?tab=inquiries" class="tab-btn <%= "inquiries".equals(tab) ? "active" : "" %>">Granite Inquiries</a>
            <a href="admin.jsp?tab=haulage" class="tab-btn <%= "haulage".equals(tab) ? "active" : "" %>">Haulage Requests</a>
        </div>
        
        <div class="stats-row">
            <div class="stat-card">
                <h4>Total <%= "haulage".equals(tab) ? "Haulage" : "Inquiries" %></h4>
                <div class="num"><%= totalInq %></div>
            </div>
            <div class="stat-card" style="border-left-color: #e67e22;">
                <h4>New Leads</h4>
                <div class="num"><%= newInq %></div>
            </div>
            <div class="stat-card" style="border-left-color: #27ae60;">
                <h4>Completed</h4>
                <div class="num"><%= doneInq %></div>
            </div>
        </div>
        
        <% if(editData != null) { %>
        <div class="edit-modal">
            <h3>Edit <%= "haulage".equals(tab) ? "Haulage Request" : "Inquiry" %> #<%= editData.get("id") %></h3>
            <form method="POST">
                <% if("haulage".equals(tab)) { %>
                    <input type="hidden" name="haulage_id" value="<%= editData.get("id") %>">
                    <input type="hidden" name="update_haulage" value="1">
                    <div class="edit-grid">
                        <div class="edit-group">
                            <label>Customer Name *</label>
                            <input type="text" name="customer_name" value="<%= editData.get("customer_name") %>" required>
                        </div>
                        <div class="edit-group">
                            <label>Phone *</label>
                            <input type="text" name="phone" value="<%= editData.get("phone") %>" required>
                        </div>
                        <div class="edit-group">
                            <label>Pickup Location *</label>
                            <input type="text" name="pickup_location" value="<%= editData.get("pickup_location") %>" required>
                        </div>
                        <div class="edit-group">
                            <label>Dropoff Location *</label>
                            <input type="text" name="dropoff_location" value="<%= editData.get("dropoff_location") %>" required>
                        </div>
                        <div class="edit-group">
                            <label>Material Type</label>
                            <input type="text" name="material_type" value="<%= editData.get("material_type") %>">
                        </div>
                        <div class="edit-group">
                            <label>Tons</label>
                            <input type="number" name="tons" value="<%= editData.get("tons") %>" required>
                        </div>
                        <div class="edit-group">
                            <label>Estimated Cost</label>
                            <input type="number" step="0.01" name="estimated_cost" value="<%= editData.get("estimated_cost") %>" required>
                        </div>
                        <div class="edit-group">
                            <label>Status</label>
                            <select name="status">
                                <option value="New" <%= "New".equals(editData.get("status")) ? "selected" : "" %>>New</option>
                                <option value="Done" <%= "Done".equals(editData.get("status")) ? "selected" : "" %>>Done</option>
                            </select>
                        </div>
                    </div>
                    <div class="edit-group">
                        <label>Notes</label>
                        <textarea name="notes" rows="3"><%= editData.get("notes") != null ? editData.get("notes") : "" %></textarea>
                    </div>
                <% } else { %>
                    <input type="hidden" name="inquiry_id" value="<%= editData.get("id") %>">
                    <input type="hidden" name="update_inquiry" value="1">
                    <div class="edit-grid">
                        <div class="edit-group">
                            <label>Customer Name *</label>
                            <input type="text" name="customer_name" value="<%= editData.get("customer_name") %>" required>
                        </div>
                        <div class="edit-group">
                            <label>Phone *</label>
                            <input type="text" name="phone" value="<%= editData.get("phone") %>" required>
                        </div>
                        <div class="edit-group">
                            <label>Email</label>
                            <input type="email" name="email" value="<%= editData.get("email") != null ? editData.get("email") : "" %>">
                        </div>
                        <div class="edit-group">
                            <label>Product</label>
                            <select name="product_id" required>
                                <% for(Map<String,Object> p : products) { %>
                                    <option value="<%= p.get("id") %>" <%= p.get("id").equals(editData.get("product_id")) ? "selected" : "" %>><%= p.get("name") %> - <%= p.get("grade") %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="edit-group">
                            <label>Location *</label>
                            <input type="text" name="location" value="<%= editData.get("location") %>" required>
                        </div>
                        <div class="edit-group">
                            <label>Status</label>
                            <select name="status">
                                <option value="New" <%= "New".equals(editData.get("status")) ? "selected" : "" %>>New</option>
                                <option value="Done" <%= "Done".equals(editData.get("status")) ? "selected" : "" %>>Done</option>
                            </select>
                        </div>
                    </div>
                    <div class="edit-group">
                        <label>Message</label>
                        <textarea name="message" rows="3"><%= editData.get("message") != null ? editData.get("message") : "" %></textarea>
                    </div>
                <% } %>
                <div class="edit-actions">
                    <button type="submit" class="btn btn-save">Save Changes</button>
                    <a href="admin.jsp?tab=<%= tab %>" class="btn btn-cancel">Cancel</a>
                </div>
            </form>
        </div>
        <% } %>
        
        <div class="filter-box">
            <form method="GET" class="filter-form">
                <input type="hidden" name="tab" value="<%= tab %>">
                <div class="filter-group">
                    <label>Search Name / Phone / Location</label>
                    <input type="text" name="search" value="<%= searchTerm %>" placeholder="e.g. John or 0803">
                </div>
                <div class="filter-group">
                    <label>From Date</label>
                    <input type="date" name="date_from" value="<%= dateFrom %>">
                </div>
                <div class="filter-group">
                    <label>To Date</label>
                    <input type="date" name="date_to" value="<%= dateTo %>">
                </div>
                <div class="filter-group">
                    <label>Status</label>
                    <select name="status">
                        <option value="">All</option>
                        <option value="New" <%= "New".equals(statusFilter) ? "selected" : "" %>>New</option>
                        <option value="Done" <%= "Done".equals(statusFilter) ? "selected" : "" %>>Done</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-filter">Filter</button>
                <a href="admin.jsp?tab=<%= tab %>" class="btn btn-clear">Clear</a>
            </form>
        </div>
        
        <div class="table-wrapper">
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Date</th>
                        <th>Customer</th>
                        <th>Phone</th>
                        <% if("haulage".equals(tab)) { %>
                            <th>Route</th>
                            <th>Material</th>
                            <th>Est. Cost</th>
                        <% } else { %>
                            <th>Product</th>
                            <th>Location</th>
                            <th>Message</th>
                        <% } %>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if(dataList.isEmpty()) { %>
                        <tr><td colspan="9" style="text-align:center; padding:40px;">No records found.</td></tr>
                    <% } else { 
                        for(Map<String,Object> row : dataList) {
                            boolean isDone = "Done".equals(row.get("status"));
                    %>
                                <tr>
                                    <td>#<%= row.get("id") %></td>
                                    <td><%= row.get("created_at") %></td>
                                    <td><strong><%= row.get("customer_name") %></strong>
                                        <% if(!"haulage".equals(tab)) { %>
                                            <br><small><%= row.get("email") %></small>
                                        <% } %>
                                    </td>
                                    <td><a href="tel:<%= row.get("phone") %>"><%= row.get("phone") %></a></td>
                                    <% if("haulage".equals(tab)) { %>
                                        <td><small><%= row.get("pickup_location") %> → <%= row.get("dropoff_location") %></small></td>
                                        <td><%= row.get("material_type") %> - <%= row.get("tons") %>t</td>
                                        <td>₦<%= String.format("%,.0f", (Double)row.get("estimated_cost")) %></td>
                                    <% } else { %>
                                        <td><%= row.get("product_name") != null ? row.get("product_name") + " - " + row.get("grade") : "N/A" %></td>
                                        <td><%= row.get("location") %></td>
                                        <td class="msg-cell" title="<%= row.get("message") %>"><%= row.get("message") %></td>
                                    <% } %>
                                    <td><span class="<%= isDone ? "status-done" : "status-new" %>"><%= row.get("status") %></span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <% if("haulage".equals(tab)) { %>
                                                <a href="admin.jsp?tab=haulage&edit_haul=<%= row.get("id") %>" class="btn btn-edit">Edit</a>
                                            <% } else { %>
                                                <a href="admin.jsp?tab=inquiries&edit=<%= row.get("id") %>" class="btn btn-edit">Edit</a>
                                            <% } %>
                                            <% if(!isDone) { %>
                                                <form method="POST" style="margin:0;">
                                                    <input type="hidden" name="item_id" value="<%= row.get("id") %>">
                                                    <input type="hidden" name="mark_done" value="1">
                                                    <input type="hidden" name="tab" value="<%= tab %>">
                                                    <button type="submit" class="btn btn-done">Done</button>
                                                </form>
                                            <% } %>
                                            <form method="POST" style="margin:0;" onsubmit="return confirm('Delete #<%= row.get("id") %>? Cannot undo.');">
                                                <input type="hidden" name="item_id" value="<%= row.get("id") %>">
                                                <input type="hidden" name="delete" value="1">
                                                <input type="hidden" name="tab" value="<%= tab %>">
                                                <button type="submit" class="btn btn-delete">Del</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                    <%
                        }
                    }
                    %>
                </tbody>
            </table>
        </div>
        <p class="results-count">Showing <%= dataList.size() %> result<%= dataList.size()%>