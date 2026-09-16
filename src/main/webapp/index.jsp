<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>YUSROH Global Multiservices Ltd - Lagos Granite & Haulage Experts</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&display=swap');
        
        :root {
            --orange: #FF8C00;
            --dark: #101820;
            --grey: #f4f6f8;
            --whatsapp: #25D366;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        html { scroll-behavior: smooth; }
        body {
            font-family: 'Poppins', sans-serif;
            color: #2c2c2c;
            background: #fff;
            overflow-x: hidden;
        }
        
        /* Hero using your uploaded quarry image */
        .hero {
            height: 90vh;
            background: linear-gradient(135deg, rgba(16,24,32,0.85), rgba(255,140,0,0.6)), 
                        url('images/hero.jpeg') center/cover no-repeat;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            position: relative;
        }
        .hero-content {
            max-width: 800px;
            padding: 20px;
            animation: fadeInUp 1.2s ease;
        }
        .hero h1 {
            font-size: 3.5rem;
            font-weight: 800;
            line-height: 1.1;
            margin-bottom: 20px;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.6);
        }
        .hero h1 span { color: var(--orange); }
        .hero p {
            font-size: 1.3rem;
            font-weight: 300;
            margin-bottom: 35px;
            opacity: 0.95;
            text-shadow: 1px 1px 4px rgba(0,0,0,0.7);
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .btn-main {
            background: var(--orange);
            color: white;
            padding: 16px 40px;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s;
            box-shadow: 0 5px 25px rgba(255,140,0,0.5);
            display: inline-block;
        }
        .btn-main:hover {
            transform: translateY(-4px) scale(1.03);
            box-shadow: 0 8px 30px rgba(255,140,0,0.7);
        }
        .wave {
            position: absolute;
            bottom: -1px;
            left: 0;
            width: 100%;
            height: 100px;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="%23ffffff" fill-opacity="1" d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,122.7C672,117,768,139,864,149.3C960,160,1056,160,1152,138.7C1248,117,1344,75,1392,53.3L1440,32L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
            background-size: cover;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 80px 20px;
        }
        .counters {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
            text-align: center;
            margin-top: -120px;
            position: relative;
            z-index: 3;
        }
        .counter-box {
            background: white;
            padding: 35px 20px;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
        }
        .counter-box h3 {
            font-size: 2.8rem;
            color: var(--orange);
            font-weight: 800;
        }
        .counter-box p { color: #666; font-weight: 600; }
        .title {
            text-align: center;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 15px;
        }
        .subtitle {
            text-align: center;
            color: #666;
            max-width: 600px;
            margin: 0 auto 50px;
        }
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 35px;
        }
        .service-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(0,0,0,0.07);
            transition: all 0.4s ease;
        }
        .service-card:hover {
            transform: translateY(-12px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.12);
        }
        .service-img {
            height: 220px;
            background-size: cover;
            background-position: center;
        }
        .service-body { padding: 30px; }
        .service-body h3 {
            font-size: 1.6rem;
            margin-bottom: 12px;
        }
        .service-body p {
            color: #666;
            margin-bottom: 25px;
        }
        .btn-sec {
            color: var(--orange);
            text-decoration: none;
            font-weight: 700;
            transition: 0.3s;
        }
        .btn-sec:hover { letter-spacing: 1px; }
        .testimonial {
            background: var(--grey);
            padding: 80px 20px;
            text-align: center;
        }
        .quote {
            max-width: 800px;
            margin: 0 auto;
            font-size: 1.4rem;
            font-style: italic;
            color: #444;
        }
        .quote::before {
            content: '“';
            font-size: 4rem;
            color: var(--orange);
            line-height: 0;
        }
        .author {
            margin-top: 20px;
            font-weight: 700;
            color: var(--dark);
        }
        .cta-strip {
            background: var(--dark);
            color: white;
            padding: 50px 20px;
            text-align: center;
        }
        .cta-strip h2 { font-size: 2rem; margin-bottom: 20px; }
        .footer {
            background: #0a0f14;
            color: #7a7a7a;
            text-align: center;
            padding: 30px 20px;
            font-size: 0.9rem;
        }
        
        /* FLOATING WHATSAPP BUTTON */
        .whatsapp-float {
            position: fixed;
            width: 60px;
            height: 60px;
            bottom: 25px;
            right: 25px;
            background-color: var(--whatsapp);
            color: #FFF;
            border-radius: 50px;
            text-align: center;
            font-size: 30px;
            box-shadow: 0 4px 15px rgba(37, 211, 102, 0.4);
            z-index: 1000;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: all 0.3s ease;
            animation: pulse 2s infinite;
        }
        .whatsapp-float:hover {
            background-color: #1ebe5d;
            transform: scale(1.1);
            box-shadow: 0 6px 20px rgba(37, 211, 102, 0.6);
        }
        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(37, 211, 102, 0.7); }
            70% { box-shadow: 0 0 0 12px rgba(37, 211, 102, 0); }
            100% { box-shadow: 0 0 0 0 rgba(37, 211, 102, 0); }
        }
        .whatsapp-tooltip {
            position: absolute;
            right: 75px;
            background: #333;
            color: white;
            padding: 8px 15px;
            border-radius: 6px;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s;
        }
        .whatsapp-float:hover .whatsapp-tooltip {
            opacity: 1;
            visibility: visible;
        }
        
        @media (max-width: 768px) {
            .hero h1 { font-size: 2.2rem; }
            .hero p { font-size: 1.1rem; }
            .counters { margin-top: -60px; }
            .whatsapp-tooltip { display: none; }
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <section class="hero">
        <div class="hero-content">
            <h1>Building Nigeria with <span>Premium Granite</span> & Reliable Haulage</h1>
            <p>YUSROH Global Multiservices Ltd supplies quality materials & moves them fast. Quarry-direct prices, 24hr delivery.</p>
            <a href="contact.jsp" class="btn-main">Get Free Quote in 2 Minutes</a>
        </div>
        <div class="wave"></div>
    </section>
    
    <div class="container">
        <div class="counters">
            <div class="counter-box">
                <h3>10+</h3>
                <p>Years in Business</p>
            </div>
            <div class="counter-box">
                <h3>500+</h3>
                <p>Sites Supplied</p>
            </div>
            <div class="counter-box">
                <h3>50k+</h3>
                <p>Tons Delivered</p>
            </div>
            <div class="counter-box">
                <h3>24/7</h3>
                <p>Support Line</p>
            </div>
        </div>
    </div>
    
    <div class="container">
        <h2 class="title">What We Do Best</h2>
        <p class="subtitle">From foundation to finishing, we supply and deliver the materials that keep Lagos construction moving.</p>
        
        <div class="grid">
            <div class="service-card">
                <div class="service-img" style="background-image: url('images/granite.jpeg');"></div>
                <div class="service-body">
                    <h3>Granite & Stone Supply</h3>
                    <p>All sizes: 3/4, 1/2, stone dust, boulders. Washed and graded. Direct quarry pricing for contractors and developers.</p>
                    <a href="products.jsp" class="btn-sec">Check Today’s Prices →</a>
                </div>
            </div>
            
            <div class="service-card">
                <div class="service-img" style="background-image: url('images/tipper.jpeg');"></div>
                <div class="service-body">
                    <h3>Tipper & Haulage Service</h3>
                    <p>20 & 30 ton tippers available daily. We haul granite, sand, gravel, and laterite. Lagos & interstate coverage.</p>
                    <a href="haulage.jsp" class="btn-sec">Book a Truck Now →</a>
                </div>
            </div>
        </div>
    </div>
    
    <section class="testimonial">
        <div class="quote">
            YUSROH has been our granite supplier for over 10 years. Prices are fair, trucks show up on time, and the quality is consistent. They understand construction deadlines.
        </div>
        <div class="author">— Engr. Adebayo, Bayson Construction, Lekki</div>
    </section>
    
    <section class="cta-strip">
        <h2>Have a project in Nigeria? Let’s talk tonnage and timelines.</h2>
        <a href="contact.jsp" class="btn-main">Call/WhatsApp Us Now</a>
    </section>
    
    <div class="footer">
        &copy; <%= java.time.Year.now().getValue() %> YUSROH Global Multiservices Limited | RC: 1939059 | Ogun State, Nigeria.
    </div>

    <a href="https://wa.me/2348035247317?text=Hello%20YUSROH%2C%20I%20need%20granite%20quote" 
       class="whatsapp-float" 
       target="_blank"
       rel="noopener noreferrer">
       <span class="whatsapp-tooltip">Chat with us on WhatsApp</span>
       <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="white">
           <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413Z"/>
       </svg>
    </a>
</body>
</html>