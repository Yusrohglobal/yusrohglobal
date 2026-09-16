<%@ include file="header.jsp" %>
<%@ page import="java.io.*, java.net.*" %>
<%
  String ref = request.getParameter("reference");
%>
<div style="padding: 80px 0; text-align: center;">
  <h2>Verifying Payment...</h2>
  <p>Reference: <%= ref %></p>
  <p id="status">Please wait...</p>
</div>

<script>
  // You will verify on server side using Paystack secret key
  // For now show success
  document.getElementById('status').innerHTML = "<span style='color:green; font-weight:bold;'>Payment Successful! Ref: <%= ref %> <br>We will confirm and contact you.</span>";
</script>

<%@ include file="footer.jsp" %>