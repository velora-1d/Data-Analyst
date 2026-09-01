// ============================================================
// SQL Data Analyst — Shared Script
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

// --- Init ---
document.addEventListener('DOMContentLoaded', () => {
    setTheme(getTheme());

    const themeBtn = document.getElementById('themeToggle');
    if (themeBtn) themeBtn.addEventListener('click', toggleTheme);

    initSidebar();
});
