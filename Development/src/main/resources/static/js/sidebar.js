// ── Burger Menu Toggle (Mobile) ──────────────────────────
(function () {
    var sidebar   = document.getElementById('sidebar');
    var overlay   = document.getElementById('sidebarOverlay');
    var burgerBtn = document.getElementById('burgerBtn');

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


// Review Component Functions 
document.addEventListener('DOMContentLoaded', function () {

    // Tab switching
    var tabBtns  = document.querySelectorAll('.tab-btn');
    var tabPanes = document.querySelectorAll('.tab-pane');

    if (tabBtns.length > 0) {
        tabBtns.forEach(function (btn) {
            btn.addEventListener('click', function () {
                var target = btn.dataset.tab;

                tabBtns.forEach(function (b) { b.classList.remove('active'); });
                tabPanes.forEach(function (p) { p.classList.remove('active'); });

                btn.classList.add('active');
                var pane = document.getElementById(target);
                if (pane) {
                    pane.classList.add('active');
                }
            });
        });
    }

    // Star rating input
    document.querySelectorAll('.star-rating-input').forEach(function (container) {
        var radios = container.querySelectorAll('input[type="radio"]');
        var hint   = container.closest('.form-group')
                        ? container.closest('.form-group').querySelector('.rating-hint')
                        : null;

        var updateHint = function (val) {
            if (!hint) return;
            var labels = { 1: 'Poor', 2: 'Fair', 3: 'Good', 4: 'Very Good', 5: 'Excellent' };
            if (val) {
                hint.textContent = val + ' star' + (val > 1 ? 's' : '') + ' — ' + labels[val];
            } else {
                hint.textContent = 'Click a star to rate';
            }
        };

        radios.forEach(function (radio) {
            radio.addEventListener('change', function () {
                updateHint(parseInt(radio.value));
            });
        });

        var checked = container.querySelector('input:checked');
        if (checked) {
            updateHint(parseInt(checked.value));
        } else {
            updateHint(null);
        }
    });

    // Auto-dismiss flash messages after 4.5 seconds
    document.querySelectorAll('.flash').forEach(function (el) {
        setTimeout(function () {
            el.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
            el.style.opacity = '0';
            el.style.transform = 'translateY(-8px)';
            setTimeout(function () { el.remove(); }, 500);
        }, 4500);
    });

    // Stagger card entrance animations
    document.querySelectorAll('.animate-up').forEach(function (el, i) {
        el.style.animationDelay = (i * 0.07) + 's';
    });

    // Confirm dialogs for delete actions
    document.querySelectorAll('form[data-confirm]').forEach(function (form) {
        form.addEventListener('submit', function (e) {
            if (!confirm(form.dataset.confirm || 'Are you sure?')) {
                e.preventDefault();
            }
        });
    });

    // Format ISO date strings to readable format
    document.querySelectorAll('[data-date]').forEach(function (el) {
        var raw = el.dataset.date || el.textContent;
        if (!raw) return;
        try {
            var d = new Date(raw.replace('T', ' '));
            if (!isNaN(d)) {
                el.textContent = d.toLocaleDateString('en-US', {
                    year: 'numeric', month: 'short', day: 'numeric'
                });
            }
        } catch (e) { }
    });
});