// ============================================================
// Belajar Data — Shared Script
// ============================================================

const THEME_KEY = 'sql-da-theme';

// --- Theme ---
function getTheme() {
    return localStorage.getItem(THEME_KEY) || 'dark';
}

function setTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem(THEME_KEY, theme);
    const icon = document.getElementById('themeIcon');
    if (icon) {
        icon.className = theme === 'dark' ? 'fa-solid fa-sun' : 'fa-solid fa-moon';
    }
}

function toggleTheme() {
    setTheme(getTheme() === 'dark' ? 'light' : 'dark');
}

// --- Copy Code ---
function copyCode(btn) {
    const block = btn.closest('.code-block');
    const pre   = block.querySelector('pre');
    const text  = (pre.innerText || pre.textContent).trim();

    navigator.clipboard.writeText(text).then(() => {
        applycopied(btn, true);
    }).catch(() => {
        // Fallback
        const el = document.createElement('textarea');
        el.value = text;
        el.style.position = 'fixed';
        el.style.opacity  = '0';
        document.body.appendChild(el);
        el.select();
        try { document.execCommand('copy'); applycopied(btn, true); }
        catch { applycopied(btn, false); }
        document.body.removeChild(el);
    });
}

function applycopied(btn, success) {
    const icon = btn.querySelector('i');
    const originalIcon = icon.className;
    const nodes = btn.childNodes;
    let textNode = null;
    nodes.forEach(n => { if (n.nodeType === 3 && n.textContent.trim()) textNode = n; });

    if (success) {
        btn.classList.add('copied');
        icon.className = 'fa-solid fa-check';
        if (textNode) textNode.textContent = ' Tersalin!';
    } else {
        icon.className = 'fa-solid fa-xmark';
        if (textNode) textNode.textContent = ' Gagal';
    }

    setTimeout(() => {
        btn.classList.remove('copied');
        icon.className = originalIcon;
        if (textNode) textNode.textContent = ' Salin';
    }, 2000);
}

// --- Sidebar Active Tracking ---
function initSidebar() {
    const sections  = document.querySelectorAll('section[id]');
    const navLinks  = document.querySelectorAll('.nav-link[href^="#"]');
    if (!sections.length || !navLinks.length) return;

    const io = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const id = entry.target.id;
                navLinks.forEach(link => {
                    link.classList.toggle('active', link.getAttribute('href') === '#' + id);
                });
            }
        });
    }, { rootMargin: `-${60}px 0px -55% 0px`, threshold: 0 });

    sections.forEach(s => io.observe(s));
}

// --- Mobile Sidebar Drawer Toggle ---
function initMobileSidebar() {
    const toggleBtn = document.getElementById('sidebarToggle');
    const sidebar   = document.querySelector('.sidebar');
    const overlay   = document.getElementById('sidebarOverlay');

    if (!sidebar) return;

    function openSidebar() {
        sidebar.classList.add('open');
        if (overlay) overlay.classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    function closeSidebar() {
        sidebar.classList.remove('open');
        if (overlay) overlay.classList.remove('active');
        document.body.style.overflow = '';
    }

    if (toggleBtn) {
        toggleBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            sidebar.classList.contains('open') ? closeSidebar() : openSidebar();
        });
    }

    if (overlay) {
        overlay.addEventListener('click', closeSidebar);
    }

    const navLinks = sidebar.querySelectorAll('a');
    navLinks.forEach(link => {
        link.addEventListener('click', () => {
            if (window.innerWidth <= 820) {
                closeSidebar();
            }
        });
    });
}

// --- Quiz ---
function answerQuiz(optEl, isCorrect, explanation) {
    const card = optEl.closest('.quiz-card');
    if (card.dataset.done) return;
    card.dataset.done = '1';

    card.querySelectorAll('.quiz-opt').forEach(o => {
        o.style.pointerEvents = 'none';
        if (o.dataset.correct === 'true') o.classList.add('correct');
    });
    if (!isCorrect) optEl.classList.add('wrong');

    const fb = card.querySelector('.quiz-fb');
    if (fb) {
        fb.classList.add('show', isCorrect ? 'correct' : 'wrong');
        const ico  = fb.querySelector('i');
        const txt  = fb.querySelector('span');
        if (ico) ico.className = isCorrect ? 'fa-solid fa-circle-check' : 'fa-solid fa-circle-xmark';
        if (txt) txt.textContent = (isCorrect ? 'Benar! ' : 'Kurang tepat. ') + explanation;
    }
}

// --- Interactive ERD PK & FK Canvas ---
function initSupabaseERDCanvas() {
    const canvas = document.querySelector('.supabase-canvas');
    if (!canvas) return;

    const svg = canvas.querySelector('.s-svg-overlay');
    const container = canvas.querySelector('.supabase-domains-container');
    if (!svg || !container) return;

    // 1. Draggable Nodes Implementation
    const nodes = canvas.querySelectorAll('.s-node');
    nodes.forEach(node => {
        const header = node.querySelector('.s-node-header');
        if (!header || node.dataset.dragInit) return;
        node.dataset.dragInit = "true";

        let isDragging = false;
        let startX, startY;
        let initialLeft = 0, initialTop = 0;

        header.addEventListener('pointerdown', e => {
            // Ignore click on buttons inside header
            if (e.target.tagName === 'BUTTON' || e.target.closest('button')) return;
            
            isDragging = true;
            node.classList.add('dragging');
            header.setPointerCapture(e.pointerId);

            startX = e.clientX;
            startY = e.clientY;

            const transform = new WebKitCSSMatrix(window.getComputedStyle(node).transform);
            initialLeft = transform.m41 || 0;
            initialTop = transform.m42 || 0;
        });

        header.addEventListener('pointermove', e => {
            if (!isDragging) return;
            const dx = e.clientX - startX;
            const dy = e.clientY - startY;
            node.style.transform = `translate(${initialLeft + dx}px, ${initialTop + dy}px)`;
            renderConnections();
        });

        const stopDrag = e => {
            if (!isDragging) return;
            isDragging = false;
            node.classList.remove('dragging');
            try { header.releasePointerCapture(e.pointerId); } catch(err){}
            renderConnections();
        };

        header.addEventListener('pointerup', stopDrag);
        header.addEventListener('pointercancel', stopDrag);
    });

    // 2. Real-time Cable Connections
    function renderConnections() {
        while (svg.firstChild) {
            svg.removeChild(svg.firstChild);
        }

        const canvasRect = canvas.getBoundingClientRect();
        const outHandles = canvas.querySelectorAll('.s-handle-out[data-handle]');

        outHandles.forEach(outDot => {
            const handleId = outDot.getAttribute('data-handle');
            const inDots = canvas.querySelectorAll(`.s-handle-in[data-handle-target="${handleId}"]`);
            if (!inDots.length) return;

            const r1 = outDot.getBoundingClientRect();
            const x1 = r1.left + r1.width / 2 - canvasRect.left;
            const y1 = r1.top + r1.height / 2 - canvasRect.top;

            inDots.forEach(inDot => {
                const r2 = inDot.getBoundingClientRect();
                const x2 = r2.left + r2.width / 2 - canvasRect.left;
                const y2 = r2.top + r2.height / 2 - canvasRect.top;

                // Smart Bezier curve control points
                let pathD;
                if (x2 >= x1) {
                    const dx = Math.abs(x2 - x1) * 0.5;
                    const cx1 = x1 + Math.max(dx, 40);
                    const cy1 = y1;
                    const cx2 = x2 - Math.max(dx, 40);
                    const cy2 = y2;
                    pathD = `M ${x1} ${y1} C ${cx1} ${cy1}, ${cx2} ${cy2}, ${x2} ${y2}`;
                } else {
                    const vertDelta = y2 >= y1 ? 50 : -50;
                    pathD = `M ${x1} ${y1} C ${x1 + 60} ${y1 + vertDelta}, ${x2 - 60} ${y2 - vertDelta}, ${x2} ${y2}`;
                }

                const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
                path.setAttribute('d', pathD);
                path.setAttribute('class', 's-svg-path');
                path.setAttribute('data-relation', handleId);
                svg.appendChild(path);

                // Hover interactions
                const sourceRow = outDot.closest('.s-node-row');
                const targetRow = inDot.closest('.s-node-row');
                const sourceNode = outDot.closest('.s-node');
                const targetNode = inDot.closest('.s-node');

                function activate() {
                    svg.classList.add('has-active');
                    path.classList.add('active');
                }
                function deactivate() {
                    svg.classList.remove('has-active');
                    path.classList.remove('active');
                }

                [sourceRow, targetRow].forEach(row => {
                    if (!row) return;
                    row.addEventListener('mouseenter', activate);
                    row.addEventListener('mouseleave', deactivate);
                });

                [sourceNode, targetNode].forEach(node => {
                    if (!node || node.dataset.hasConnHover) return;
                    node.dataset.hasConnHover = "true";
                    node.addEventListener('mouseenter', () => {
                        svg.classList.add('has-active');
                        const handles = Array.from(node.querySelectorAll('[data-handle]')).map(h => h.getAttribute('data-handle'));
                        const targets = Array.from(node.querySelectorAll('[data-handle-target]')).map(h => h.getAttribute('data-handle-target'));
                        svg.querySelectorAll('.s-svg-path').forEach(p => {
                            const rel = p.getAttribute('data-relation');
                            if (handles.includes(rel) || targets.includes(rel)) {
                                p.classList.add('active');
                            }
                        });
                    });
                    node.addEventListener('mouseleave', () => {
                        svg.classList.remove('has-active');
                        svg.querySelectorAll('.s-svg-path.active').forEach(p => p.classList.remove('active'));
                    });
                });
            });
        });
    }

    // Initial render & resize handler
    setTimeout(renderConnections, 200);
    window.addEventListener('resize', renderConnections);
}

// --- Init ---
document.addEventListener('DOMContentLoaded', () => {
    setTheme(getTheme());

    const themeBtn = document.getElementById('themeToggle');
    if (themeBtn) themeBtn.addEventListener('click', toggleTheme);

    initSidebar();
    initMobileSidebar();
    initSupabaseERDCanvas();
});

