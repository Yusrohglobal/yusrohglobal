<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<div class="page-wrapper" style="padding: 60px 0; background: #f8f9fa;">
  <div class="container" style="max-width: 600px; margin: auto;">
    <div style="background: white; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08);">
      <h2 style="color: #0a3d62; text-align: center;">Make a Payment</h2>
      <p style="text-align: center; color: #666; margin-bottom: 30px;">Secure payment for Yusroh Global Limited Services</p>

      <form id="paymentForm">
        <div style="margin-bottom: 15px;">
          <label>Full Name</label>
          <input type="text" id="fullName" class="form-control" required placeholder="John Doe" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;">
        </div>
        <div style="margin-bottom: 15px;">
          <label>Email Address</label>
          <input type="email" id="email" class="form-control" required placeholder="customer@email.com" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;">
        </div>
        <div style="margin-bottom: 15px;">
          <label>Amount (NGN)</label>
          <input type="number" id="amount" class="form-control" required placeholder="5000" min="100" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;">
        </div>
        <div style="margin-bottom: 20px;">
          <label>Payment For</label>
          <select id="paymentFor" class="form-control" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;">
            <option>Haulage Services</option>
            <option>Procurement</option>
            <option>Consultancy</option>
            <option>Other</option>
          </select>
        </div>
        <button type="submit" id="payBtn" style="width: 100%; padding: 14px; background: #ff6a00; color: white; border: none; border-radius: 6px; font-weight: bold; font-size: 16px; cursor: pointer;">
          Pay Now with Paystack
        </button>
      </form>

      <p style="text-align: center; margin-top: 15px; font-size: 12px; color: #888;">
        <i class="fa fa-lock"></i> Secured by Paystack
      </p>
    </div>
  </div>
</div>

<script src="https://js.paystack.co/v1/inline.js"></script>
<script>
  const paymentForm = document.getElementById('paymentForm');
  paymentForm.addEventListener('submit', payWithPaystack, false);

  function payWithPaystack(e) {
    e.preventDefault();
    
    let email = document.getElementById('email').value;
    let amount = document.getElementById('amount').value * 100; // Paystack uses kobo
    let fullName = document.getElementById('fullName').value;
    let paymentFor = document.getElementById('paymentFor').value;

    let handler = PaystackPop.setup({
      key: 'pk_test_YOUR_PUBLIC_KEY_HERE', // <-- REPLACE WITH YOUR PAYSTACK PUBLIC KEY
      email: email,
      amount: amount,
      currency: 'NGN',
      ref: 'YUSROH_' + Math.floor((Math.random() * 1000000000) + 1),
      metadata: {
         custom_fields: [
            { display_name: "Full Name", variable_name: "full_name", value: fullName },
            { display_name: "Payment For", variable_name: "payment_for", value: paymentFor }
         ]
      },
      callback: function(response){
        // On successful payment, redirect to verify page
        window.location.href = "verify_payment.jsp?reference=" + response.reference;
      },
      onClose: function(){
        alert('Payment window closed.');
      }
    });
    handler.openIframe();
  }
</script>

<%@ include file="footer.jsp" %>