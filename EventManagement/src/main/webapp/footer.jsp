<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="bg-light py-4">
    <div class="container">
        <div class="row">
            <!-- Categories Section -->
            <div class="col-md-4">
                <h5><strong>Categories</strong></h5>
                <ul class="list-unstyled">
                    <li>Social Events</li>
                    <li>Corporate Events</li>
                    <li>Entertainment Events</li>
                    <li>Educational Events</li>
                    <li>Non-Profit Events</li>
                    <li>Sporting Events</li>
                    <li>Cultural & Art Events</li>
                    <li>Religious & Spiritual Events</li>
                    <li>Trade & Industries Events</li>
                    <li>Community & Civic Events</li>
                </ul>
            </div>

            <!-- Social Media & Address -->
            <div class="col-md-4 text-center">
                <h5><strong>Follow us on</strong></h5>
                <div>
                    <a href="#"><i class="fab fa-instagram mx-2"></i></a>
                    <a href="#"><i class="fab fa-facebook mx-2"></i></a>
                    <a href="#"><i class="fab fa-twitter mx-2"></i></a>
                    <a href="#"><i class="fab fa-pinterest mx-2"></i></a>
                </div>
                <h5 class="mt-3"><strong>Address</strong></h5>
                <p>Bhagwanpur Hat, Siwan, Bihar,<br>India - 841507</p>
            </div>

            <!-- Contact Form -->
            <div class="col-md-4">
                <h5><strong>Get in Touch</strong></h5>
                <form action="contactServlet" method="post">
                    <div class="mb-2">
                        <input type="text" class="form-control" name="name" placeholder="Name" required>
                    </div>
                    <div class="mb-2">
                        <input type="email" class="form-control" name="email" placeholder="E-mail" required>
                    </div>
                    <div class="mb-2">
                        <textarea class="form-control" name="message" placeholder="Message" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-danger">Submit</button>
                </form>
            </div>
        </div>
    </div>
</footer>

<!-- Add FontAwesome for icons -->
<script src="https://kit.fontawesome.com/YOUR_KIT_CODE.js" crossorigin="anonymous"></script>
