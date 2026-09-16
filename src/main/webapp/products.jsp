[paste above fixed code]
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Our Granite Products - Yusroh Global</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/style.css?v=3">
    <style>
    .product-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));gap:25px}
    .product-card{border:1px solid #eee;border-radius:12px;overflow:hidden;background:#fff}
    .product-image{position:relative;height:200px;background:#f4f6f9}
    .product-image img{width:100%;height:100%;object-fit:cover}
    .product-badge{position:absolute;top:10px;left:10px;background:#ff9800;color:#fff;padding:4px 10px;border-radius:20px;font-size:12px;font-weight:700}
    .product-body{padding:18px}
    .price{font-size:18px;font-weight:800;color:#2c3e50}
    </style>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="page-content">
<section class="page-hero"><div class="container"><h1>Our Granite Products</h1><p>Premium quarry-direct granite. 40 tons per trip.</p></div></section>
<section class="products-section"><div class="container"><div class="product-grid">

<div class="product-card"><div class="product-image"><img src="<%=request.getContextPath()%>/images/granite-1.jpeg" alt="Granite"><span class="product-badge">20mm</span></div><div class="product-body"><h3>Granite 20mm</h3><p>For decking and heavy construction</p><div style="display:flex;justify-content:space-between;align-items:center;margin-top:15px"><span class="price">₦45,000 / ton</span><a href="contact.jsp?product=1" style="background:#ff6600;color:#fff;padding:8px 14px;border-radius:6px;text-decoration:none">Get Quote</a></div></div></div>

<div class="product-card"><div class="product-image"><img src="<%=request.getContextPath()%>/images/granite-12.jpeg" alt="Granite"><span class="product-badge">15mm</span></div><div class="product-body"><h3>1/2 Granite</h3><p>Best for residential building</p><div style="display:flex;justify-content:space-between;align-items:center;margin-top:15px"><span class="price">₦43,000 / ton</span><a href="contact.jsp?product=2" style="background:#ff6600;color:#fff;padding:8px 14px;border-radius:6px;text-decoration:none">Get Quote</a></div></div></div>

<div class="product-card"><div class="product-image"><img src="<%=request.getContextPath()%>/images/stone-dust.jpeg" alt="Dust"><span class="product-badge">Dust</span></div><div class="product-body"><h3>Granite Dust</h3><p>For block molding and finishing</p><div style="display:flex;justify-content:space-between;align-items:center;margin-top:15px"><span class="price">₦25,000 / ton</span><a href="contact.jsp?product=3" style="background:#ff6600;color:#fff;padding:8px 14px;border-radius:6px;text-decoration:none">Get Quote</a></div></div></div>

<div class="product-card"><div class="product-image"><img src="<%=request.getContextPath()%>/images/boulders.jpeg" alt="Boulders"><span class="product-badge">50mm</span></div><div class="product-body"><h3>50mm Boulders</h3><p>For foundation and shoreline</p><div style="display:flex;justify-content:space-between;align-items:center;margin-top:15px"><span class="price">₦40,000 / ton</span><a href="contact.jsp?product=4" style="background:#ff6600;color:#fff;padding:8px 14px;border-radius:6px;text-decoration:none">Get Quote</a></div></div></div>

<div class="product-card"><div class="product-image"><img src="<%=request.getContextPath()%>/images/granite-34.jpeg" alt="3/4"><span class="product-badge">3/4</span></div><div class="product-body"><h3>3/4 Granite</h3><p>Popular size for concrete mix</p><div style="display:flex;justify-content:space-between;align-items:center;margin-top:15px"><span class="price">₦44,000 / ton</span><a href="contact.jsp?product=5" style="background:#ff6600;color:#fff;padding:8px 14px;border-radius:6px;text-decoration:none">Get Quote</a></div></div></div>

</div></div></section></div>
<jsp:include page="footer.jsp" />
</body>
</html>