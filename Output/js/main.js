// --- THEME LOGIC ---
const toggleBtn = document.getElementById('theme-toggle');
const moonIcon = document.getElementById('theme-icon-moon');
const sunIcon = document.getElementById('theme-icon-sun');
const htmlEl = document.documentElement;

const storedTheme = localStorage.getItem('theme');
const prefersLight = window.matchMedia('(prefers-color-scheme: light)').matches;

if (storedTheme === 'light' || (!storedTheme && prefersLight)) {
    htmlEl.setAttribute('data-theme', 'light');
    moonIcon.classList.remove('hidden');
} else {
    htmlEl.setAttribute('data-theme', 'dark');
    sunIcon.classList.remove('hidden');
}

toggleBtn.addEventListener('click', () => {
    const currentTheme = htmlEl.getAttribute('data-theme');
    if (currentTheme === 'light') {
        htmlEl.setAttribute('data-theme', 'dark');
        localStorage.setItem('theme', 'dark');
        moonIcon.classList.add('hidden');
        sunIcon.classList.remove('hidden');
    } else {
        htmlEl.setAttribute('data-theme', 'light');
        localStorage.setItem('theme', 'light');
        sunIcon.classList.add('hidden');
        moonIcon.classList.remove('hidden');
    }
});

// --- I18N LOGIC (JSON Locale Files) ---
const langToggle = document.getElementById('lang-toggle');
const langText = document.getElementById('lang-text');
let currentLang = localStorage.getItem('lang') || 'en';
const localeCache = {};

/**
 * Resolve a dot-notated key from a nested object.
 * e.g. getNestedValue(obj, "projects.project-1.subtitle")
 */
function getNestedValue(obj, keyPath) {
    return keyPath.split('.').reduce((acc, key) => (acc && acc[key] !== undefined ? acc[key] : null), obj);
}

/**
 * Load a locale JSON file, cache it, and apply translations to the DOM.
 */
async function setLanguage(lang) {
    currentLang = lang;
    localStorage.setItem('lang', lang);
    htmlEl.setAttribute('lang', lang === 'id' ? 'id' : 'en');

    if (langText) {
        langText.innerText = lang.toUpperCase();
    }

    // Load locale if not cached
    if (!localeCache[lang]) {
        try {
            const response = await fetch(`locales/${lang}.json`);
            localeCache[lang] = await response.json();
        } catch (err) {
            console.warn(`[i18n] Failed to load locale: ${lang}`, err);
            return;
        }
    }

    applyTranslations(localeCache[lang]);
}

/**
 * Apply translations from a locale object to all elements with data-i18n / data-i18n-html.
 */
function applyTranslations(locale) {
    // data-i18n → textContent replacement
    document.querySelectorAll('[data-i18n]').forEach(el => {
        const key = el.getAttribute('data-i18n');
        const value = getNestedValue(locale, key);
        if (value) {
            el.textContent = value;
        }
    });

    // data-i18n-html → innerHTML replacement (for rich text with <span> etc.)
    document.querySelectorAll('[data-i18n-html]').forEach(el => {
        const key = el.getAttribute('data-i18n-html');
        const value = getNestedValue(locale, key);
        if (value) {
            el.innerHTML = value;
        }
    });
}

if (langToggle) {
    langToggle.addEventListener('click', () => {
        const nextLang = currentLang === 'en' ? 'id' : 'en';
        setLanguage(nextLang);
    });
}

// Apply language on load
setLanguage(currentLang);

// --- HERO MICRO-INTERACTIONS ---
function initHeroInteractions() {
    const heroSection = document.getElementById('about');
    const spotlight = document.getElementById('hero-spotlight');
    const heroElements = document.querySelectorAll('.hero-reveal');

    // 1. Staggered Reveal
    heroElements.forEach((el, index) => {
        setTimeout(() => {
            el.style.animation = `reveal 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards`;
            el.classList.remove('opacity-0');
        }, 100 + (index * 150));
    });

    // 2. Spotlight Tracking
    if (heroSection && spotlight) {
        heroSection.addEventListener('mousemove', (e) => {
            const rect = heroSection.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;

            spotlight.style.setProperty('--x', `${x}px`);
            spotlight.style.setProperty('--y', `${y}px`);
            spotlight.classList.remove('opacity-0');
        });

        heroSection.addEventListener('mouseleave', () => {
            spotlight.classList.add('opacity-0');
        });
    }

    // 3. Magnetic Buttons
    const magneticBtns = document.querySelectorAll('.magnetic-btn');
    magneticBtns.forEach(btn => {
        btn.addEventListener('mousemove', (e) => {
            const rect = btn.getBoundingClientRect();
            const x = e.clientX - rect.left - rect.width / 2;
            const y = e.clientY - rect.top - rect.height / 2;
            btn.style.transform = `translate(${x * 0.4}px, ${y * 0.4}px)`;
            btn.style.transition = 'none';
        });
        btn.addEventListener('mouseleave', () => {
            btn.style.transform = `translate(0px, 0px)`;
            btn.style.transition = 'transform 0.5s cubic-bezier(0.23, 1, 0.32, 1)';
        });
    });
}

document.addEventListener('DOMContentLoaded', initHeroInteractions);

// --- SCROLL REVEAL (Intersection Observer) ---
const revealObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('active');
            // Sekali muncul, stop observasi agar performa tetap ringan
            revealObserver.unobserve(entry.target);
        }
    });
}, {
    threshold: 0.15 // Aktif saat 15% bagian muncul di layar
});

function initScrollReveal() {
    const revealElements = document.querySelectorAll('.scroll-reveal');
    revealElements.forEach(el => revealObserver.observe(el));
}

document.addEventListener('DOMContentLoaded', initScrollReveal);

// --- READING PROGRESS BAR ---
function handleScrollProgress() {
    const progressBar = document.getElementById('scroll-progress');
    if (!progressBar) return;

    window.addEventListener('scroll', () => {
        const winScroll = document.body.scrollTop || document.documentElement.scrollTop;
        const height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
        const scrolled = (winScroll / height) * 100;
        progressBar.style.width = scrolled + "%";
    });
}

document.addEventListener('DOMContentLoaded', handleScrollProgress);

// MODAL LOGIC
let carouselIntervals = {};

function startCarousel(id) {
    const track = document.getElementById('carousel-track-' + id);
    if (!track) return;

    const count = track.children.length;
    if (count <= 1) return;

    if (carouselIntervals[id]) clearInterval(carouselIntervals[id]);

    let currentIndex = 0;
    carouselIntervals[id] = setInterval(() => {
        currentIndex = (currentIndex + 1) % count;
        track.style.transform = `translateX(-${currentIndex * 100}%)`;

        // Update dots styling gracefully
        for (let i = 0; i < count; i++) {
            const dot = document.getElementById(`carousel-dot-${id}-${i}`);
            if (dot) {
                if (i === currentIndex) {
                    dot.classList.remove('bg-white/50', 'w-2');
                    dot.classList.add('bg-white', 'w-4');
                } else {
                    dot.classList.remove('bg-white', 'w-4');
                    dot.classList.add('bg-white/50', 'w-2');
                }
            }
        }
    }, 1500); // Auto change page every 1.5s
}

function stopCarousel(id) {
    if (carouselIntervals[id]) {
        clearInterval(carouselIntervals[id]);
        carouselIntervals[id] = null;
    }
}

function openModal(id) {
    const modal = document.getElementById('modal-' + id);
    const backdrop = document.getElementById('modal-backdrop-' + id);
    const content = document.getElementById('modal-content-' + id);
    if (!modal || !content) return;

    modal.classList.remove('hidden');
    document.documentElement.style.overflow = 'hidden';

    void modal.offsetWidth;

    backdrop.classList.remove('opacity-0');
    backdrop.classList.add('opacity-100');

    content.classList.add('modal-spring');
    content.classList.remove('opacity-0');

    // --- SWIPE TO DISMISS LOGIC ---
    let startY = 0;
    let currentY = 0;
    let isDragging = false;

    const handleTouchStart = (e) => {
        startY = e.touches[0].clientY;
        isDragging = true;
        content.style.transition = 'none'; // Matikan transisi saat di-drag agar responsif
    };

    const handleTouchMove = (e) => {
        if (!isDragging) return;
        currentY = e.touches[0].clientY;
        const deltaY = currentY - startY;

        if (deltaY > 0) { // Hanya swipe ke bawah
            content.style.transform = `translateY(${deltaY}px)`;
            // Memudarkan backdrop seiring swipe ke bawah
            const opacity = 1 - (deltaY / 500);
            backdrop.style.opacity = Math.max(0, opacity);
        }
    };

    const handleTouchEnd = () => {
        if (!isDragging) return;
        isDragging = false;
        const deltaY = currentY - startY;

        if (deltaY > 150) { // Ambang batas 150px untuk tutup
            closeModal(id);
        } else {
            // Kembalikan ke posisi awal jika tidak cukup dalam
            content.style.transition = 'transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275)';
            content.style.transform = 'translateY(0)';
            backdrop.style.opacity = '1';
        }
    };

    // Pasang listener pada seluruh area modal content (terutama handle bar)
    content.addEventListener('touchstart', handleTouchStart, { passive: true });
    content.addEventListener('touchmove', handleTouchMove, { passive: true });
    content.addEventListener('touchend', handleTouchEnd);

    // Simpan referensi listener agar bisa dibersihkan jika perlu (opsional untuk SPA statis)
    content._swipeHandlers = { handleTouchStart, handleTouchMove, handleTouchEnd };

    startCarousel(id);
}

function closeModal(id) {
    const modal = document.getElementById('modal-' + id);
    const backdrop = document.getElementById('modal-backdrop-' + id);
    const content = document.getElementById('modal-content-' + id);
    if (!modal || !content) return;

    backdrop.classList.remove('opacity-100');
    backdrop.classList.add('opacity-0');
    backdrop.style.opacity = ''; // Reset inline opacity jika ada

    content.classList.remove('modal-spring');
    content.classList.add('opacity-0');
    content.style.transform = ''; // Reset transform agar kembali ke CSS default
    content.style.transition = '';

    stopCarousel(id);

    // Lepas listener gestur saat modal tutup
    if (content._swipeHandlers) {
        content.removeEventListener('touchstart', content._swipeHandlers.handleTouchStart);
        content.removeEventListener('touchmove', content._swipeHandlers.handleTouchMove);
        content.removeEventListener('touchend', content._swipeHandlers.handleTouchEnd);
    }

    setTimeout(() => {
        modal.classList.add('hidden');
        document.documentElement.style.overflow = '';
    }, 500);
}

// MOBILE MENU LOGIC
const mobileMenuBtn = document.getElementById('mobile-menu-btn');
const mobileDropdown = document.getElementById('mobile-dropdown');
const mobileLinks = document.querySelectorAll('.mobile-link');

if (mobileMenuBtn && mobileDropdown) {
    mobileMenuBtn.addEventListener('click', () => {
        mobileDropdown.classList.toggle('hidden');
        mobileDropdown.classList.toggle('flex');
    });

    // Close menu when a link is clicked
    mobileLinks.forEach(link => {
        link.addEventListener('click', () => {
            mobileDropdown.classList.add('hidden');
            mobileDropdown.classList.remove('flex');
        });
    });
}

// PAGINATION LOGIC
const projectsGrid = document.getElementById('projects-grid');
const projectsPagination = document.getElementById('projects-pagination');

if (projectsGrid && projectsPagination) {
    const projectItems = projectsGrid.querySelectorAll('.project-item');
    let currentPage = 1;
    let itemsPerPage = window.innerWidth >= 768 ? 6 : 3;

    function renderProjects(page) {
        const totalItems = projectItems.length;
        const totalPages = Math.ceil(totalItems / itemsPerPage);

        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;
        currentPage = page;

        const startIndex = (page - 1) * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;

        projectItems.forEach((item, index) => {
            if (index >= startIndex && index < endIndex) {
                item.classList.remove('hidden');
            } else {
                item.classList.add('hidden');
            }
        });

        projectsPagination.innerHTML = '';
        if (totalPages <= 1) return;

        // Left - Previous
        const divLeft = document.createElement('div');
        divLeft.className = '-mt-px flex w-0 flex-1';

        const prevBtn = document.createElement('button');
        prevBtn.innerHTML = `
            <svg class="mr-3 h-5 w-5 text-inherit" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
              <path fill-rule="evenodd" d="M11.78 5.22a.75.75 0 0 1 0 1.06L8.06 10l3.72 3.72a.75.75 0 1 1-1.06 1.06l-4.25-4.25a.75.75 0 0 1 0-1.06l4.25-4.25a.75.75 0 0 1 1.06 0Z" clip-rule="evenodd" />
            </svg>
            <span class="hidden sm:inline" data-i18n="pagination.previous">Previous</span>
        `;
        prevBtn.className = `inline-flex items-center border-t-2 border-transparent pr-1 pt-4 text-sm font-medium bg-transparent outline-none ${page === 1 ? 'text-ghibli-text/30 cursor-not-allowed' : 'text-ghibli-text/60 hover:border-ghibli-text/30 hover:text-ghibli-text cursor-pointer transition-colors'}`;
        prevBtn.disabled = page === 1;
        prevBtn.addEventListener('click', () => {
            renderProjects(currentPage - 1);
            document.getElementById('projects').scrollIntoView({ behavior: 'smooth' });
        });
        divLeft.appendChild(prevBtn);
        projectsPagination.appendChild(divLeft);

        // Center - Numbers
        const divCenter = document.createElement('div');
        divCenter.className = '-mt-px flex';

        for (let i = 1; i <= totalPages; i++) {
            const pageBtn = document.createElement('button');
            pageBtn.innerText = i;

            if (i === page) {
                pageBtn.className = 'inline-flex items-center border-t-2 border-ghibli-accent px-4 pt-4 text-sm font-medium text-ghibli-accent bg-transparent outline-none cursor-pointer';
            } else {
                pageBtn.className = 'inline-flex items-center border-t-2 border-transparent px-4 pt-4 text-sm font-medium text-ghibli-text/60 hover:border-ghibli-text/30 hover:text-ghibli-text bg-transparent outline-none cursor-pointer transition-colors';
            }

            pageBtn.addEventListener('click', () => {
                renderProjects(i);
                document.getElementById('projects').scrollIntoView({ behavior: 'smooth' });
            });
            divCenter.appendChild(pageBtn);
        }
        projectsPagination.appendChild(divCenter);

        // Right - Next
        const divRight = document.createElement('div');
        divRight.className = '-mt-px flex w-0 flex-1 justify-end';

        const nextBtn = document.createElement('button');
        nextBtn.innerHTML = `
            <span class="hidden sm:inline" data-i18n="pagination.next">Next</span>
            <svg class="ml-3 h-5 w-5 text-inherit" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
              <path fill-rule="evenodd" d="M8.22 5.22a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 0 1 0 1.06l-4.25 4.25a.75.75 0 0 1-1.06-1.06L11.94 10 8.22 6.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
            </svg>
        `;
        nextBtn.className = `inline-flex items-center border-t-2 border-transparent pl-1 pt-4 text-sm font-medium bg-transparent outline-none ${page === totalPages ? 'text-ghibli-text/30 cursor-not-allowed' : 'text-ghibli-text/60 hover:border-ghibli-text/30 hover:text-ghibli-text cursor-pointer transition-colors'}`;
        nextBtn.disabled = page === totalPages;
        nextBtn.addEventListener('click', () => {
            renderProjects(currentPage + 1);
            document.getElementById('projects').scrollIntoView({ behavior: 'smooth' });
        });
        divRight.appendChild(nextBtn);
        projectsPagination.appendChild(divRight);

        // Re-apply translations to newly created pagination elements
        if (localeCache[currentLang]) {
            applyTranslations(localeCache[currentLang]);
        }
    }

    renderProjects(currentPage);

    window.addEventListener('resize', () => {
        const newItemsPerPage = window.innerWidth >= 768 ? 6 : 3;
        if (newItemsPerPage !== itemsPerPage) {
            itemsPerPage = newItemsPerPage;
            renderProjects(1);
        }
    });
}

// CERTIFICATE CAROUSEL LOGIC
const certTrack = document.getElementById('cert-carousel-track');
if (certTrack) {
    const certCount = certTrack.children.length;
    let currentCertIndex = 0;

    function updateCertStyle() {
        certTrack.style.transform = `translateX(-${currentCertIndex * 100}%)`;
        for (let i = 0; i < certCount; i++) {
            const dot = document.getElementById(`cert-dot-${i}`);
            if (dot) {
                if (i === currentCertIndex) {
                    dot.className = "w-3 h-3 rounded-full transition-all duration-300 border-none outline-none cursor-pointer bg-white scale-125";
                } else {
                    dot.className = "w-3 h-3 rounded-full transition-all duration-300 border-none outline-none cursor-pointer bg-white/50";
                }
            }
        }
    }

    let certInterval = setInterval(() => {
        currentCertIndex = (currentCertIndex + 1) % certCount;
        updateCertStyle();
    }, 1500);

    window.goToCert = function (index) {
        clearInterval(certInterval);
        currentCertIndex = index;
        updateCertStyle();
        // Restart automation
        certInterval = setInterval(() => {
            currentCertIndex = (currentCertIndex + 1) % certCount;
            updateCertStyle();
        }, 1500);
    };
}
