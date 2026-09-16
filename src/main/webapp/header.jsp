<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    html, body { overflow-x: hidden !important; width: 100% !important; max-width: 100vw !important; margin: 0 !important; padding: 0 !important; }
    * { box-sizing: border-box !important; }
    
    .site-header { background: #101820 !important; color: white !important; padding: 24px 30px !important; width: 100% !important; display: flex !important; justify-content: space-between !important; align-items: center !important; position: relative !important; z-index: 10000 !important; }
    
    .site-header .brand-area { display: flex !important; align-items: center !important; gap: 12px !important; }
    
    /* === YUSROH LOGO EFFECTS === */
    .site-header .logo-link {
        position: relative !important;
        display: inline-block !important;
        overflow: hidden !important;
        border-radius: 6px !important;
        animation: logoFloat 3s ease-in-out infinite !important;
    }
    
    .site-header .logo-link img {
        height: 76px !important;
        width: auto !important;
        display: block !important;
        max-width: 150px !important;
        object-fit: contain !important;
        transition: all 0.4s ease !important;
        filter: drop-shadow(0 0 6px rgba(255, 140, 0, 0.4)) !important;
    }
    
    .site-header .logo-link:hover img {
        transform: scale(1.1) !important;
        filter: drop-shadow(0 0 15px rgba(255, 140, 0, 0.9)) drop-shadow(0 0 25px rgba(255, 140, 0, 0.4)) !important;
    }

    /* Shine sweep */
    .site-header .logo-link::after {
        content: '' !important;
        position: absolute !important;
        top: 0 !important;
        left: -100% !important;
        width: 70% !important;
        height: 100% !important;
        background: linear-gradient(120deg, transparent, rgba(255,255,255,0.6), transparent) !important;
        transform: skewX(-20deg) !important;
        animation: shine 4s infinite !important;
    }

    .site-header .brand-area h2 { 
        margin: 0 !important; 
        font-size: 18px !important; 
        font-family: 'Poppins', sans-serif !important; 
        color: white !important;
        text-shadow: 0 0 10px rgba(255,255,255,0.1) !important;
        transition: all 0.3s !important;
    }
    .site-header .brand-area h2 span { 
        color: #FF8C00 !important; 
        position: relative !important;
        text-shadow: 0 0 8px rgba(255, 140, 0, 0.6) !important;
        animation: orangePulse 2.5s infinite !important;
    }

    .site-header .nav-links { display: flex !important; gap: 20px !important; list-style: none !important; margin: 0 !important; padding: 0 !important; }
    .site-header .nav-links a { color: white !important; text-decoration: none !important; font-weight: 600 !important; font-size: 15px !important; position: relative !important; }
    .site-header .nav-links a::after {
        content: '' !important;
        position: absolute !important;
        bottom: -4px !important;
        left: 0 !important;
        width: 0 !important;
        height: 2px !important;
        background: #FF8C00 !important;
        transition: width 0.3s !important;
    }
    .site-header .nav-links a:hover::after { width: 100% !important; }
    .site-header .nav-links a:hover { color: #FF8C00 !important; }
    
    .site-header .menu-toggle { display: none !important; background: none !important; border: none !important; cursor: pointer !important; padding: 5px !important; }
    .site-header .menu-toggle span { display: block !important; width: 25px !important; height: 3px !important; background: #FF8C00 !important; margin: 5px 0 !important; }

    @keyframes logoFloat {
        0%, 100% { transform: translateY(0px); }
        50% { transform: translateY(-2px); }
    }
    @keyframes shine {
        0% { left: -100%; }
        15% { left: 150%; }
        100% { left: 150%; }
    }
    @keyframes orangePulse {
        0%, 100% { text-shadow: 0 0 8px rgba(255, 140, 0, 0.6); }
        50% { text-shadow: 0 0 18px rgba(255, 140, 0, 1), 0 0 25px rgba(255, 140, 0, 0.5); }
    }
    
    @media (max-width: 900px) {
        .site-header .logo-link { display: none !important; }
        .site-header .menu-toggle { display: block !important; }
        .site-header .nav-links { 
            display: none !important; 
            position: absolute !important; 
            top: 100% !important; 
            left: 0 !important; 
            width: 100% !important; 
            flex-direction: column !important; 
            background: #1a242f !important; 
            border-top: 1px solid #2a3440 !important;
            z-index: 10001 !important;
        }
        .site-header .nav-links.show { display: flex !important; }
        .site-header .nav-links li { width: 100% !important; text-align: center !important; border-bottom: 1px solid #2a3440 !important; }
        .site-header .nav-links li a { display: block !important; padding: 14px !important; font-size: 16px !important; }
    }
</style>

<header class="site-header">
    <div class="brand-area">
        <a href="${pageContext.request.contextPath}/index.jsp" class="logo-link">
            <img src="${pageContext.request.contextPath}/logo.jpg" alt="YUSROH Global Logo">
        </a>
        <h2>YUSROH <span>Global Multiserves Ltd</span></h2>
    </div>
    <button class="menu-toggle" id="menu-toggle" type="button"><span></span><span></span><span></span></button>
    <ul class="nav-links" id="nav-links">
        <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/products.jsp">Products</a></li>
        <li><a href="${pageContext.request.contextPath}/haulage.jsp">Haulage</a></li>
        <li><a href="${pageContext.request.contextPath}/track.jsp">Track</a></li>
        <li><a href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>
        <li><a href="${pageContext.request.contextPath}/about.jsp">About us</a></li>
        <li><a href="${pageContext.request.contextPath}/payment.jsp">Payment</a></li>
        <li><a href="${pageContext.request.contextPath}/admin.jsp">Admin</a></li>
    </ul>
</header>

<script>
document.addEventListener('DOMContentLoaded', function(){
    var btn = document.getElementById('menu-toggle');
    var menu = document.getElementById('nav-links');
    if(btn){ btn.onclick = function(){ menu.classList.toggle('show'); } }
});
</script>