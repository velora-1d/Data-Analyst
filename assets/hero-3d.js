/**
 * Fundamental Coding - Interactive 3D Architecture Core with Coding Tech Badges
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
            bottom: 12px;
            left: 50%;
            transform: translateX(-50%) translateY(10px);
            background: rgba(15, 23, 42, 0.92);
            color: #FFFFFF;
            border: 1px solid rgba(96, 165, 250, 0.4);
            padding: 6px 14px;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 700;
            pointer-events: none;
            opacity: 0;
            transition: opacity 0.2s ease, transform 0.2s ease;
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            white-space: nowrap;
            z-index: 10;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.35);
        `;
        container.appendChild(tooltip);
    }

    // Scene Setup
    const scene = new THREE.Scene();
    const isMobile = window.innerWidth <= 768;

    const camera = new THREE.PerspectiveCamera(45, container.clientWidth / container.clientHeight, 0.1, 1000);
    camera.position.z = isMobile ? 12 : 9.5;
    camera.position.y = 0.5;

    const renderer = new THREE.WebGLRenderer({
        antialias: !isMobile,
        alpha: true,
        powerPreference: 'high-performance'
    });
    renderer.setSize(container.clientWidth, container.clientHeight);
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, isMobile ? 1 : 1.5));
    renderer.toneMapping = THREE.ACESFilmicToneMapping;
    renderer.toneMappingExposure = 1.1;
    container.appendChild(renderer.domElement);

    // Color Palette Tokens (Adheres strictly to User Preferences: Electric Blue & Sky Cyan, NO PURPLE)
    const isDark = () => document.documentElement.getAttribute('data-theme') !== 'light';
    const getColors = () => {
        const dark = isDark();
        return {
            primary: dark ? 0x3B82F6 : 0x2563EB,
            secondary: dark ? 0x60A5FA : 0x1D4ED8,
            accent: dark ? 0x38BDF8 : 0x0284C7,
            core: dark ? 0x1E40AF : 0x3B82F6,
            wireframe: dark ? 0x93C5FD : 0x1E3A8A,
            points: dark ? 0x93C5FD : 0x3B82F6,
            ambient: dark ? 0x334155 : 0x94A3B8,
            light: dark ? 0xFFFFFF : 0xE2E8F0,
            tokenEdge: dark ? 0x1E293B : 0xCBD5E1
        };
    };

    let colors = getColors();

    // Lighting
    const ambientLight = new THREE.AmbientLight(colors.ambient, 2.0);
    scene.add(ambientLight);

    const mainLight = new THREE.DirectionalLight(0x60A5FA, 2.6);
    mainLight.position.set(6, 8, 6);
    scene.add(mainLight);

    const rimLight = new THREE.DirectionalLight(0x38BDF8, 2.2);
    rimLight.position.set(-6, -4, -4);
    scene.add(rimLight);

    const pointLight = new THREE.PointLight(0x3B82F6, 3.5, 16);
    pointLight.position.set(0, 0, 0);
    scene.add(pointLight);

    // Main 3D System Group
    const systemGroup = new THREE.Group();
    scene.add(systemGroup);

    // 1. Central Core: Faceted Icosahedron + Wireframe Shell
    const coreGeo = new THREE.IcosahedronGeometry(1.8, 1);
    const coreMat = new THREE.MeshStandardMaterial({
        color: colors.core,
        roughness: 0.25,
        metalness: 0.85,
        flatShading: true,
        transparent: true,
        opacity: 0.85
    });
    const coreMesh = new THREE.Mesh(coreGeo, coreMat);
    systemGroup.add(coreMesh);

    const wireframeGeo = new THREE.IcosahedronGeometry(1.88, 1);
    const wireframeMat = new THREE.MeshBasicMaterial({
        color: colors.wireframe,
        wireframe: true,
        transparent: true,
        opacity: 0.45
    });
    const wireframeMesh = new THREE.Mesh(wireframeGeo, wireframeMat);
    systemGroup.add(wireframeMesh);

    // Inner glowing sphere
    const innerGeo = new THREE.SphereGeometry(0.9, 16, 16);
    const innerMat = new THREE.MeshBasicMaterial({
        color: colors.accent,
        transparent: true,
        opacity: 0.65
    });
    const innerMesh = new THREE.Mesh(innerGeo, innerMat);
    systemGroup.add(innerMesh);

    // 2. Orbital Tech Rings
    function createOrbitRing(radius, tube, rotX, rotY, color) {
        const ringGeo = new THREE.TorusGeometry(radius, tube, 16, 100);
        const ringMat = new THREE.MeshBasicMaterial({
            color: color,
            transparent: true,
            opacity: 0.35,
            wireframe: false
        });
        const ring = new THREE.Mesh(ringGeo, ringMat);
        ring.rotation.x = rotX;
        ring.rotation.y = rotY;
        return ring;
    }

    const ring1 = createOrbitRing(3.3, 0.02, Math.PI / 3, 0.3, colors.secondary);
    const ring2 = createOrbitRing(3.9, 0.02, -Math.PI / 3.5, -0.4, colors.accent);
    const ring3 = createOrbitRing(4.6, 0.015, Math.PI / 2.2, 0.8, colors.primary);
    systemGroup.add(ring1);
    systemGroup.add(ring2);
    systemGroup.add(ring3);

    // 3. High-DPI Vector Canvas Texture Generator for Coding Badges
    function createTechBadgeTexture(symbol, label, colorHexStr, dark) {
        const size = 256;
        const canvas = document.createElement('canvas');
        canvas.width = size;
        canvas.height = size;
        const ctx = canvas.getContext('2d');

        const center = size / 2;
        const radius = size * 0.45;

        // Circular background disc
        ctx.beginPath();
        ctx.arc(center, center, radius, 0, Math.PI * 2);
        ctx.fillStyle = dark ? '#0F172A' : '#FFFFFF';
        ctx.fill();

        // Accent outer border ring
        ctx.lineWidth = 10;
        const grad = ctx.createLinearGradient(0, 0, size, size);
        grad.addColorStop(0, colorHexStr);
        grad.addColorStop(1, '#1D4ED8');
        ctx.strokeStyle = grad;
        ctx.stroke();

        // Subtle inner tinted circle
        ctx.beginPath();
        ctx.arc(center, center, radius - 7, 0, Math.PI * 2);
        ctx.fillStyle = dark ? 'rgba(30, 58, 138, 0.4)' : 'rgba(239, 246, 255, 0.7)';
        ctx.fill();

        // Main Coding Symbol / Glif
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.font = '900 68px "JetBrains Mono", monospace';
        ctx.fillStyle = colorHexStr;
        ctx.fillText(symbol, center, center - 16);

        // Subtext Label (Category)
        ctx.font = 'bold 22px "Inter", sans-serif';
        ctx.fillStyle = dark ? '#E2E8F0' : '#1E293B';
        ctx.fillText(label, center, center + 46);

        const texture = new THREE.CanvasTexture(canvas);
        texture.generateMipmaps = true;
        texture.minFilter = THREE.LinearMipmapLinearFilter;
        return texture;
    }

    // 4. 3D Floating Coding & Tech Tokens (Replacing Generic Cubes)
    const tokenData = [
        {
            symbol: 'SQL',
            label: 'DATABASE',
            fullName: 'Track 01: Database & SQL Internals',
            colorHexStr: '#38BDF8',
            colorHex: 0x38BDF8,
            radius: 3.3,
            speed: 0.012,
            offset: 0,
            url: '#tracksGrid'
        },
        {
            symbol: '</>',
            label: 'FRONTEND',
            fullName: 'Track 02: Browser Rendering Pipeline',
            colorHexStr: '#60A5FA',
            colorHex: 0x60A5FA,
            radius: 3.9,
            speed: -0.010,
            offset: Math.PI / 3,
            url: 'tracks/02_frontend/01_rendering_pipeline.html'
        },
        {
            symbol: '{ ; }',
            label: 'RUNTIME',
            fullName: 'Track 07: V8 Event Loop & Memory',
            colorHexStr: '#3B82F6',
            colorHex: 0x3B82F6,
            radius: 3.3,
            speed: 0.012,
            offset: (2 * Math.PI) / 3,
            url: 'tracks/07_runtimes_memory/01_v8_event_loop.html'
        },
        {
            symbol: '⑂',
            label: 'GIT DAG',
            fullName: 'Track 08: Git Internals & Data Structures',
            colorHexStr: '#93C5FD',
            colorHex: 0x93C5FD,
            radius: 4.6,
            speed: -0.008,
            offset: Math.PI,
            url: 'tracks/07_runtimes_memory/03_git_internals_advanced.html'
        },
        {
            symbol: '❖',
            label: 'SYSTEM ARCH',
            fullName: 'Track 04: System Architecture & Scale',
            colorHexStr: '#2563EB',
            colorHex: 0x2563EB,
            radius: 3.9,
            speed: -0.010,
            offset: (4 * Math.PI) / 3,
            url: 'tracks/02_system_design/01_scalability_patterns.html'
        },
        {
            symbol: '⊞',
            label: 'UI/UX DESIGN',
            fullName: 'Track 12: UI Anatomy & Design Tokens',
            colorHexStr: '#38BDF8',
            colorHex: 0x38BDF8,
            radius: 4.6,
            speed: -0.008,
            offset: (5 * Math.PI) / 3,
            url: 'tracks/11_ui_ux_design/01_ui_anatomy_tokens.html'
        }
    ];

    const satelliteTokens = [];
    const interactiveMeshes = [];

    function buildTokens() {
        // Clear previous if rebuilding
        satelliteTokens.forEach(st => systemGroup.remove(st.group));
        satelliteTokens.length = 0;
        interactiveMeshes.length = 0;

        const dark = isDark();

        tokenData.forEach((data) => {
            const tokenGroup = new THREE.Group();

            // 3D Coin Cylinder Geometry: radiusTop, radiusBottom, height, radialSegments
            const tokenRadius = 0.52;
            const tokenHeight = 0.09;
            const cylinderGeo = new THREE.CylinderGeometry(tokenRadius, tokenRadius, tokenHeight, 32);

            // Textures for Front and Back Face
            const badgeTexture = createTechBadgeTexture(data.symbol, data.label, data.colorHexStr, dark);

            // Material Array: [sideEdge, topFace, bottomFace]
            const edgeMat = new THREE.MeshStandardMaterial({
                color: colors.tokenEdge,
                metalness: 0.85,
                roughness: 0.25
            });

            const faceMat = new THREE.MeshBasicMaterial({
                map: badgeTexture,
                transparent: true
            });

            const materials = [edgeMat, faceMat, faceMat];
            const tokenMesh = new THREE.Mesh(cylinderGeo, materials);
            tokenMesh.rotation.x = Math.PI / 2; // Face forward
            tokenMesh.userData = { data: data };

            // Outer Glowing Wire Ring
            const ringGeo = new THREE.RingGeometry(tokenRadius + 0.02, tokenRadius + 0.05, 32);
            const ringMat = new THREE.MeshBasicMaterial({
                color: data.colorHex,
                side: THREE.DoubleSide,
                transparent: true,
                opacity: 0.55
            });
            const glowRing = new THREE.Mesh(ringGeo, ringMat);
            glowRing.position.z = 0;

            tokenGroup.add(tokenMesh);
            tokenGroup.add(glowRing);
            systemGroup.add(tokenGroup);

            interactiveMeshes.push(tokenMesh);

            satelliteTokens.push({
                group: tokenGroup,
                mesh: tokenMesh,
                data: data,
                angle: data.offset,
                targetScale: 1
            });
        });
    }

    buildTokens();

    // 5. Subtle Ambient Particle Stars
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
        if (hasDragged) return; // Ignore drag release as click

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
        coreMat.color.setHex(colors.core);
        wireframeMat.color.setHex(colors.wireframe);
        innerMat.color.setHex(colors.accent);
        particleMat.color.setHex(colors.points);
        ring1.material.color.setHex(colors.secondary);
        ring2.material.color.setHex(colors.accent);
        ring3.material.color.setHex(colors.primary);
        ambientLight.color.setHex(colors.ambient);
        ambientLight.intensity = isDark() ? 2.0 : 2.6;

        // Rebuild tokens with new light/dark background textures
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
        camera.position.z = window.innerWidth <= 768 ? 12 : 9.5;
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
                        st.targetScale = 1.3;
                        if (hoveredToken !== st) {
                            hoveredToken = st;
                            tooltip.innerHTML = `<i class="fa-solid fa-code"></i> ${st.data.fullName} &rarr;`;
                            tooltip.style.opacity = '1';
                            tooltip.style.transform = 'translateX(-50%) translateY(0px)';
                        }
                    } else {
                        st.targetScale = 0.95;
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

        // Inner Core Pulse
        coreMesh.rotation.y += 0.005;
        coreMesh.rotation.x += 0.003;
        wireframeMesh.rotation.y -= 0.006;
        wireframeMesh.rotation.z += 0.002;

        const pulse = 1 + Math.sin(time * 2) * 0.05;
        innerMesh.scale.set(pulse, pulse, pulse);

        // Orbit Rings Wobble
        ring1.rotation.z += 0.004;
        ring2.rotation.z -= 0.005;
        ring3.rotation.z += 0.003;

        // Update 3D Coding Tokens
        satelliteTokens.forEach((token) => {
            token.angle += token.data.speed;
            const r = token.data.radius;
            token.group.position.x = Math.cos(token.angle) * r;
            token.group.position.z = Math.sin(token.angle) * r;
            token.group.position.y = Math.sin(token.angle * 2 + time) * 0.45;

            // Smooth scale lerp for hover
            const curScale = token.group.scale.x;
            const nextScale = curScale + (token.targetScale - curScale) * 0.15;
            token.group.scale.set(nextScale, nextScale, nextScale);

            // Orient Token to smoothly face camera so code icons remain legible
            token.group.quaternion.copy(camera.quaternion);
            // Add subtle floating wobbling tilt
            token.group.rotation.z = Math.sin(time * 2 + token.angle) * 0.12;
        });

        // Drift Particles
        particles.rotation.y = time * 0.02;
        particles.rotation.x = Math.sin(time * 0.01) * 0.05;

        renderer.render(scene, camera);
    }

    animate();
})();
