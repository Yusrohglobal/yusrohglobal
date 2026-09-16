<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Our Granite Products - Yusroh Global</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/style.css?v=5">
</head>
<body>
<jsp:include page="header.jsp" />
<div class="page-content">
<section class="page-hero"><div class="container"><h1>Our Granite Products</h1><p>Premium quarry-direct granite. 40 tons per trip.</p></div></section>
<section class="products-section"><div class="container"><div class="product-grid" style="display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));gap:25px">
<div class="product-card" style="border:1px solid #eee;border-radius:12px;overflow:hidden;background:#fff"><div class="product-image" style="height:200px"><img src="${pageContext.request.contextPath}/images/granite-1.jpeg" style="width:100%;height:100%;object-fit:cover" alt="Granite"><span style="position:absolute;top:10px;left:10px;background:#ff9800;color:#fff;padding:4px 10px;border-radius:20px;font-size:12px">20mm</span></div><div style="padding:18px"><h3>Granite 20mm</h3><p>For decking</p><div style="display:flex;justify-content:space-between"><span style="font-weight:800">₦45,000 / ton</span><a href="contact.jsp?product=1" style="background:#ff6600;color:#fff;padding:8px 14px;border-radius:6px;text-decoration:none">Get Quote</a></div></div></div>
<div class="product-card" style="border:1px solid #eee;border-radius:12px;overflow:hidden;background:#fff"><div class="product-image" style="height:200px"><img src="${pageContext.request.contextPath}/images/granite-12.jpeg" style="width:100%;height:100%;object-fit:cover" alt="Granite"><span style="position:absolute;top:10px;left:10px;background:#ff9800;color:#fff;padding:4px 10px;border-radius:20px;font-size:12px">1/2</span></div><div style="padding:18px"><h3>1/2 Granite</h3><p>Residential</p><div style="display:flex;justify-content:space-between"><span style="font-weight:800">₦43,000 / ton</span><a href="contact.jsp?product=2" style="background:#ff6600;color:#fff;padding:8px 14px;border-radius:6px;text-decoration:none">Get Quote</a></div></div></div>
<div class="product-card" style="border:1px solid #eee;border-radius:12px;overflow:hidden;background:#fff"><div class="product-image" style="height:200px"><img src="${pageContext.request.contextPath}/images/stone-dust.jpeg" style="width:100%;height:100%;object-fit:cover" alt="Dust"></div><div style="padding:18px"><h3>Granite Dust</h3><p>Block molding</p><div style="display:flex;justify-content:space-between"><span style="font-weight:800">₦25,000 / ton</span><a href="contact.jsp?product=3" style="background:#ff6600;color:#fff;padding:8px 14px;border-radius:6px;text-decoration:none">Get Quote</a></div></div></div>
<div class="product-card" style="border:1px solid #eee;border-radius:12px;overflow:hidden;background:#fff"><div class="product-image" style="height:200px"><img src="${pageContext.request.contextPath}/images/boulders.jpeg" style="width:100%;height:100%;object-fit:cover" alt="Boulders"></div><div style="padding:18px"><h3>50mm Boulders</h3><p>Foundation</p><div style="display:flex;justify-content:space-between"><span style="font-weight:800">₦40,000 / ton</span><a href="contact.jsp?product=4" style="background:#ff6600;color:#fff;padding:8px 14px;border-radius:6px;text-decoration:none">Get Quote</a></div></div></div>
<div class="product-card" style="border:1px solid #eee;border-radius:12px;overflow:hidden;background:#fff"><div class="product-image" style="height:200px"><img src="${pageContext.request.contextPath}/images/granite-34.jpeg" style="width:100%;height:100%;object-fit:cover" alt="3/4"></div><div style="padding:18px"><h3>3/4 Granite</h3><p>Concrete mix</p><div style="display:flex;justify-content:space-between"><span style="font-weight:800">₦44,000 / ton</span><a href="contact.jsp?product=5" style="background:#ff6600;color:#fff;padding:8px 14px;border-radius:6px;text-decoration:none">Get Quote</a></div></div></div>
</div></div></section></div>
<jsp:include page="footer.jsp" />
</body>
</html>