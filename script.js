document.addEventListener('DOMContentLoaded', () => {
    // Login button functionality
    document.getElementById('loginBtn').addEventListener('click', (e) => {
        e.preventDefault();
        document.querySelector('.hero-content').style.opacity = '0';
        document.getElementById('roleSelection').style.display = 'block';
        setTimeout(() => {
            document.getElementById('roleSelection').style.opacity = '1';
        }, 100);
    });

    // Role selection functionality
    document.querySelectorAll('.role-option').forEach(option => {
        option.addEventListener('click', (e) => {
            const role = e.target.classList.contains('citizen') ? 'citizen' : 'admin';
            window.location.href = `login.html?role=${role}`;
        });
    });

    // Close role selection when clicking outside
    document.addEventListener('click', (e) => {
        const roleSelection = document.getElementById('roleSelection');
        if (!roleSelection.contains(e.target) && !document.getElementById('loginBtn').contains(e.target)) {
            roleSelection.style.opacity = '0';
            setTimeout(() => {
                roleSelection.style.display = 'none';
                document.querySelector('.hero-content').style.opacity = '1';
            }, 300);
        }
    });

    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });
});