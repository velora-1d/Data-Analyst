/**
 * Fundamental Coding - Interactive 3D Architecture Core
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
                    <i class="fa-solid fa-cube"></i>
                </div>
            </div>
        `;
        return;
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
            primary: dark ? 0x3B82F6 : 0x2563EB,    // Vibrant Blue
            secondary: dark ? 0x60A5FA : 0x1D4ED8,  // Soft Sky / Deep Navy
            accent: dark ? 0x38BDF8 : 0x0284C7,     // Cyan / Sky
            core: dark ? 0x1E40AF : 0x3B82F6,       // Core Solid
            wireframe: dark ? 0x93C5FD : 0x1E3A8A,  // Wireframe highlight
            points: dark ? 0x93C5FD : 0x3B82F6,     // Starfield
            ambient: dark ? 0x334155 : 0x94A3B8,
            light: dark ? 0xFFFFFF : 0xE2E8F0
        };
    };

    let colors = getColors();

    // Lighting
    const ambientLight = new THREE.AmbientLight(colors.ambient, 1.8);
    scene.add(ambientLight);

    const mainLight = new THREE.DirectionalLight(0x60A5FA, 2.5);
    mainLight.position.set(5, 8, 5);
    scene.add(mainLight);

    const rimLight = new THREE.DirectionalLight(0x38BDF8, 2.0);
    rimLight.position.set(-6, -4, -4);
    scene.add(rimLight);

    const pointLight = new THREE.PointLight(0x3B82F6, 3, 15);
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
        opacity: 0.6
    });
    const innerMesh = new THREE.Mesh(innerGeo, innerMat);
    systemGroup.add(innerMesh);

    // 2. Orbital Tech Rings
    function createOrbitRing(radius, tube, rotX, rotY, color) {
        const ringGeo = new THREE.TorusGeometry(radius, tube, 16, 90);
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

    const ring1 = createOrbitRing(3.2, 0.02, Math.PI / 3, 0.3, colors.secondary);
    const ring2 = createOrbitRing(3.8, 0.02, -Math.PI / 3.5, -0.4, colors.accent);
    const ring3 = createOrbitRing(4.5, 0.015, Math.PI / 2.2, 0.8, colors.primary);
    systemGroup.add(ring1);
    systemGroup.add(ring2);
    systemGroup.add(ring3);

    // 3. Orbiting Satellite System Nodes (Representing Architectural Pillars)
    const satelliteNodes = [];
    const nodeData = [
        { label: 'Database & SQL', color: 0x3B82F6, radius: 3.2, speed: 0.012, offset: 0 },
        { label: 'Network & HTTP', color: 0x38BDF8, radius: 3.8, speed: -0.010, offset: Math.PI / 3 },
        { label: 'Runtime & Memory', color: 0x60A5FA, radius: 3.2, speed: 0.012, offset: (2 * Math.PI) / 3 },
        { label: 'Clean Code & Patterns', color: 0x2563EB, radius: 4.5, speed: -0.008, offset: Math.PI },
        { label: 'Mobile Architecture', color: 0x38BDF8, radius: 3.8, speed: -0.010, offset: (4 * Math.PI) / 3 },
        { label: 'UI/UX & Design Systems', color: 0x93C5FD, radius: 4.5, speed: -0.008, offset: (5 * Math.PI) / 3 }
    ];

    nodeData.forEach((data) => {
        const satGroup = new THREE.Group();
        const satGeo = new THREE.BoxGeometry(0.42, 0.42, 0.42);
        const satMat = new THREE.MeshStandardMaterial({
            color: data.color,
            metalness: 0.6,
            roughness: 0.3,
            flatShading: true
        });
        const satMesh = new THREE.Mesh(satGeo, satMat);

        const satWireGeo = new THREE.BoxGeometry(0.46, 0.46, 0.46);
        const satWireMat = new THREE.MeshBasicMaterial({
            color: 0xFFFFFF,
            wireframe: true,
            transparent: true,
            opacity: 0.3
        });
        const satWire = new THREE.Mesh(satWireGeo, satWireMat);

        satGroup.add(satMesh);
        satGroup.add(satWire);
        systemGroup.add(satGroup);

        satelliteNodes.push({
            group: satGroup,
            data: data,
            angle: data.offset
        });
    });

    // 4. Subtle Ambient Particle Stars
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

    // Interactive Mouse & Touch Dragging
    let mouseX = 0;
    let mouseY = 0;
    let targetRotationX = 0;
    let targetRotationY = 0;
    let isDragging = false;
    let previousPointerPosition = { x: 0, y: 0 };

    function onPointerMove(e) {
        const clientX = e.touches ? e.touches[0].clientX : e.clientX;
        const clientY = e.touches ? e.touches[0].clientY : e.clientY;

        const rect = container.getBoundingClientRect();
        const x = ((clientX - rect.left) / rect.width) * 2 - 1;
        const y = -(((clientY - rect.top) / rect.height) * 2 - 1);

        mouseX = x;
        mouseY = y;

        if (isDragging) {
            const deltaX = clientX - previousPointerPosition.x;
            const deltaY = clientY - previousPointerPosition.y;

            targetRotationY += deltaX * 0.007;
            targetRotationX += deltaY * 0.007;

            previousPointerPosition = { x: clientX, y: clientY };
        }
    }

    container.addEventListener('mousedown', (e) => {
        isDragging = true;
        previousPointerPosition = { x: e.clientX, y: e.clientY };
    });

    window.addEventListener('mouseup', () => { isDragging = false; });
    container.addEventListener('mousemove', onPointerMove);

    container.addEventListener('touchstart', (e) => {
        if (e.touches.length === 1) {
            isDragging = true;
            previousPointerPosition = { x: e.touches[0].clientX, y: e.touches[0].clientY };
        }
    }, { passive: true });

    window.addEventListener('touchend', () => { isDragging = false; });
    container.addEventListener('touchmove', onPointerMove, { passive: true });

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
        ambientLight.intensity = isDark() ? 1.8 : 2.5;
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

        if (!isVisible) return; // Save CPU & GPU when scrolled down

        const delta = clock.getDelta();
        const time = clock.getElapsedTime();

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

        // Update Satellites
        satelliteNodes.forEach((node) => {
            node.angle += node.data.speed;
            const r = node.data.radius;
            node.group.position.x = Math.cos(node.angle) * r;
            node.group.position.z = Math.sin(node.angle) * r;
            node.group.position.y = Math.sin(node.angle * 2 + time) * 0.45;

            node.group.rotation.x += 0.02;
            node.group.rotation.y += 0.02;
        });

        // Drift Particles
        particles.rotation.y = time * 0.02;
        particles.rotation.x = Math.sin(time * 0.01) * 0.05;

        renderer.render(scene, camera);
    }

    animate();
})();
