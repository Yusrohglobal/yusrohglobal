<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.NumberFormat, java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
    <title>Our Granite Products - Yusroh Global</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/style.css?v=3">
</head>
<body>
    <jsp:include page="header.jsp" />
     <div class="page-content">
    <section class="page-hero">
        <div class="container">
            <h1>Our Granite Products</h1>
            <p>Premium quarry-direct granite. 40 tons per trip. Same-day delivery in Lagos & Ogun.</p>
        </div>
    </section>
    
    <section class="products-section">
        <div class="container">
            <div class="section-header">
                <h2>Select Your Grade</h2>
                <p>All prices per ton. Update live from our database.</p>
            </div>
            
            <div class="product-grid">
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    NumberFormat naira = NumberFormat.getCurrencyInstance(new Locale("en", "NG"));
                    
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yusrohglobal", "root", "");
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM products WHERE is_active = 1 ORDER BY id");
                        
                        while(rs.next()) {
                %>
                            <div class="product-card">
                                <div class="product-image">
                                    <img src="<%= request.getContextPath() %>/<%= rs.getString("image_path") %>" alt="<%= rs.getString("name") %>" onerror="this.src='<%= request.getContextPath() %>/images/granite.jpg'">
                                    <span class="product-badge"><%= rs.getString("grade") %></span>
                                </div>
                                <div class="product-body">
                                    <h3><%= rs.getString("name") %></h3>
                                    <p class="product-desc"><%= rs.getString("description") %></p>
                                    <div class="product-meta">
                                        <span class="uses-tag">Uses: <%= rs.getString("uses") %></span>
                                    </div>
                                                                       <div class="product-footer" style="display:flex !important; flex-direction:row !important; justify-content:space-between !important; align-items:center !important; gap:10px !important; margin-top:20px !important; padding-top:15px !important; border-top:1px solid #eee !important;">
                                        <div class="price-box" style="display:flex !important; flex-direction:column !important; flex:1 !important;">
                                            <span class="price" style="font-size:18px !important; font-weight:800 !important; color:#2c3e50 !important; display:block !important;"><%= naira.format(rs.getDouble("price")) %></span>
                                            <span class="unit" style="font-size:12px !important; color:#777 !important;">per ton</span>
                                        </div>
                                        <a href="contact.jsp?product=<%= rs.getInt("id") %>" class="btn-order" style="background:#ff6600 !important; color:#fff !important; padding:10px 18px !important; border-radius:6px !important; text-decoration:none !important; font-weight:600 !important; white-space:nowrap !important; flex-shrink:0 !important; display:inline-block !important;">Get Quote</a>
                                    </div>
                                </div>
                            </div>
                <%
                        } // end while
                    } catch(Exception e) {
                        out.println("<div class='error-box'>");
                        out.println("<h3>Could not load products</h3>");
                        out.println("<p>Please refresh or contact support.</p>");
                        out.println("</div>");
                    } finally {
                        try { if(rs != null) rs.close(); } catch(Exception e) {}
                        try { if(stmt != null) stmt.close(); } catch(Exception e) {}
                        try { if(conn != null) conn.close(); } catch(Exception e) {}
                    }
                %>
            </div>
        </div>
    </section>
    
    <section class="cta-banner">
        <div class="container">
            <h3>Need bulk pricing or custom grades?</h3>
            <p>Call us directly for 100+ ton orders and site delivery arrangements.</p>
            <a href="tel:+2348035247317" class="btn-cta">Call +234 803 524 7317</a>
        </div>
    </section>
     </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>