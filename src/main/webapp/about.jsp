<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>About Us - Yusroh Global Multiservices Ltd</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Learn about Yusroh Global Enterprise - Nigeria's trusted granite and haulage company. Meet our Managing Director and our commitment to quality.">
    <link rel="stylesheet" href="style.css">
    <style>
        .about-hero { 
            background: linear-gradient(135deg, rgba(44,62,80,0.95) 0%, rgba(52,73,94,0.95) 100%), url('<%= request.getContextPath() %>/images/quarry-bg.jpg') center/cover; 
            color: white; 
            padding: 80px 0; 
            text-align: center; 
        }
        .about-hero h1 { margin: 0 0 15px; font-size: 42px; }
        .about-hero p { margin: 0; font-size: 18px; opacity: 0.9; max-width: 700px; margin: 0 auto; }
        
        .about-section { padding: 70px 0; }
        .about-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 50px; align-items: center; }
        .about-content h2 { margin: 0 0 20px; font-size: 32px; color: #2c3e50; }
        .about-content p { line-height: 1.8; color: #555; margin-bottom: 15px; font-size: 16px; }
        .about-image img { width: 100%; border-radius: 12px; box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
        
        .values-section { background: #f8f9fa; padding: 70px 0; }
        .values-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 30px; margin-top: 40px; }
        .value-card { background: white; padding: 35px 30px; border-radius: 12px; text-align: center; box-shadow: 0 2px 10px rgba(0,0,0,0.06); border-top: 4px solid #ff9800; }
        .value-icon { font-size: 42px; margin-bottom: 15px; }
        .value-card h3 { margin: 0 0 12px; color: #2c3e50; font-size: 20px; }
        .value-card p { margin: 0; color: #666; line-height: 1.7; font-size: 15px; }
        
        .md-section { padding: 70px 0; }
        .md-card { background: white; border-radius: 12px; box-shadow: 0 8px 25px rgba(0,0,0,0.08); overflow: hidden; max-width: 900px; margin: 0 auto; display: grid; grid-template-columns: 350px 1fr; }
        .md-photo { background: #f4f6f9; }
        .md-photo img { width: 100%; height: 100%; object-fit: cover; display: block; }
        .md-details { padding: 45px 40px; }
        .md-details h2 { margin: 0 0 8px; font-size: 28px; color: #2c3e50; }
        .md-title { color: #ff9800; font-weight: 700; font-size: 16px; margin-bottom: 20px; text-transform: uppercase; letter-spacing: 0.5px; }
        .md-details p { line-height: 1.8; color: #555; margin-bottom: 15px; font-size: 15px; }
        .md-quote { border-left: 4px solid #ff9800; padding-left: 20px; margin: 25px 0; font-style: italic; color: #2c3e50; font-size: 16px; }
        
        .stats-banner { background: #2c3e50; color: white; padding: 60px 0; text-align: center; }
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 40px; max-width: 900px; margin: 0 auto; }
        .stat-item h3 { margin: 0 0 8px; font-size: 40px; color: #ff9800; }
        .stat-item p { margin: 0; font-size: 15px; opacity: 0.9; text-transform: uppercase; letter-spacing: 0.5px; }
        
        .section-title { text-align: center; margin-bottom: 15px; font-size: 32px; color: #2c3e50; }
        .section-subtitle { text-align: center; color: #7f8c8d; max-width: 600px; margin: 0 auto 20px; font-size: 16px; }
        
        @media (max-width: 900px) {
            .about-grid, .md-card { grid-template-columns: 1fr; }
            .md-photo { max-height: 400px; }
            .about-hero h1 { font-size: 32px; }
        }
        @media (max-width: 768px) {
            .about-section, .values-section, .md-section { padding: 50px 0; }
            .md-details { padding: 30px 25px; }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <section class="about-hero">
        <div class="container">
            <h1>About Yusroh Global Multiservices Ltd</h1>
            <p>Building Nigeria with quality granite and dependable haulage since 2015</p>
        </div>
    </section>
    
    <section class="about-section">
        <div class="container">
            <div class="about-grid">
                <div class="about-content">
                    <h2>Our Story</h2>
                    <p>Yusroh Global Multiservices Ltd. was founded in 2015 with a simple mission: make quality granite accessible and haulage reliable for every Nigerian builder.</p>
                    <p>What started as a single truck operation in Abeokuta has grown into one of Ogun State's most trusted names in construction materials and logistics. We own our quarries, maintain our fleet, and handle every order personally.</p>
                    <p>Today we supply 20mm and 15mm granite, sharp sand, and laterite to contractors, developers, and individuals across Southwest Nigeria. Our haulage division moves materials safely and on time using our fleet of well-maintained tippers and trucks.</p>
                </div>
                <div class="about-image">
                    <img src="<%= request.getContextPath() %>/images/crusher.jpeg" alt="Yusroh Global Quarry Operations" onerror="this.src='https://images.unsplash.com/photo-1581092918056-0c4c3acd3789?w=600&q=80'">
                </div>
            </div>
        </div>
    </section>
    
    <section class="values-section">
        <div class="container">
            <h2 class="section-title">Why Builders Choose Us</h2>
            <p class="section-subtitle">Three principles guide every load we deliver</p>
            
            <div class="values-grid">
                <div class="value-card">
                    <div class="value-icon">🏗️</div>
                    <h3>Quality First</h3>
                    <p>We source directly from our own quarries. Every granite load is washed, graded, and inspected before it leaves our yard. No shortcuts.</p>
                </div>
                <div class="value-card">
                    <div class="value-icon">🚛</div>
                    <h3>Reliable Haulage</h3>
                    <p>Our trucks are serviced weekly. Our drivers know every route in Ogun and Lagos. When we say 2pm delivery, we mean 2pm.</p>
                </div>
                <div class="value-card">
                    <div class="value-icon">🤝</div>
                    <h3>Honest Pricing</h3>
                    <p>What we quote is what you pay. No hidden charges, no "network fees", no price change on delivery day. Call us anytime to confirm.</p>
                </div>
            </div>
        </div>
    </section>
    
    <section class="md-section">
        <div class="container">
            <div class="md-card">
                <div class="md-photo">
                    <img src="<%= request.getContextPath() %>/images/Yusroh.jpeg" 
                         alt="Managing Director, Yusroh Global Multiservices Ltd"
                         onerror="this.src='https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&q=80'">
                </div>
                <div class="md-details">
                    <h2> Mr. Yusuff Adebowale</h2>
                    <div class="md-title">Managing Director & Founder</div>
                    <p>With over 15 years in construction materials and logistics, Alhaji Yusuff built this company from one tipper truck to a full-service granite and haulage operation.</p>
                    <p>He personally inspects our quarry operations weekly and knows many customers by name. His focus has always been simple: deliver exactly what you promised, when you promised it.</p>
                    <div class="md-quote">
                        "We don't just sell granite. We help people build homes, schools, and roads. That responsibility means we can never compromise on quality or timing."
                    </div>
                    <p><strong>Direct Line:</strong> <a href="tel:+2348035247317" style="color: #ff9800; text-decoration: none;">+234 803 524 7317</a></p>
                </div>
            </div>
        </div>
    </section>
    
    <section class="stats-banner">
        <div class="container">
            <div class="stats-grid">
                <div class="stat-item">
                    <h3>10+</h3>
                    <p>Years in Business</p>
                </div>
                <div class="stat-item">
                    <h3>500+</h3>
                    <p>Projects Supplied</p>
                </div>
                <div class="stat-item">
                    <h3>15</h3>
                    <p>Trucks in Fleet</p>
                </div>
                <div class="stat-item">
                    <h3>24/7</h3>
                    <p>Customer Support</p>
                </div>
            </div>
        </div>
    </section>
    
    <jsp:include page="footer.jsp" />
</body>
</html>
