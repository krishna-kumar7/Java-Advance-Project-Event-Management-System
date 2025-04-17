// Wait for the DOM to be fully loaded
document.addEventListener("DOMContentLoaded", function() {

    // Example: Form Validation for Event Registration
    const eventRegisterForm = document.querySelector('form');
    
    // Event handler for form submission
    eventRegisterForm.addEventListener('submit', function(event) {
        const eventName = document.getElementById('eventName').value;
        const eventDate = document.getElementById('eventDate').value;
        const eventDescription = document.getElementById('eventDescription').value;
        const eventLocation = document.getElementById('eventLocation').value;
        
        // Check if required fields are filled
        if (!eventName || !eventDate || !eventDescription || !eventLocation) {
            event.preventDefault();  // Prevent form submission
            alert("Please fill out all required fields.");
        }
    });

    // Example: Smooth Scrolling for Links
    const scrollLinks = document.querySelectorAll('a[href^="#"]');
    
    scrollLinks.forEach(function(link) {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = link.getAttribute('href').substring(1);
            const targetElement = document.getElementById(targetId);
            if (targetElement) {
                targetElement.scrollIntoView({ behavior: "smooth" });
            }
        });
    });

    // Example: Handle Event Image Preview (for event registration page)
    const eventImageInput = document.getElementById('eventImage');
    const imagePreview = document.createElement('img');
    imagePreview.style.maxWidth = '200px';
    imagePreview.style.marginTop = '10px';
    
    if (eventImageInput) {
        eventImageInput.addEventListener('change', function(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    imagePreview.src = e.target.result;
                    if (!document.contains(imagePreview)) {
                        eventImageInput.parentNode.appendChild(imagePreview);
                    }
                };
                reader.readAsDataURL(file);
            }
        });
    }

    // Example: Toggle Visibility of Password on Sign In Page
    const passwordField = document.getElementById('password');
    const togglePasswordButton = document.createElement('button');
    togglePasswordButton.textContent = 'Show Password';
    togglePasswordButton.type = 'button';
    
    if (passwordField) {
        passwordField.insertAdjacentElement('afterend', togglePasswordButton);
        
        togglePasswordButton.addEventListener('click', function() {
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                togglePasswordButton.textContent = 'Hide Password';
            } else {
                passwordField.type = 'password';
                togglePasswordButton.textContent = 'Show Password';
            }
        });
    }

});
/**
 * 
 */