<footer class="site-footer">
    <div class="footer-container">

        <!-- Left side: Company info + links -->
        <div class="footer-left">
            <div class="footer-col">
                <h4>Yusroh Global Resources</h4>
                <p>Licensed quarry and sand supplier in Lagos State,Ogun State etc. Direct delivery to your site.</p>
                <p><strong>Phone:</strong> +2348035247317</p>
                <p><strong>Email:</strong> yusrohglobal@gmail.com</p>
            </div>

            <div class="footer-col">
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="products.jsp">Products</a></li>
                    <li><a href="about.jsp">About Us</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                    <li><a href="haulage.jsp">Haulage</a></li>
                    <li><a href="payment.jsp">Payment</a></li>
                    <li><a href="track.jsp">Track</a></li>
                    <li><a href="admin.jsp">Admin</a></li>
                      
                </ul>
            </div>

            <div class="footer-col">
                <h4>Delivery Calculator</h4>
                <label for="destination">Enter delivery address:</label>
                <input type="text" id="destination" placeholder="e.g. Ikeja, Lagos" style="width: 100%; padding: 8px; margin: 8px 0; border-radius: 5px; border: 1px solid #ccc;">
                <button onclick="calculateDistance()" style="padding: 10px 20px; background: #ff9800; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: 600;">Calculate KM & Cost</button>
                <p id="distanceResult" style="margin-top: 10px; font-weight: 600; color: #ff9800;"></p>
            </div>
        </div>

        <!-- Right side: Google Map -->
        <div class="footer-map">
            <div id="map" style="width: 100%; height: 100%; min-height: 250px; border-radius: 8px;"></div>
        </div>

    </div>

    <div class="footer-bottom">
        <p>&copy; 2026 Yusroh Global Resources. All rights reserved. RC 1939059</p>
    </div>
</footer>

<style>
.site-footer {
    background: #1a1a1a;
    color: #fff;
    padding: 50px 0 20px;
    margin-top: 60px;
}
.footer-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 40px;
    align-items: start;
}
.footer-left {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 30px;
}
.footer-col h4 {
    color: #ff9800;
    margin: 0 0 15px;
    font-size: 18px;
}
.footer-col ul {
    list-style: none;
    padding: 0;
    margin: 0;
}
.footer-col ul li {
    margin: 8px 0;
}
.footer-col ul li a {
    color: #ccc;
    text-decoration: none;
    transition: color 0.3s;
}
.footer-col ul li a:hover {
    color: #ff9800;
}
.footer-col p {
    color: #ccc;
    line-height: 1.6;
    margin: 8px 0;
}
.footer-map {
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0,0,0,0.3);
}
.footer-bottom {
    text-align: center;
    padding-top: 30px;
    margin-top: 40px;
    border-top: 1px solid #333;
    color: #888;
    font-size: 14px;
}
@media (max-width: 768px) {
   .footer-container {
        grid-template-columns: 1fr;
    }
}
</style>

<!-- Google Maps + Distance Calculator Script -->
<script>
const ORIGIN = "Abeokuta, Ogun State, Nigeria"; // Your quarry location
let map, directionsService, directionsRenderer;

function initMap() {
    // Initialize map centered on Abeokuta
    map = new google.maps.Map(document.getElementById("map"), {
        zoom: 8,
        center: { lat: 7.1604, lng: 3.3464 }, // Abeokuta coordinates
        mapTypeId: 'roadmap'
    });

    directionsService = new google.maps.DirectionsService();
    directionsRenderer = new google.maps.DirectionsRenderer({ map: map });
}

function calculateDistance() {
    const destination = document.getElementById('destination').value;
    if (!destination) {
        alert('Please enter a delivery address');
        return;
    }

    const request = {
        origin: ORIGIN,
        destination: destination,
        travelMode: 'DRIVING'
    };

    directionsService.route(request, (result, status) => {
        if (status === 'OK') {
            directionsRenderer.setDirections(result);
            const distance = result.routes[0].legs[0].distance.text;
            const duration = result.routes[0].legs[0].duration.text;

            // Example: N500 per km. Change this to your actual rate
            const ratePerKm = 500;
            const kmValue = parseFloat(result.routes[0].legs[0].distance.value) / 1000;
            const deliveryCost = Math.round(kmValue * ratePerKm);

            document.getElementById('distanceResult').innerHTML =
                `Distance: <strong>${distance}</strong> | Est. Time: ${duration}<br>
                Estimated Delivery Cost: <strong>?${deliveryCost.toLocaleString()}</strong>`;
        } else {
            alert('Could not calculate distance. Please check the address.');
        }
    });
}
</script>

<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAKj4mUsrBKgT0ProKBtVw0_ZImIu7ahzE&callback=initMap">
</script>