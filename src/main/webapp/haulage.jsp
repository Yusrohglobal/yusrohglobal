<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String msg = "";
    String msgType = "";
    double estimatedCost = 0;
    boolean showEstimate = false;
    
    if("POST".equalsIgnoreCase(request.getMethod())) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String pickup = request.getParameter("pickup");
            String dropoff = request.getParameter("dropoff");
            String material = request.getParameter("material");
            String tonsStr = request.getParameter("tons");
            String prefDate = request.getParameter("pref_date");
            String notes = request.getParameter("notes");
            
            int tons = 40; // Your trucks are 20 tons
            try { tons = Integer.parseInt(tonsStr); } catch(Exception e) {}
            
            // Simple estimate: Base ₦50,000 + ₦1,500 per km. We'll assume 40km avg for now
            // Real version you'd use Google Maps API. For now, let customer call for exact.
            estimatedCost = 50000 + (tons * 2000); // ₦50k base + ₦2k per ton
            showEstimate = true;
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yusrohglobal", "root", "");
            
            String sql = "INSERT INTO haulage_requests (customer_name, phone, pickup_location, dropoff_location, material_type, tons, preferred_date, notes, estimated_cost) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, pickup);
            ps.setString(4, dropoff);
            ps.setString(5, material);
            ps.setInt(6, tons);
            ps.setString(7, prefDate.isEmpty() ? null : prefDate);
            ps.setString(8, notes);
            ps.setDouble(9, estimatedCost);
            
            int rows = ps.executeUpdate();
            if(rows > 0) {
                msg = "Request received! Estimated cost: ₦" + String.format("%,.0f", estimatedCost) + ". We'll call you in 30 mins to confirm.";
                msgType = "success";
            }
            
        } catch(Exception e) {
            msg = "Error submitting. Call us directly: +234 803 524 7317";
            msgType = "error";
        } finally {
            try { if(ps != null) ps.close(); } catch(Exception e) {}
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>40-Ton Truck Haulage - Yusroh Global</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/style.css?v=5">
    <style>
        .page-hero{ background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%); color:white; padding:60px 15px; text-align:center; }
        .page-hero h1{ font-size:38px; margin:0 0 10px; }
        .haulage-features{ padding:60px 15px; background:#fff; }
        .features-grid{ display:grid; grid-template-columns:repeat(3,1fr); gap:30px; max-width:1200px; margin:0 auto; }
        .feature-card{ text-align:center; padding:30px 20px; background:#f8f9fa; border-radius:12px; border:1px solid #e9ecef; }
        .feature-icon{ font-size:40px; margin-bottom:15px; }
        .contact-section{ background:#f8f9fa; padding:60px 0; }
        .contact-grid{ display:grid; grid-template-columns:2fr 1fr; gap:40px; max-width:1200px; margin:0 auto; padding:0 15px; }
        .contact-form-box{ background:white; padding:30px; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.07); }
        .contact-info-box{ background:#2c3e50; color:white; padding:30px; border-radius:12px; }
        .form-row{ display:grid; grid-template-columns:1fr 1fr; gap:15px; }
        .form-group{ margin-bottom:18px; display:flex; flex-direction:column; }
        .form-group label{ font-weight:600; margin-bottom:6px; font-size:14px; }
        .form-group input, .form-group select, .form-group textarea{ padding:12px 14px; border:1px solid #ddd; border-radius:6px; font-size:15px; width:100%; }
        .btn-submit{ background:#ff6600; color:white; padding:14px 30px; border:none; border-radius:6px; font-weight:bold; cursor:pointer; width:100%; font-size:16px; }
        .alert.success{ background:#d4edda; color:#155724; padding:12px; border-radius:6px; margin-bottom:15px; }
        .alert.error{ background:#f8d7da; color:#721c24; padding:12px; border-radius:6px; margin-bottom:15px; }
        .info-item{ display:flex; gap:15px; margin-bottom:20px; }
        @media(max-width:768px){ .features-grid{ grid-template-columns:1fr; } .contact-grid{ grid-template-columns:1fr; } .form-row{ grid-template-columns:1fr; } }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
     <div class="page-content">
    <section class="page-hero">
        <div class="container">
            <h1>40-Ton Tipper Haulage Services</h1>
            <p>Have materials on ground? We’ll move them. Lagos, Ogun, Oyo, e.t.c. Same-day dispatch.</p>
        </div>
    </section>
    
    <section class="haulage-features">
        <div class="container">
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">🚛</div>
                    <h3>20-Ton Capacity</h3>
                    <p>Full tipper load. Granite, sand, laterite, concrete. One trip clears your site.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">⚡</div>
                    <h3>Same-Day Service</h3>
                    <p>Call before 12pm, we dispatch today. Emergency site clearing available.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📍</div>
                    <h3>Lagos & Ogun Routes</h3>
                    <p>We know all quarries and sites. Lekki, Ikeja, Mowe, Abeokuta, Ibadan, e.t.c.</p>
                </div>
            </div>
        </div>
    </section>
    
    <section class="contact-section">
        <div class="container">
            <div class="contact-grid">
                <div class="contact-form-box">
                    <h2>Get Haulage Quote</h2>
                    
                    <% if(!msg.isEmpty()) { %>
                        <div class="alert <%= msgType %>"><%= msg %></div>
                    <% } %>
                    
                    <form method="POST" action="haulage.jsp">
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
                        
                        <div class="form-group">
                            <label>Pickup Location *</label>
                            <input type="text" name="pickup" placeholder="e.g. Quarry at Abeokuta, Site at Mowe" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Dropoff Location *</label>
                            <input type="text" name="dropoff" placeholder="e.g. Lekki Phase 1, Ikeja Site" required>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label>Material Type</label>
                                <select name="material">
                                    <option value="Granite">Granite</option>
                                    <option value="Sharp Sand">Sharp Sand</option>
                                    <option value="Laterite">Laterite / Filling</option>
                                    <option value="Stone Dust">Stone Dust</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Tons to Move</label>
                                <input type="number" name="tons" value="30" min="10" max="40" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Preferred Date</label>
                            <input type="date" name="pref_date">
                        </div>
                        
                        <div class="form-group">
                            <label>Notes</label>
                            <textarea name="notes" rows="3" placeholder="Access road condition, time restrictions, etc"></textarea>
                        </div>
                        
                        <button type="submit" class="btn-submit">Get Instant Estimate</button>
                        <p style="text-align:center; font-size:13px; color:#777; margin-top:10px;">
                            Final price confirmed by phone after we check distance & road access
                        </p>
                    </form>
                </div>
                
                <div class="contact-info-box">
                    <h3>Haulage Rates</h3>
                    <div class="info-item">
                        <span class="icon">💰</span>
                        <div>
                            <strong>Base Rate</strong>
                            <p>From ₦50,000 per trip within Lagos</p>
                        </div>
                    </div>
                    <div class="info-item">
                        <span class="icon">📏</span>
                        <div>
                            <strong>Distance</strong>
                            <p>+₦1,500 per km outside base zone</p>
                        </div>
                    </div>
                    <div class="info-item">
                        <span class="icon">🚧</span>
                        <div>
                            <strong>Bad Road Surcharge</strong>
                            <p>+₦10,000 if tipper needs support to enter</p>
                        </div>
                    </div>
                    <div class="info-item">
                        <span class="icon">📞</span>
                        <div>
                            <strong>Urgent Booking</strong>
                            <p><a href="tel:+2348035247317">+234 803 524 7317</a><br>WhatsApp us location pin</p>
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