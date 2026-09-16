<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String msg = "";
    String msgType = "";
    
    // Handle form submission
    if("POST".equalsIgnoreCase(request.getMethod())) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String productId = request.getParameter("product_id");
            String location = request.getParameter("location");
            String message = request.getParameter("message");
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yusrohglobal", "root", "");
            
            String sql = "INSERT INTO inquiries (customer_name, phone, email, product_id, location, message) VALUES (?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setInt(4, productId != null && !productId.isEmpty() ? Integer.parseInt(productId) : 0);
            ps.setString(5, location);
            ps.setString(6, message);
            
            int rows = ps.executeUpdate();
            if(rows > 0) {
                msg = "Thanks! We received your request. We'll call you within an hour.";
                msgType = "success";
            }
            
        } catch(Exception e) {
            msg = "Error submitting form. Please call us directly: +234 803 524 7317";
            msgType = "error";
        } finally {
            try { if(ps != null) ps.close(); } catch(Exception e) {}
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
    
    // Get product ID if user clicked "Get Quote" from products.jsp
    String selectedProduct = request.getParameter("product");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Us - Yusroh Global</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link rel="stylesheet" href="<%=request.getContextPath()%>/style.css?v=3">
</head>
<body>
    <jsp:include page="header.jsp" />
     <div class="page-content">
    <section class="page-hero">
        <div class="container">
            <h1>Get Your Granite Quote</h1>
            <p>Fill the form or call us. We deliver 40 tons per trip across Nigeria.</p>
        </div>
    </section>
    
    <section class="contact-section">
        <div class="container">
            <div class="contact-grid">
                <div class="contact-form-box">
                    <h2>Request Delivery</h2>
                    
                    <% if(!msg.isEmpty()) { %>
                        <div class="alert <%= msgType %>"><%= msg %></div>
                    <% } %>
                    
                    <form method="POST" action="contact.jsp">
                        <div class="form-row">
                            <div class="form-group">
                                <label>Your Name *</label>
                                <input type="text" name="name" required>
                            </div>
                            <div class="form-group">
                                <label>Phone / WhatsApp *</label>
                                <input type="tel" name="phone" placeholder="0803 000 0000" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" name="email">
                            </div>
                            <div class="form-group">
    <label>Product Needed *</label>
    <select name="product_id" required>
        <option value="">-- Select product --</option>
        <%
            Connection connProd = null;
            Statement stmtProd = null;
            ResultSet rsProd = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connProd = DriverManager.getConnection("jdbc:mysql://localhost:3306/yusrohglobal", "root", "");
                stmtProd = connProd.createStatement();
                rsProd = stmtProd.executeQuery("SELECT id, name, grade, price FROM products WHERE is_active = 1 ORDER BY name");
                
                boolean hasProducts = false;
                while(rsProd.next()) {
                    hasProducts = true;
                    String sel = String.valueOf(rsProd.getInt("id")).equals(selectedProduct) ? "selected" : "";
        %>
                    <option value="<%= rsProd.getInt("id") %>" <%= sel %>>
                        <%= rsProd.getString("name") %> - <%= rsProd.getString("grade") %> (₦<%= String.format("%,.0f", rsProd.getDouble("price")) %>/ton)
                    </option>
        <%
                }
                
                if(!hasProducts) {
        %>
                    <option value="" disabled>No products found - check DB</option>
        <%
                }
                
            } catch(Exception e) {
        %>
                <option value="" disabled>Error loading products</option>
        <%
                out.println("<!-- DB Error: " + e.getMessage() + " -->");
            } finally {
                try { if(rsProd != null) rsProd.close(); } catch(Exception e) {}
                try { if(stmtProd != null) stmtProd.close(); } catch(Exception e) {}
                try { if(connProd != null) connProd.close(); } catch(Exception e) {}
            }
        %>
    </select>
</div>

                           
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Delivery Location *</label>
                            <input type="text" name="location" placeholder="e.g. Lekki Phase 1, Ikeja, Mowe" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Message</label>
                            <textarea name="message" rows="4" placeholder="How many tons? When do you need it?"></textarea>
                        </div>
                        
                        <button type="submit" class="btn-submit">Send Request</button>
                    </form>
                </div>
                
                <div class="contact-info-box">
                    <h3>Talk to Us Directly</h3>
                    <div class="info-item">
                        <span class="icon">📞</span>
                        <div>
                            <strong>Call / WhatsApp</strong>
                            <p><a href="tel:+2348035247317">+234 803 524 7317</a></p>
                        </div>
                    </div>
                    <div class="info-item">
                        <span class="icon">✉️</span>
                        <div>
                            <strong>Email</strong>
                            <p><a href="mailto:info@yusrohglobal.com">info@yusrohglobal.com</a></p>
                        </div>
                    </div>
                    <div class="info-item">
                        <span class="icon">📍</span>
                        <div>
                            <strong>Base Location</strong>
                            <p>Ogun State, Nigeria<br>Serving Nigeria</p>
                        </div>
                    </div>
                    <div class="info-item">
                        <span class="icon">⏰</span>
                        <div>
                            <strong>Hours</strong>
                            <p>Mon - Sat: 7am - 6pm<br>Emergency: Call anytime</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
     </div>
     
    <jsp:include page="footer.jsp" />
</body>
</html>