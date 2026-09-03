// ============================================================
// Fundamental Coding — Shared Script (SPA Smooth Navigation)
// ============================================================

const THEME_KEY = 'sql-da-theme';

// Immediate theme execution to prevent dark/light flash (FOUT)
(function () {
    try {
        const theme = localStorage.getItem(THEME_KEY) || 'dark';
        document.documentElement.setAttribute('data-theme', theme);
    } catch (e) {}
})();

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
let sidebarObserver = null;
function initSidebar() {
    if (sidebarObserver) {
        sidebarObserver.disconnect();
        sidebarObserver = null;
    }
    const sections  = document.querySelectorAll('section[id]');
    const navLinks  = document.querySelectorAll('.nav-link[href^="#"]');
    if (!sections.length || !navLinks.length) return;

    sidebarObserver = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const id = entry.target.id;
                navLinks.forEach(link => {
                    link.classList.toggle('active', link.getAttribute('href') === '#' + id);
                });
            }
        });
    }, { rootMargin: `-${60}px 0px -55% 0px`, threshold: 0 });

    sections.forEach(s => sidebarObserver.observe(s));
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
        toggleBtn.onclick = (e) => {
            e.stopPropagation();
            sidebar.classList.contains('open') ? closeSidebar() : openSidebar();
        };
    }

    if (overlay) {
        overlay.onclick = closeSidebar;
    }

    const navLinks = sidebar.querySelectorAll('a');
    navLinks.forEach(link => {
        link.onclick = () => {
            if (window.innerWidth <= 820) {
                closeSidebar();
            }
        };
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

// ============================================================
// ============================================================
// DYNAMIC MULTI-TRACK SIDEBAR LOADER (UNIFIED DASHBOARD)
// ============================================================
let navDataCache = null;

function getRootPrefix() {
    const p = window.location.pathname.replace(/\\/g, '/');
    if (p.includes('/tracks/')) {
        return '../../';
    }
    if (p.includes('/modul/')) {
        return '../';
    }
    return '';
}

async function loadNavData() {
    if (navDataCache) return navDataCache;
    try {
        const fetchPath = getRootPrefix() + 'assets/nav-data.json?v=2.5.0';
        const res = await fetch(fetchPath);
        if (res.ok) {
            navDataCache = await res.json();
            return navDataCache;
        }
    } catch (e) {
        console.warn('Could not load nav-data.json:', e);
    }
    return null;
}

function initHeaderBrand() {
    const headerLeft = document.querySelector('.header-left');
    if (headerLeft && !headerLeft.querySelector('.header-brand-author')) {
        const brandBadge = document.createElement('div');
        brandBadge.className = 'header-brand-author';
        brandBadge.innerHTML = `
            <span class="brand-pill"><i class="fa-solid fa-shield-halved"></i> Velora</span>
            <span class="brand-divider">•</span>
            <span class="author-pill"><i class="fa-solid fa-user-graduate"></i> Mahin Utsman Nawawi, S.H</span>
        `;
        const logo = headerLeft.querySelector('.logo');
        if (logo && logo.nextSibling) {
            headerLeft.insertBefore(brandBadge, logo.nextSibling);
        } else {
            headerLeft.appendChild(brandBadge);
        }
    }
}

function initFavicon() {
    let link = document.querySelector("link[rel~='icon']");
    if (!link) {
        link = document.createElement('link');
        link.rel = 'icon';
        link.type = 'image/svg+xml';
        document.head.appendChild(link);
    }
    const prefix = getRootPrefix();
    link.href = prefix + 'assets/favicon.svg?v=2.5.0';
}

async function initDynamicMultiTrackSidebar() {
    let container = document.getElementById('dynamicSidebarNav');
    if (!container) {
        const oldList = document.querySelector('.sidebar-module-list');
        if (oldList) {
            container = document.createElement('div');
            container.id = 'dynamicSidebarNav';
            oldList.parentNode.replaceChild(container, oldList);
        }
    }
    if (!container) return;

    const data = await loadNavData();
    if (!data || !data.tracks) return;

    const prefix = getRootPrefix();
    function normalizePageName(str) {
        return (str || '').split('/').pop().toLowerCase().replace(/\.html$/, '');
    }

    const currentPath = window.location.pathname.replace(/\\/g, '/');
    const cleanCurrent = normalizePageName(currentPath);
    const isHomePage = (cleanCurrent === '' || cleanCurrent === 'index');

    const TRACK_STATE_KEY = 'velora-track-accordions-v2';
    let userTrackPrefs = {};
    try {
        userTrackPrefs = JSON.parse(localStorage.getItem(TRACK_STATE_KEY) || '{}');
    } catch (e) {}

    const fragment = document.createDocumentFragment();

    // Quick Utility Navigation (Portal Utama & Kamus Perintah)
    const quickNav = document.createElement('div');
    quickNav.className = 'sidebar-quick-nav';
    quickNav.innerHTML = `
        <a href="${prefix}index.html" class="quick-nav-link ${isHomePage ? 'active' : ''}">
            <i class="fa-solid fa-house"></i>
            <span>Portal Utama</span>
        </a>
        <a href="${prefix}cheatsheet.html" class="quick-nav-link ${cleanCurrent === 'cheatsheet' ? 'active' : ''}">
            <i class="fa-solid fa-terminal"></i>
            <span>Kamus Perintah (Git & CLI)</span>
        </a>
    `;
    fragment.appendChild(quickNav);

    const accordionWrapper = document.createElement('div');
    accordionWrapper.className = 'sidebar-track-accordion';

    data.tracks.forEach((track, idx) => {
        const item = document.createElement('div');
        item.className = 'track-accordion-item';

        const isCurrentTrack = track.modules && track.modules.some(m => {
            return cleanCurrent === normalizePageName(m.url);
        });

        // Tentukan apakah accordion dibuka:
        let shouldExpand = false;
        if (userTrackPrefs[track.id] !== undefined) {
            shouldExpand = userTrackPrefs[track.id];
            // Jika sedang berada di modul track ini, pastikan tetap terbuka agar user tahu posisinya
            if (isCurrentTrack) shouldExpand = true;
        } else {
            // Default awal: Buka hanya track yang sedang aktif, atau track 1 jika di homepage
            shouldExpand = isCurrentTrack || (idx === 0 && isHomePage);
        }

        if (shouldExpand) {
            item.classList.add('expanded');
        }

        const btn = document.createElement('button');
        btn.className = `track-accordion-btn ${isCurrentTrack ? 'active' : ''}`;
        btn.type = 'button';
        btn.innerHTML = `
            <span class="track-accordion-title">
                <i class="${track.icon} track-accordion-icon"></i>
                <span class="track-name-text">${track.title}</span>
            </span>
            <i class="fa-solid fa-chevron-down track-accordion-chevron"></i>
        `;

        btn.addEventListener('click', (e) => {
            e.preventDefault();
            const nowExpanded = item.classList.toggle('expanded');
            userTrackPrefs[track.id] = nowExpanded;
            try {
                localStorage.setItem(TRACK_STATE_KEY, JSON.stringify(userTrackPrefs));
            } catch (err) {}
        });

        const content = document.createElement('div');
        content.className = 'track-accordion-content';

        if (track.modules && track.modules.length > 0) {
            track.modules.forEach((mod) => {
                const link = document.createElement('a');
                link.href = prefix + mod.url;
                link.className = 'sidebar-module-link';

                const modFileName = normalizePageName(mod.url);
                const isCurrentMod = (cleanCurrent === modFileName);

                if (isCurrentMod) {
                    link.classList.add('current');
                }

                // Shorten module label
                let cleanTitle = mod.title
                    .replace(/^Modul \d+:\s*/i, '')
                    .replace(/^Fase \d+:\s*/i, '');

                const isCheatsheet = mod.url.includes('cheatsheet');
                const bulletIcon = isCheatsheet 
                    ? '<i class="fa-solid fa-terminal mod-link-bullet" style="color:var(--brand);font-size:0.75rem;"></i>' 
                    : '<i class="fa-solid fa-angle-right mod-link-bullet"></i>';

                link.innerHTML = `
                    ${bulletIcon}
                    <span class="mod-title-text">${cleanTitle}</span>
                `;
                content.appendChild(link);
            });
        }

        item.appendChild(btn);
        item.appendChild(content);
        accordionWrapper.appendChild(item);
    });

    fragment.appendChild(accordionWrapper);
    container.innerHTML = '';
    container.appendChild(fragment);

    // Scroll active module into view smoothly in sidebar
    const activeLink = container.querySelector('.sidebar-module-link.current');
    if (activeLink) {
        setTimeout(() => {
            activeLink.scrollIntoView({ block: 'nearest', behavior: 'smooth' });
        }, 150);
    }
}

// --- Page Lifecycle Re-initialization ---
function reinitPage() {
    setTheme(getTheme());

    const themeBtn = document.getElementById('themeToggle');
    if (themeBtn) {
        themeBtn.onclick = toggleTheme;
    }

    initSidebar();
    initMobileSidebar();
    initHeaderBrand();
    initFavicon();
    initDynamicMultiTrackSidebar();
    initSupabaseERDCanvas();
    idlePrefetchLinks();
}

// ============================================================
// Instant Seamless Page Router (Zero Reload, Zero Flicker)
// ============================================================
const pageCache = new Map();

function prefetchUrl(url) {
    if (!url || pageCache.has(url)) return;
    fetch(url, { priority: 'low' })
        .then(res => {
            if (!res.ok) throw new Error('Prefetch failed');
            return res.text();
        })
        .then(html => {
            pageCache.set(url, html);
        })
        .catch(() => {});
}

function idlePrefetchLinks() {
    const prefetchTargets = () => {
        const links = document.querySelectorAll('.sidebar-module-link, .module-card, .module-nav a, .mod-nav-footer a, .hero-actions a');
        links.forEach(link => {
            try {
                if (link.hasAttribute('download') || link.target === '_blank') return;
                const u = new URL(link.href, window.location.href);
                if (u.origin === window.location.origin && u.pathname !== window.location.pathname) {
                    prefetchUrl(u.href);
                }
            } catch(e) {}
        });
    };

    if ('requestIdleCallback' in window) {
        window.requestIdleCallback(prefetchTargets);
    } else {
        setTimeout(prefetchTargets, 500);
    }
}

async function navigateTo(url, push = true) {
    try {
        let html = pageCache.get(url);
        if (!html) {
            const res = await fetch(url);
            if (!res.ok) throw new Error('Failed to fetch page');
            html = await res.text();
            pageCache.set(url, html);
        }

        const parser = new DOMParser();
        const newDoc = parser.parseFromString(html, 'text/html');

        // Update document title
        document.title = newDoc.title;

        // Instant DOM swap without unloading document
        const updateDOM = () => {
            document.body.innerHTML = newDoc.body.innerHTML;
            reinitPage();
        };

        if (document.startViewTransition) {
            document.startViewTransition(updateDOM);
        } else {
            updateDOM();
        }

        if (push) {
            history.pushState({ url }, '', url);
        }

        // Handle scrolling to hash anchor or reset to top cleanly
        const targetUrlObj = new URL(url, window.location.href);
        if (targetUrlObj.hash) {
            const el = document.querySelector(targetUrlObj.hash);
            if (el) {
                el.scrollIntoView();
            }
        } else {
            window.scrollTo({ top: 0, left: 0, behavior: 'instant' });
        }
    } catch (err) {
        console.warn('Seamless navigation fallback to native reload:', err);
        window.location.href = url;
    }
}

// Global click interceptor for internal links
document.addEventListener('click', e => {
    // Only handle primary button clicks without modifier keys
    if (e.button !== 0 || e.ctrlKey || e.metaKey || e.shiftKey || e.altKey) return;

    const link = e.target.closest('a');
    if (!link) return;

    if (link.hasAttribute('download') || link.target === '_blank') return;

    const href = link.getAttribute('href');
    if (!href || href.startsWith('mailto:') || href.startsWith('tel:') || href.startsWith('javascript:')) return;

    // Anchor link on current page: let native smooth scrolling handle it
    if (href.startsWith('#')) return;

    try {
        const urlObj = new URL(link.href, window.location.href);
        if (urlObj.origin !== window.location.origin) return;

        // If same pathname and hash: let anchor handle it
        if (urlObj.pathname === window.location.pathname) return;

        e.preventDefault();
        navigateTo(urlObj.href, true);
    } catch (err) {}
});

// Prefetch on hover and touch (0ms instant transition when clicked)
document.addEventListener('mouseover', e => {
    const link = e.target.closest('a');
    if (!link || link.hasAttribute('download') || link.target === '_blank') return;
    const href = link.getAttribute('href');
    if (!href || href.startsWith('#') || href.startsWith('mailto:') || href.startsWith('tel:')) return;

    try {
        const urlObj = new URL(link.href, window.location.href);
        if (urlObj.origin === window.location.origin && urlObj.pathname !== window.location.pathname) {
            prefetchUrl(urlObj.href);
        }
    } catch (err) {}
}, { passive: true });

document.addEventListener('touchstart', e => {
    const link = e.target.closest('a');
    if (!link || link.hasAttribute('download') || link.target === '_blank') return;
    const href = link.getAttribute('href');
    if (!href || href.startsWith('#')) return;

    try {
        const urlObj = new URL(link.href, window.location.href);
        if (urlObj.origin === window.location.origin && urlObj.pathname !== window.location.pathname) {
            prefetchUrl(urlObj.href);
        }
    } catch (err) {}
}, { passive: true });

// Handle Browser Back / Forward buttons seamlessly
window.addEventListener('popstate', () => {
    navigateTo(window.location.href, false);
});

// Initial boot
document.addEventListener('DOMContentLoaded', () => {
    reinitPage();
});

