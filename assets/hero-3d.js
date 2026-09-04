/**
 * Fundamental Coding - Authentic 3D Software Engineering Core & Technology Badges
 * Built with Three.js (r128) - Lightweight, High-Performance, Mobile-Optimized
 * UI/UX Pro Max & Impeccable Design Guidelines Compliant
 */

(function () {
    'use strict';

    const container = document.getElementById('hero-3d-viewport');
    if (!container) return;

    // Check for WebGL support
    function hasWebGL() {
        try {
            const canvas = document.createElement('canvas');
            return !!(window.WebGLRenderingContext && (canvas.getContext('webgl') || canvas.getContext('experimental-webgl')));
        } catch (e) {
            return false;
        }
    }

    if (!hasWebGL() || typeof THREE === 'undefined') {
        container.innerHTML = `
            <div class="hero-3d-fallback">
                <div class="fallback-cube">
                    <i class="fa-solid fa-code"></i>
                </div>
            </div>
        `;
        return;
    }

    // Add Interactive Tooltip Element inside container
    let tooltip = container.querySelector('.hero-3d-hover-tooltip');
    if (!tooltip) {
        tooltip = document.createElement('div');
        tooltip.className = 'hero-3d-hover-tooltip';
        tooltip.style.cssText = `
            position: absolute;
            bottom: 14px;
            left: 50%;
            transform: translateX(-50%) translateY(10px);
            background: rgba(15, 23, 42, 0.95);
            color: #FFFFFF;
            border: 1px solid rgba(96, 165, 250, 0.5);
            padding: 7px 16px;
            border-radius: 9999px;
            font-size: 0.78rem;
            font-weight: 700;
            pointer-events: none;
            opacity: 0;
            transition: opacity 0.2s ease, transform 0.2s ease;
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            white-space: nowrap;
            z-index: 10;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.4);
        `;
        container.appendChild(tooltip);
    }

    // Scene Setup
    const scene = new THREE.Scene();
    const isMobile = window.innerWidth <= 768;

    const camera = new THREE.PerspectiveCamera(45, container.clientWidth / container.clientHeight, 0.1, 1000);
    camera.position.z = isMobile ? 13.5 : 11.2;
    camera.position.y = 0.3;

    const renderer = new THREE.WebGLRenderer({
        antialias: !isMobile,
        alpha: true,
        powerPreference: 'high-performance'
    });
    renderer.setSize(container.clientWidth, container.clientHeight);
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, isMobile ? 1 : 1.5));
    renderer.toneMapping = THREE.ACESFilmicToneMapping;
    renderer.toneMappingExposure = 1.15;
    container.appendChild(renderer.domElement);

    // Color Palette Tokens (User Preferences: Electric Blue & Sky Cyan, NO PURPLE)
    const isDark = () => document.documentElement.getAttribute('data-theme') !== 'light';
    const getColors = () => {
        const dark = isDark();
        return {
            primary: dark ? 0x3B82F6 : 0x2563EB,
            secondary: dark ? 0x60A5FA : 0x1D4ED8,
            accent: dark ? 0x38BDF8 : 0x0284C7,
            core: dark ? 0x1E3A8A : 0x2563EB,
            wireframe: dark ? 0x93C5FD : 0x1E40AF,
            points: dark ? 0x93C5FD : 0x3B82F6,
            ambient: dark ? 0x475569 : 0x94A3B8,
            light: dark ? 0xFFFFFF : 0xE2E8F0
        };
    };

    let colors = getColors();

    // Lighting
    const ambientLight = new THREE.AmbientLight(colors.ambient, 2.2);
    scene.add(ambientLight);

    const mainLight = new THREE.DirectionalLight(0xFFFFFF, 2.8);
    mainLight.position.set(6, 9, 7);
    scene.add(mainLight);

    const rimLight = new THREE.DirectionalLight(0x38BDF8, 2.2);
    rimLight.position.set(-7, -4, -4);
    scene.add(rimLight);

    const pointLight = new THREE.PointLight(0x3B82F6, 4, 18);
    pointLight.position.set(0, 0, 0);
    scene.add(pointLight);

    // Main 3D System Group
    const systemGroup = new THREE.Group();
    scene.add(systemGroup);

    // 1. Central Silicon CPU & Code Processor Monolith
    // Central Silicon Die Box with Code Texture
    function createCpuTexture(dark) {
        const size = 256;
        const canvas = document.createElement('canvas');
        canvas.width = size;
        canvas.height = size;
        const ctx = canvas.getContext('2d');

        ctx.fillStyle = dark ? '#0A1128' : '#1E293B';
        ctx.fillRect(0, 0, size, size);

        // Grid of micro-circuit traces
        ctx.strokeStyle = dark ? 'rgba(59, 130, 246, 0.35)' : 'rgba(96, 165, 250, 0.45)';
        ctx.lineWidth = 2;
        for (let i = 24; i < size; i += 24) {
            ctx.beginPath();
            ctx.moveTo(i, 0); ctx.lineTo(i, size);
            ctx.moveTo(0, i); ctx.lineTo(size, i);
            ctx.stroke();
        }

        // Center Silicon Core Monogram
        ctx.fillStyle = dark ? '#0F172A' : '#0F172A';
        ctx.fillRect(48, 48, size - 96, size - 96);
        ctx.strokeStyle = '#38BDF8';
        ctx.lineWidth = 4;
        ctx.strokeRect(48, 48, size - 96, size - 96);

        // Glowing Code Tag </ >
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.font = '900 68px "JetBrains Mono", monospace';
        ctx.fillStyle = '#60A5FA';
        ctx.fillText('</>', size / 2, size / 2 - 8);

        ctx.font = 'bold 20px "JetBrains Mono", monospace';
        ctx.fillStyle = '#38BDF8';
        ctx.fillText('CORE CPU', size / 2, size / 2 + 42);

        const tex = new THREE.CanvasTexture(canvas);
        return tex;
    }

    const cpuTex = createCpuTexture(isDark());
    const cpuMat = new THREE.MeshStandardMaterial({
        map: cpuTex,
        roughness: 0.3,
        metalness: 0.75
    });
    const cpuGeo = new THREE.BoxGeometry(1.6, 1.6, 1.6);
    const cpuMesh = new THREE.Mesh(cpuGeo, cpuMat);
    systemGroup.add(cpuMesh);

    // Outer Faceted Crystal Wireframe Sphere Cage
    const wireframeGeo = new THREE.IcosahedronGeometry(2.1, 1);
    const wireframeMat = new THREE.MeshBasicMaterial({
        color: colors.wireframe,
        wireframe: true,
        transparent: true,
        opacity: 0.4
    });
    const wireframeMesh = new THREE.Mesh(wireframeGeo, wireframeMat);
    systemGroup.add(wireframeMesh);

    // 2. Orbital Tech Rings
    function createOrbitRing(radius, tube, rotX, rotY, color) {
        const ringGeo = new THREE.TorusGeometry(radius, tube, 16, 120);
        const ringMat = new THREE.MeshBasicMaterial({
            color: color,
            transparent: true,
            opacity: 0.35
        });
        const ring = new THREE.Mesh(ringGeo, ringMat);
        ring.rotation.x = rotX;
        ring.rotation.y = rotY;
        return ring;
    }

    const ring1 = createOrbitRing(3.3, 0.02, Math.PI / 3, 0.25, colors.secondary);
    const ring2 = createOrbitRing(4.3, 0.02, -Math.PI / 3.4, -0.35, colors.accent);
    const ring3 = createOrbitRing(5.3, 0.015, Math.PI / 2.3, 0.75, colors.primary);
    systemGroup.add(ring1);
    systemGroup.add(ring2);
    systemGroup.add(ring3);

    // 3. Official Vector SVG Logo Cache & Texture Generator
    const loadedIcons = {};

    // 4. Authentic Developer Technology Badges (12 Core Engineering Stacks with Official SVG Logos)
    // Distinctive, official brand colors: Postgres, TS, Git, Redis, JS, Python, Docker, Linux, Go, K8s, React, Node
    // Strictly NO PURPLE, rich in blues, cyans, emeralds, golds, and reds
    const tokenData = [
        // Ring 1: Inner Data & Systems Core (Radius = 3.3, Speed = +0.011)
        {
            name: 'PostgreSQL',
            symbol: 'SQL',
            label: 'POSTGRESQL',
            iconFile: 'postgres.svg',
            fullName: 'Track 01: Relational DB & SQL Internals',
            brandHexStr: '#38BDF8', // Official Postgres Sapphire/Cyan
            brandHex: 0x38BDF8,
            bgTintDark: 'rgba(56, 189, 248, 0.16)',
            bgTintLight: 'rgba(56, 189, 248, 0.12)',
            radius: 3.3,
            speed: 0.011,
            offset: 0,
            url: '#tracksGrid'
        },
        {
            name: 'TypeScript',
            symbol: 'TS',
            label: 'TYPESCRIPT',
            iconFile: 'typescript.svg',
            fullName: 'Track 04: Type Systems & Data Structures',
            brandHexStr: '#3178C6', // Official TypeScript Royal Blue
            brandHex: 0x3178C6,
            bgTintDark: 'rgba(49, 120, 198, 0.16)',
            bgTintLight: 'rgba(49, 120, 198, 0.12)',
            radius: 3.3,
            speed: 0.011,
            offset: Math.PI / 2,
            url: 'tracks/04_data_structures_algorithms/01_linear_ds_arrays_lists.html'
        },
        {
            name: 'Git',
            symbol: 'GIT',
            label: 'GIT',
            iconFile: 'git.svg',
            fullName: 'Track 08: Git Internals & Content Storage',
            brandHexStr: '#EF4444', // Official Git Coral Red
            brandHex: 0xEF4444,
            bgTintDark: 'rgba(239, 68, 68, 0.16)',
            bgTintLight: 'rgba(239, 68, 68, 0.12)',
            radius: 3.3,
            speed: 0.011,
            offset: Math.PI,
            url: 'tracks/07_runtimes_memory/03_git_internals_advanced.html'
        },
        {
            name: 'Redis',
            symbol: 'REDIS',
            label: 'REDIS',
            iconFile: 'redis.svg',
            fullName: 'Track 01: In-Memory Caching & Redis Protocol',
            brandHexStr: '#DC2626', // Official Redis Crimson
            brandHex: 0xDC2626,
            bgTintDark: 'rgba(220, 38, 38, 0.16)',
            bgTintLight: 'rgba(220, 38, 38, 0.12)',
            radius: 3.3,
            speed: 0.011,
            offset: (3 * Math.PI) / 2,
            url: '#tracksGrid'
        },

        // Ring 2: Mid Runtimes & Execution Engines (Radius = 4.3, Speed = -0.0085)
        {
            name: 'JavaScript',
            symbol: 'JS',
            label: 'JAVASCRIPT',
            iconFile: 'javascript.svg',
            fullName: 'Track 07: JavaScript JIT & Garbage Collection',
            brandHexStr: '#F59E0B', // Official JS Vibrant Gold
            brandHex: 0xF59E0B,
            bgTintDark: 'rgba(245, 158, 11, 0.16)',
            bgTintLight: 'rgba(245, 158, 11, 0.12)',
            radius: 4.3,
            speed: -0.0085,
            offset: Math.PI / 4,
            url: 'tracks/07_runtimes_memory/01_v8_event_loop.html'
        },
        {
            name: 'Python',
            symbol: 'PYTHON',
            label: 'PYTHON',
            iconFile: 'python.svg',
            fullName: 'Track 09: Python Bytecode, GIL & Architecture',
            brandHexStr: '#3B82F6', // Official Python Blue
            brandHex: 0x3B82F6,
            bgTintDark: 'rgba(59, 130, 246, 0.16)',
            bgTintLight: 'rgba(59, 130, 246, 0.12)',
            radius: 4.3,
            speed: -0.0085,
            offset: (3 * Math.PI) / 4,
            url: '#tracksGrid'
        },
        {
            name: 'Docker',
            symbol: 'DOCKER',
            label: 'DOCKER',
            iconFile: 'docker.svg',
            fullName: 'Track 06: Linux Namespaces, Cgroups & Docker',
            brandHexStr: '#0284C7', // Official Docker Ocean Blue
            brandHex: 0x0284C7,
            bgTintDark: 'rgba(2, 132, 199, 0.16)',
            bgTintLight: 'rgba(2, 132, 199, 0.12)',
            radius: 4.3,
            speed: -0.0085,
            offset: (5 * Math.PI) / 4,
            url: 'tracks/02_system_design/01_scalability_patterns.html'
        },
        {
            name: 'Linux',
            symbol: 'LINUX',
            label: 'LINUX',
            iconFile: 'linux.svg',
            fullName: 'Track 05: Linux Kernel, POSIX & Bash',
            brandHexStr: '#10B981', // Linux Matrix Green
            brandHex: 0x10B981,
            bgTintDark: 'rgba(16, 185, 129, 0.16)',
            bgTintLight: 'rgba(16, 185, 129, 0.12)',
            radius: 4.3,
            speed: -0.0085,
            offset: (7 * Math.PI) / 4,
            url: 'tracks/03_network_protocols/01_osi_tcp_udp.html'
        },

        // Ring 3: Outer Distributed Networks & Cloud Architecture (Radius = 5.3, Speed = +0.0065)
        {
            name: 'Golang',
            symbol: 'GO',
            label: 'GOLANG',
            iconFile: 'go.svg',
            fullName: 'Track 04: Go Concurrency, CSP & Channels',
            brandHexStr: '#00ADD8', // Official Go Gopher Cyan
            brandHex: 0x00ADD8,
            bgTintDark: 'rgba(0, 173, 216, 0.16)',
            bgTintLight: 'rgba(0, 173, 216, 0.12)',
            radius: 5.3,
            speed: 0.0065,
            offset: Math.PI / 6,
            url: '#tracksGrid'
        },
        {
            name: 'Kubernetes',
            symbol: 'K8S',
            label: 'KUBERNETES',
            iconFile: 'kubernetes.svg',
            fullName: 'Track 06: Distributed Systems & Kubernetes',
            brandHexStr: '#2563EB', // Official K8s Helm Blue
            brandHex: 0x2563EB,
            bgTintDark: 'rgba(37, 99, 235, 0.16)',
            bgTintLight: 'rgba(37, 99, 235, 0.12)',
            radius: 5.3,
            speed: 0.0065,
            offset: (2 * Math.PI) / 3,
            url: '#tracksGrid'
        },
        {
            name: 'React',
            symbol: 'REACT',
            label: 'REACT',
            iconFile: 'react.svg',
            fullName: 'Track 02: Browser Rendering Pipeline & Fiber Tree',
            brandHexStr: '#06B6D4', // Official React Atom Cyan
            brandHex: 0x06B6D4,
            bgTintDark: 'rgba(6, 182, 212, 0.16)',
            bgTintLight: 'rgba(6, 182, 212, 0.12)',
            radius: 5.3,
            speed: 0.0065,
            offset: (7 * Math.PI) / 6,
            url: 'tracks/02_frontend/01_rendering_pipeline.html'
        },
        {
            name: 'Node.js',
            symbol: 'NODE',
            label: 'NODE.JS',
            iconFile: 'nodejs.svg',
            fullName: 'Track 07: Node.js, Libuv & Thread Pool Architecture',
            brandHexStr: '#22C55E', // Official Node.js Emerald Green
            brandHex: 0x22C55E,
            bgTintDark: 'rgba(34, 197, 94, 0.16)',
            bgTintLight: 'rgba(34, 197, 94, 0.12)',
            radius: 5.3,
            speed: 0.0065,
            offset: (5 * Math.PI) / 3,
            url: 'tracks/07_runtimes_memory/01_v8_event_loop.html'
        }
    ];

    // Preload official SVG logos into memory
    tokenData.forEach(token => {
        const img = new Image();
        img.src = `assets/icons/tech/${token.iconFile}`;
        img.onload = () => { loadedIcons[token.iconFile] = img; };
    });

    function createTechBadgeTexture(token, dark) {
        const size = 256;
        const canvas = document.createElement('canvas');
        canvas.width = size;
        canvas.height = size;
        const ctx = canvas.getContext('2d');

        const center = size / 2;
        const radius = size * 0.44;

        const texture = new THREE.CanvasTexture(canvas);
        texture.generateMipmaps = true;
        texture.minFilter = THREE.LinearMipmapLinearFilter;

        function drawBadge() {
            ctx.clearRect(0, 0, size, size);

            // Circular background disc
            ctx.beginPath();
            ctx.arc(center, center, radius, 0, Math.PI * 2);
            ctx.fillStyle = dark ? '#0B132B' : '#FFFFFF';
            ctx.fill();

            // Thick distinct brand border
            ctx.lineWidth = 10;
            ctx.strokeStyle = token.brandHexStr;
            ctx.stroke();

            // Inner soft tinted surface
            ctx.beginPath();
            ctx.arc(center, center, radius - 7, 0, Math.PI * 2);
            ctx.fillStyle = dark ? token.bgTintDark : token.bgTintLight;
            ctx.fill();

            // Inner subtle concentric border
            ctx.beginPath();
            ctx.arc(center, center, radius - 16, 0, Math.PI * 2);
            ctx.strokeStyle = dark ? 'rgba(255, 255, 255, 0.09)' : 'rgba(0, 0, 0, 0.06)';
            ctx.lineWidth = 1.5;
            ctx.stroke();

            // Draw Real Official SVG Logo
            const iconImg = loadedIcons[token.iconFile];
            if (iconImg && iconImg.complete && iconImg.naturalWidth !== 0) {
                const iconSize = 92;
                ctx.drawImage(
                    iconImg,
                    center - iconSize / 2,
                    center - iconSize / 2 - 16,
                    iconSize,
                    iconSize
                );
            } else {
                // High-fidelity fallback text while SVG is finishing decode
                ctx.textAlign = 'center';
                ctx.textBaseline = 'middle';
                const symLen = token.symbol.length;
                const fontSize = symLen <= 2 ? 62 : symLen === 3 ? 50 : 38;
                ctx.font = `900 ${fontSize}px "JetBrains Mono", monospace`;
                ctx.fillStyle = token.brandHexStr;
                ctx.fillText(token.symbol, center, center - 14);
            }

            // Official Technology Name Sub-Label
            ctx.textAlign = 'center';
            ctx.textBaseline = 'middle';
            ctx.font = '800 18px "Inter", -apple-system, sans-serif';
            ctx.fillStyle = dark ? '#F8FAFC' : '#0F172A';
            ctx.fillText(token.label, center, center + 48);

            texture.needsUpdate = true;
        }

        const iconImg = loadedIcons[token.iconFile];
        if (iconImg && iconImg.complete) {
            drawBadge();
        } else {
            const img = new Image();
            img.src = `assets/icons/tech/${token.iconFile}`;
            img.onload = () => {
                loadedIcons[token.iconFile] = img;
                drawBadge();
            };
            drawBadge();
        }

        return texture;
    }

    const satelliteTokens = [];
    const interactiveMeshes = [];

    function buildTokens() {
        // Clear previous
        satelliteTokens.forEach(st => systemGroup.remove(st.group));
        satelliteTokens.length = 0;
        interactiveMeshes.length = 0;

        const dark = isDark();

        tokenData.forEach((token) => {
            const tokenGroup = new THREE.Group();
            const innerRotator = new THREE.Group();
            tokenGroup.add(innerRotator);

            const badgeRadius = 0.52;
            const badgeDepth = 0.08;

            const badgeTex = createTechBadgeTexture(token, dark);

            // Front Face Circle (normal +Z points towards camera)
            const frontGeo = new THREE.CircleGeometry(badgeRadius, 32);
            const frontMat = new THREE.MeshBasicMaterial({
                map: badgeTex,
                side: THREE.FrontSide
            });
            const frontMesh = new THREE.Mesh(frontGeo, frontMat);
            frontMesh.position.z = badgeDepth / 2;
            frontMesh.userData = { data: token };
            innerRotator.add(frontMesh);

            // Back Face Circle (normal -Z)
            const backGeo = new THREE.CircleGeometry(badgeRadius, 32);
            const backMat = new THREE.MeshBasicMaterial({
                map: badgeTex,
                side: THREE.FrontSide
            });
            const backMesh = new THREE.Mesh(backGeo, backMat);
            backMesh.position.z = -badgeDepth / 2;
            backMesh.rotation.y = Math.PI;
            backMesh.userData = { data: token };
            innerRotator.add(backMesh);

            // Metallic Outer Rim Cylinder (Connecting front and back)
            const rimGeo = new THREE.CylinderGeometry(badgeRadius, badgeRadius, badgeDepth, 32, 1, true);
            const rimMat = new THREE.MeshStandardMaterial({
                color: token.brandHex,
                metalness: 0.85,
                roughness: 0.2
            });
            const rimMesh = new THREE.Mesh(rimGeo, rimMat);
            rimMesh.rotation.x = Math.PI / 2;
            innerRotator.add(rimMesh);

            // Colored Glowing Aura Halo Ring
            const auraGeo = new THREE.RingGeometry(badgeRadius + 0.02, badgeRadius + 0.07, 32);
            const auraMat = new THREE.MeshBasicMaterial({
                color: token.brandHex,
                side: THREE.DoubleSide,
                transparent: true,
                opacity: 0.6
            });
            const auraMesh = new THREE.Mesh(auraGeo, auraMat);
            innerRotator.add(auraMesh);

            systemGroup.add(tokenGroup);
            interactiveMeshes.push(frontMesh);
            interactiveMeshes.push(backMesh);

            satelliteTokens.push({
                group: tokenGroup,
                inner: innerRotator,
                mesh: frontMesh,
                data: token,
                angle: token.offset,
                targetScale: 1
            });
        });
    }

    buildTokens();

    // 5. Floating Code Syntax Snippet Badges
    // Real code floating around the architecture core
    const codeSnippets = [
        'SELECT * FROM db;',
        'async/await v8',
        'git commit -m "feat"',
        'docker run -d -p 80',
        '200 OK • HTTP/3',
        'O(log N) B-Tree',
        'go func() { chan <- x }',
        'kubectl apply -f app.yml'
    ];

    const floatingCodeNodes = [];

    function createCodePillTexture(text, dark) {
        const canvas = document.createElement('canvas');
        canvas.width = 256;
        canvas.height = 64;
        const ctx = canvas.getContext('2d');

        ctx.fillStyle = dark ? 'rgba(15, 23, 42, 0.85)' : 'rgba(241, 245, 249, 0.9)';
        ctx.roundRect(4, 4, 248, 56, 28);
        ctx.fill();

        ctx.strokeStyle = dark ? 'rgba(96, 165, 250, 0.4)' : 'rgba(37, 99, 235, 0.3)';
        ctx.lineWidth = 2;
        ctx.stroke();

        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.font = '600 19px "JetBrains Mono", monospace';
        ctx.fillStyle = dark ? '#93C5FD' : '#1E40AF';
        ctx.fillText(text, 128, 32);

        const tex = new THREE.CanvasTexture(canvas);
        return tex;
    }

    codeSnippets.forEach((snippet, idx) => {
        const pillGroup = new THREE.Group();
        const pillGeo = new THREE.PlaneGeometry(1.15, 0.28);
        const pillTex = createCodePillTexture(snippet, isDark());
        const pillMat = new THREE.MeshBasicMaterial({
            map: pillTex,
            transparent: true,
            opacity: 0.82
        });
        const pillMesh = new THREE.Mesh(pillGeo, pillMat);
        pillGroup.add(pillMesh);

        systemGroup.add(pillGroup);

        floatingCodeNodes.push({
            group: pillGroup,
            radius: 2.3 + (idx % 3) * 0.35,
            speed: 0.007 * (idx % 2 === 0 ? 1 : -1),
            angle: (idx * Math.PI) / 4,
            yOffset: ((idx - 3.5) * 0.35)
        });
    });

    // 6. Ambient Particle Stars
    const particleCount = isMobile ? 120 : 250;
    const particleGeo = new THREE.BufferGeometry();
    const particlePositions = new Float32Array(particleCount * 3);

    for (let i = 0; i < particleCount * 3; i += 3) {
        particlePositions[i] = (Math.random() - 0.5) * 22;
        particlePositions[i + 1] = (Math.random() - 0.5) * 16;
        particlePositions[i + 2] = (Math.random() - 0.5) * 16;
    }

    particleGeo.setAttribute('position', new THREE.BufferAttribute(particlePositions, 3));
    const particleMat = new THREE.PointsMaterial({
        color: colors.points,
        size: isMobile ? 0.08 : 0.1,
        transparent: true,
        opacity: 0.5,
        blending: THREE.AdditiveBlending
    });
    const particles = new THREE.Points(particleGeo, particleMat);
    scene.add(particles);

    // Interactive Mouse & Touch Dragging + Raycasting
    const raycaster = new THREE.Raycaster();
    const mouseNorm = new THREE.Vector2(-999, -999);

    let mouseX = 0;
    let mouseY = 0;
    let targetRotationX = 0;
    let targetRotationY = 0;
    let isDragging = false;
    let hasDragged = false;
    let previousPointerPosition = { x: 0, y: 0 };
    let hoveredToken = null;

    function onPointerMove(e) {
        const clientX = e.touches ? e.touches[0].clientX : e.clientX;
        const clientY = e.touches ? e.touches[0].clientY : e.clientY;

        const rect = container.getBoundingClientRect();
        const x = ((clientX - rect.left) / rect.width) * 2 - 1;
        const y = -(((clientY - rect.top) / rect.height) * 2 - 1);

        mouseX = x;
        mouseY = y;
        mouseNorm.x = x;
        mouseNorm.y = y;

        if (isDragging) {
            const deltaX = clientX - previousPointerPosition.x;
            const deltaY = clientY - previousPointerPosition.y;

            if (Math.abs(deltaX) > 2 || Math.abs(deltaY) > 2) {
                hasDragged = true;
            }

            targetRotationY += deltaX * 0.007;
            targetRotationX += deltaY * 0.007;

            previousPointerPosition = { x: clientX, y: clientY };
        }
    }

    container.addEventListener('mousedown', (e) => {
        isDragging = true;
        hasDragged = false;
        previousPointerPosition = { x: e.clientX, y: e.clientY };
    });

    window.addEventListener('mouseup', () => { isDragging = false; });
    container.addEventListener('mousemove', onPointerMove);

    container.addEventListener('touchstart', (e) => {
        if (e.touches.length === 1) {
            isDragging = true;
            hasDragged = false;
            previousPointerPosition = { x: e.touches[0].clientX, y: e.touches[0].clientY };
        }
    }, { passive: true });

    window.addEventListener('touchend', () => { isDragging = false; });
    container.addEventListener('touchmove', onPointerMove, { passive: true });

    // Click on 3D Tech Token -> Navigate to Track
    container.addEventListener('click', () => {
        if (hasDragged) return;

        raycaster.setFromCamera(mouseNorm, camera);
        const intersects = raycaster.intersectObjects(interactiveMeshes);

        if (intersects.length > 0) {
            const hit = intersects[0].object;
            const targetUrl = hit.userData.data.url;
            if (targetUrl) {
                if (targetUrl.startsWith('#')) {
                    const targetEl = document.querySelector(targetUrl);
                    if (targetEl) targetEl.scrollIntoView({ behavior: 'smooth' });
                } else {
                    window.location.href = targetUrl;
                }
            }
        }
    });

    // Adaptive Theme Listener
    const themeObserver = new MutationObserver(() => {
        colors = getColors();
        wireframeMat.color.setHex(colors.wireframe);
        particleMat.color.setHex(colors.points);
        ring1.material.color.setHex(colors.secondary);
        ring2.material.color.setHex(colors.accent);
        ring3.material.color.setHex(colors.primary);
        ambientLight.color.setHex(colors.ambient);
        ambientLight.intensity = isDark() ? 2.2 : 2.8;

        cpuMesh.material.map = createCpuTexture(isDark());
        cpuMesh.material.needsUpdate = true;

        buildTokens();
    });

    themeObserver.observe(document.documentElement, { attributes: true, attributeFilter: ['data-theme'] });

    // Viewport Resize Handler
    function onWindowResize() {
        if (!container) return;
        const width = container.clientWidth;
        const height = container.clientHeight;
        if (width === 0 || height === 0) return;

        camera.aspect = width / height;
        camera.position.z = window.innerWidth <= 768 ? 13.5 : 11.2;
        camera.updateProjectionMatrix();
        renderer.setSize(width, height);
    }

    window.addEventListener('resize', onWindowResize);

    // Performance: Pause Animation when Hero is Scrolled Out of View
    let isVisible = true;
    const intersectionObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            isVisible = entry.isIntersecting;
        });
    }, { threshold: 0.05 });
    intersectionObserver.observe(container);

    // Main Animation Loop
    let clock = new THREE.Clock();

    function animate() {
        requestAnimationFrame(animate);

        if (!isVisible) return;

        const delta = clock.getDelta();
        const time = clock.getElapsedTime();

        // Raycasting Hover Detection
        if (!isMobile) {
            raycaster.setFromCamera(mouseNorm, camera);
            const intersects = raycaster.intersectObjects(interactiveMeshes);

            if (intersects.length > 0) {
                const hit = intersects[0].object;
                container.style.cursor = 'pointer';

                satelliteTokens.forEach(st => {
                    if (st.mesh === hit) {
                        st.targetScale = 1.35;
                        if (hoveredToken !== st) {
                            hoveredToken = st;
                            tooltip.innerHTML = `<span style="color:${st.data.brandHexStr};font-weight:900;">${st.data.name || st.data.symbol}</span> • ${st.data.fullName} &rarr;`;
                            tooltip.style.borderColor = st.data.brandHexStr;
                            tooltip.style.opacity = '1';
                            tooltip.style.transform = 'translateX(-50%) translateY(0px)';
                        }
                    } else {
                        st.targetScale = 0.92;
                    }
                });
            } else {
                if (container.style.cursor === 'pointer') {
                    container.style.cursor = 'grab';
                }
                satelliteTokens.forEach(st => { st.targetScale = 1; });
                if (hoveredToken) {
                    hoveredToken = null;
                    tooltip.style.opacity = '0';
                    tooltip.style.transform = 'translateX(-50%) translateY(10px)';
                }
            }
        }

        // Smooth Lerp for Drag and Mouse Parallax
        systemGroup.rotation.y += (targetRotationY + mouseX * 0.35 - systemGroup.rotation.y) * 0.04;
        systemGroup.rotation.x += (targetRotationX - mouseY * 0.25 - systemGroup.rotation.x) * 0.04;

        // Idle Continuous Rotation
        if (!isDragging) {
            targetRotationY += 0.0035;
        }

        // CPU Monolith Rotation
        cpuMesh.rotation.y += 0.004;
        cpuMesh.rotation.x += 0.002;
        wireframeMesh.rotation.y -= 0.005;
        wireframeMesh.rotation.z += 0.002;

        // Orbit Rings Wobble
        ring1.rotation.z += 0.004;
        ring2.rotation.z -= 0.005;
        ring3.rotation.z += 0.003;

        // Update 3D Technology Badges
        satelliteTokens.forEach((token) => {
            token.angle += token.data.speed;
            const r = token.data.radius;
            token.group.position.x = Math.cos(token.angle) * r;
            token.group.position.z = Math.sin(token.angle) * r;
            token.group.position.y = Math.sin(token.angle * 2 + time) * 0.5;

            // Scale lerp for hover
            const curScale = token.group.scale.x;
            const nextScale = curScale + (token.targetScale - curScale) * 0.15;
            token.group.scale.set(nextScale, nextScale, nextScale);

            // GUARANTEE: Front face ALWAYS faces camera directly!
            token.group.quaternion.copy(camera.quaternion);

            // Gentle floating wobble applied only to inner rotator Z
            token.inner.rotation.z = Math.sin(time * 1.5 + token.angle) * 0.08;
        });

        // Update Floating Code Snippet Pills
        floatingCodeNodes.forEach((pill) => {
            pill.angle += pill.speed;
            const r = pill.radius;
            pill.group.position.x = Math.cos(pill.angle) * r;
            pill.group.position.z = Math.sin(pill.angle) * r;
            pill.group.position.y = pill.yOffset + Math.sin(time + pill.angle) * 0.2;

            // Pill always faces camera
            pill.group.quaternion.copy(camera.quaternion);
        });

        // Drift Particles
        particles.rotation.y = time * 0.02;
        particles.rotation.x = Math.sin(time * 0.01) * 0.05;

        renderer.render(scene, camera);
    }

    animate();
})();
