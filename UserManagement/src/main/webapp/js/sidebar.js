// Handles the burger menu toggle for mobile responsiveness.
(function () {
    const sidebar  = document.getElementById('sidebar');
    const overlay  = document.getElementById('sidebarOverlay');
    const burgerBtn= document.getElementById('burgerBtn');

    if (!sidebar || !overlay || !burgerBtn) return;

    burgerBtn.addEventListener('click', function () {
        sidebar.classList.toggle('open');
        overlay.classList.toggle('show');
    });

    overlay.addEventListener('click', function () {
        sidebar.classList.remove('open');
        overlay.classList.remove('show');
    });

    window.addEventListener('resize', function () {
        if (window.innerWidth > 768) {
            sidebar.classList.remove('open');
            overlay.classList.remove('show');
        }
    });
})();