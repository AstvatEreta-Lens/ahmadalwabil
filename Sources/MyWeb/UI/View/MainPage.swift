import Publish
import Plot

extension Theme where Site == MyWeb {
    static var ghibliSPATheme: Theme {
        Theme(
            htmlFactory: GhibliHTMLFactory()
        )
    }
}

struct GhibliHTMLFactory: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<MyWeb>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(
                .title(context.site.name),
                .meta(.charset(.utf8)),
                .meta(.name("viewport"), .content("width=device-width, initial-scale=1")),
                .stylesheet("styles/global.css")
            ),
            .body(
                .class("bg-ghibli-bg text-ghibli-text font-sans leading-relaxed m-0 p-0 selection:bg-ghibli-accent/30 selection:text-ghibli-accent"),
                
                // Reading Progress Bar
                .div(
                    .id("scroll-progress"),
                    .class("fixed top-0 left-0 h-[3px] bg-ghibli-accent z-[100] w-0 transition-all duration-150 ease-out shadow-[0_0_10px_rgba(100,255,218,0.5)]")
                ),

                .header(
                    .class("fixed top-0 w-full bg-ghibli-card/85 backdrop-blur-md z-50 border-b border-ghibli-text/10 px-6 py-4 flex items-center justify-between"),
                    .a(
                        .class("text-2xl font-bold font-serif text-ghibli-text no-underline hover:text-ghibli-accent transition-colors"),
                        .href("#"),
                        "ahmadal."
                    ),
                    .div(
                        .class("flex items-center gap-2 md:gap-6"),
                        .nav(
                            .ul(
                                .class("flex items-center gap-6 list-none m-0 p-0 hidden md:flex"),
                                .li(.a(.class("text-sm text-ghibli-text/80 no-underline font-sans hover:text-ghibli-accent transition-colors"), .href("#about"), .attribute(named: "data-i18n", value: "nav.about"), "About")),
                                .li(.a(.class("text-sm text-ghibli-text/80 no-underline font-sans hover:text-ghibli-accent transition-colors"), .href("#projects"), .attribute(named: "data-i18n", value: "nav.projects"), "Projects")),
                                .li(.a(.class("text-sm text-ghibli-text/80 no-underline font-sans hover:text-ghibli-accent transition-colors"), .href("#experiences"), .attribute(named: "data-i18n", value: "nav.experiences"), "Experiences")),
                                .li(.a(.class("text-sm text-ghibli-text/80 no-underline font-sans hover:text-ghibli-accent transition-colors"), .href("#contact"), .attribute(named: "data-i18n", value: "nav.contact"), "Contact"))
                            )
                        ),
                        
                        // Language Toggle
                        .button(
                            .id("lang-toggle"),
                            .class("text-xs font-bold text-ghibli-text/60 hover:text-ghibli-accent transition-colors cursor-pointer border border-ghibli-text/20 px-2 py-1 rounded-md bg-transparent flex items-center justify-center outline-none"),
                            .span(.id("lang-text"), "EN")
                        ),
                        
                        // Dark/Light Mode Toggle
                        .button(
                            .id("theme-toggle"),
                            .class("p-2 rounded-full hover:bg-ghibli-text/10 transition-colors cursor-pointer border-none bg-transparent text-ghibli-text flex items-center justify-center outline-none"),
                            .raw("""
                                <svg id="theme-icon-moon" class="w-5 h-5 hidden" fill="currentColor" viewBox="0 0 20 20">
                                  <path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"></path>
                                </svg>
                                <svg id="theme-icon-sun" class="w-5 h-5 hidden" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"></path>
                                </svg>
                            """)
                        ),
                        
                        // Mobile Hamburger Toggle
                        .button(
                            .id("mobile-menu-btn"),
                            .class("p-2 rounded-full hover:bg-ghibli-text/10 transition-colors cursor-pointer border-none bg-transparent text-ghibli-text flex items-center justify-center outline-none md:hidden"),
                            .raw("""
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <line x1="3" y1="12" x2="21" y2="12"></line>
                                    <line x1="3" y1="6" x2="21" y2="6"></line>
                                    <line x1="3" y1="18" x2="21" y2="18"></line>
                                </svg>
                            """)
                        )
                    ),
                    
                    // The Mobile Dropdown List (Absolute under header)
                    .div(
                        .id("mobile-dropdown"),
                        .class("absolute top-full left-0 w-full bg-ghibli-card/95 backdrop-blur-md border-b border-ghibli-text/10 flex-col items-center py-6 gap-6 shadow-xl hidden md:hidden z-40"),
                        .a(.class("text-base font-medium text-ghibli-text no-underline hover:text-ghibli-accent mobile-link"), .href("#about"), .attribute(named: "data-i18n", value: "nav.about"), "About"),
                        .a(.class("text-base font-medium text-ghibli-text no-underline hover:text-ghibli-accent mobile-link"), .href("#projects"), .attribute(named: "data-i18n", value: "nav.projects"), "Projects"),
                        .a(.class("text-base font-medium text-ghibli-text no-underline hover:text-ghibli-accent mobile-link"), .href("#experiences"), .attribute(named: "data-i18n", value: "nav.experiences"), "Experiences"),
                        .a(.class("text-base font-medium text-ghibli-text no-underline hover:text-ghibli-accent mobile-link"), .href("#contact"), .attribute(named: "data-i18n", value: "nav.contact"), "Contact")
                    )
                ),
                .main(
                    .class("pt-20 max-w-5xl mx-auto px-6"),
                    //MARK: ABOUT
                    .section(
                        .id("about"),
                        .class("min-h-[80vh] flex flex-col lg:flex-row items-center justify-between py-16 gap-12 lg:gap-20 relative"),
                        
                        // Hero Spotlight Cursor Layer
                        .div(
                            .id("hero-spotlight"),
                            .class("absolute inset-0 pointer-events-none z-0 opacity-0 transition-opacity duration-500"),
                            .style("background: radial-gradient(600px circle at var(--x, 50%) var(--y, 50%), rgba(100, 255, 218, 0.08), transparent 80%);")
                        ),

                        // Floating Background Elements (Ghibli Particles)
                        .div(
                            .class("absolute inset-0 pointer-events-none z-0 overflow-hidden"),
                            .div(.class("absolute top-[20%] left-[15%] w-3 h-3 rounded-full bg-ghibli-accent/60 blur-[1px] animate-firefly")),
                            .div(.class("absolute top-[60%] left-[10%] w-5 h-5 rounded-full bg-ghibli-accent/10 blur-[4px] animate-ghibli-float"), .style("animation-delay: 2s")),
                            .div(.class("absolute top-[40%] right-[20%] w-4 h-4 rounded-full bg-ghibli-accent/40 blur-[1px] animate-firefly"), .style("animation-delay: 4s")),
                            .div(.class("absolute top-[80%] right-[15%] w-2 h-2 rounded-full bg-ghibli-accent/30 blur-[1px] animate-ghibli-float"), .style("animation-delay: 1s")),
                            .div(.class("absolute top-[10%] right-[40%] w-3 h-3 rounded-full bg-ghibli-accent/15 blur-[2px] animate-ghibli-float"), .style("animation-delay: 6s"))
                        ),

                        // Kiri: Teks & Tombol
                        .div(
                            .class("flex-1 flex flex-col justify-center order-2 lg:order-1 z-10"),
                            
                                .h1(
                                    .class("hero-reveal opacity-0 text-4xl md:text-6xl font-serif mb-2 font-bold tracking-tighter text-ghibli-text"),
                                    .attribute(named: "data-i18n", value: "hero.greeting"),
                                    "Hello, I'm Ahmad Al Wabil"
                                ),
                            .h2(.class("hero-reveal opacity-0 text-2xl md:text-3xl font-sans mb-6 font-medium text-ghibli-accent tracking-wide"), "iOS Developer"),
                            .p(
                                .class("hero-reveal opacity-0 text-lg md:text-xl text-ghibli-text/80 mb-10 max-w-2xl leading-relaxed"),
                                .attribute(named: "data-i18n-html", value: "hero.description"),
                                "Passionate about ", 
                                .span(.class("text-ghibli-accent font-medium"), "clean architecture"),
                                " and crafting ",
                                .span(.class("text-ghibli-accent font-medium"), "immersive user experiences"),
                                ". Let's build something extraordinary."
                            ),
                            
                                .div(
                                    .class("hero-reveal opacity-0 flex flex-col sm:flex-row items-start sm:items-center gap-6"),
                                    .a(
                                        .class("inline-block px-8 py-3 bg-ghibli-accent text-ghibli-bg rounded-lg font-serif font-bold text-lg hover:bg-ghibli-accent-hover hover:-translate-y-1 hover:shadow-lg transition-all duration-300"),
                                        .href("https://drive.google.com/file/d/1gzJSfHGXLzKusJN1BOJrVjl7aw3nqG7p/view?usp=drive_linkhttps://drive.google.com/file/d/1gzJSfHGXLzKusJN1BOJrVjl7aw3nqG7p/view?usp=drive_link"),
                                        .attribute(named: "data-i18n", value: "hero.resume"),
                                        "View Resume"
                                    ),
                                    .div(
                                        .class("flex items-center gap-4"),
                                        // GitHub
                                        .a(
                                            .class("p-2 text-ghibli-text/60 hover:text-ghibli-accent hover:-translate-y-1 transition-all duration-300 magnetic-btn"),
                                            .href("https://github.com/AstvatEreta-Lens"),
                                            .target(.blank),
                                            .raw("""
                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M12 0C5.37 0 0 5.37 0 12c0 5.31 3.435 9.795 8.205 11.385.6.105.825-.255.825-.57 0-.285-.015-1.23-.015-2.235-3.015.555-3.795-.735-4.035-1.41-.135-.345-.72-1.41-1.23-1.695-.42-.225-1.02-.78-.015-.795.945-.015 1.62.87 1.845 1.23 1.08 1.815 2.805 1.305 3.495.99.105-.78.42-1.305.765-1.605-2.67-.3-5.46-1.335-5.46-5.925 0-1.305.465-2.385 1.23-3.225-.12-.3-.54-1.53.12-3.18 0 0 1.005-.315 3.3 1.23.96-.27 1.98-.405 3-.405s2.04.135 3 .405c2.295-1.56 3.3-1.23 3.3-1.23.66 1.65.24 2.88.12 3.18.765.84 1.23 1.905 1.23 3.225 0 4.605-2.805 5.625-5.475 5.925.435.375.81 1.095.81 2.22 0 1.605-.015 2.895-.015 3.3 0 .315.225.69.825.57A12.02 12.02 0 0024 12c0-6.63-5.37-12-12-12z"/></svg>
                                        """)
                                        ),
                                        // LinkedIn
                                        .a(
                                            .class("p-2 text-ghibli-text/60 hover:text-ghibli-accent hover:-translate-y-1 transition-all duration-300 magnetic-btn"),
                                            .href("https://www.linkedin.com/in/ahmad-al-wabil-44866a223/"),
                                            .target(.blank),
                                            .raw("""
                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/></svg>
                                        """)
                                        ),
                                        // Instagram
                                        .a(
                                            .class("p-2 text-ghibli-text/60 hover:text-ghibli-accent hover:-translate-y-1 transition-all duration-300 magnetic-btn"),
                                            .href("https://instagram.com/ahmadalwabil"),
                                            .target(.blank),
                                            .raw("""
                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/></svg>
                                        """)
                                        ),
                                        // Dev.to
                                        .a(
                                            .class("p-2 text-ghibli-text/60 hover:text-ghibli-accent hover:-translate-y-1 transition-all duration-300"),
                                            .href("https://dev.to/astvateretalens"),
                                            .target(.blank),
                                            .raw("""
                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M7.42 10.05c-.18-.16-.46-.23-.84-.23H6l.02 2.44.04 2.45.56-.02c.41 0 .63-.07.83-.26.24-.24.26-.36.26-2.2 0-1.91-.02-1.96-.29-2.18zM0 4.94v14.12h24V4.94H0zM8.56 15.3c-.44.58-1.06.77-2.53.77H3.71V7.93h2.22c1.21 0 1.69.07 2.22.35.63.33 1.14.96 1.3 1.64.08.32.11 1.3.11 2.87 0 1.9-.04 2.1-.2 2.51zm4.64-.18H10.5V7.93h2.7v1.44h-1.22v1.65h1.16v1.41h-1.16v1.25h1.22v1.44zm6.05-.15l-.75-.68-.84 3.75h-1.39l-1.04-4.84c-.58-2.66-.99-4.66-1.03-4.99-.07-.5-.07-.58.12-.58h1.45c0 .19.23 1.25.75 3.51l.46 2.01.5-2.02c.48-1.93.57-2.31.57-2.52.01-.19.01-.19.68-.19h.67l-1.15 5.55z"/></svg>
                                        """)
                                        )
                                    )
                                )
                        ),
                        
                        // Kanan: Foto Profil
                        .div(
                            .class("flex-shrink-0 relative group order-1 lg:order-2"),
                            .div(
                                .class("absolute -inset-2 bg-ghibli-accent/20 rounded-full blur-xl group-hover:bg-ghibli-accent/40 transition-colors duration-500")
                            ),
                            .img(
                                .src("img/IMG_1706.webp"),
                                .alt("Ahmad Wabil Profile"),
                                .class("relative w-64 h-64 md:w-80 md:h-80 object-cover rounded-full border-4 border-[#1e2b2e]/50 shadow-2xl hover:scale-105 transition-transform duration-500")
                            )
                        ),
                        
                    ),
                    //MARK: PROJECTS
                    .section(
                        .id("projects"),
                        .class("min-h-[80vh] flex flex-col justify-center py-20 border-t border-ghibli-text/10 mt-16 scroll-mt-24 scroll-reveal"),
                        .h2(
                            .class("text-3xl md:text-4xl font-serif mb-12 text-center font-bold text-ghibli-text tracking-wide"),
                            .attribute(named: "data-i18n", value: "sections.selectedWorks"),
                            "Selected Works"
                        ),
                        
                            .div(
                                .id("projects-grid"),
                                .class("grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5"),
                                .forEach(MockData.projects) { project in
                                        .div(
                                            .class("project-item hidden w-full h-full"),
                                            .projectCard(for: project)
                                        )
                                }
                            ),
                        
                            .div(
                                .id("projects-pagination"),
                                .class("mt-12 flex items-center justify-between border-t border-ghibli-text/10 px-0")
                            )
                    ),
                //MARK: EXPERIENCES
                    .section(
                        .id("experiences"),
                        .class("min-h-[40vh] flex flex-col justify-center overflow-x-hidden py-20 border-t border-ghibli-text/5 scroll-reveal"),
                        .h2(
                            .class("text-3xl md:text-4xl font-serif mb-16 text-center text-ghibli-text font-bold tracking-wide"),
                            .attribute(named: "data-i18n", value: "sections.experiences"),
                            "Companies I've Worked With"
                        ),
                        
                        // Marquee Bergerak (Kiri ke Kanan)
                        .div(
                            .class("relative flex w-full overflow-hidden mb-16 foggy-mask"),
                            .style("-webkit-mask-image: linear-gradient(to right, transparent, black 15%, black 85%, transparent);"),
                            .div(
                                .class("flex w-max animate-marquee-right items-center hover:[animation-play-state:paused] will-change-transform"),
                                .forEach(1...4) { _ in
                                        .div(
                                            .class("flex items-center"),
                                            .forEach(["1.png", "2.png", "pertamina-seeklogo.png", "3.png"]) { logo in
                                                    .div(
                                                        .class("mx-2 md:mx-6 px-5 md:px-8 py-4 md:py-6 bg-white border border-black/5 rounded-2xl md:rounded-3xl shadow flex items-center justify-center group hover:-translate-y-1 transition-transform duration-300 flex-shrink-0"),
                                                        .img(
                                                            .src("img/logo/\(logo)"),
                                                            .alt("Company Logo"),
                                                            .class("h-8 md:h-16 w-auto object-contain opacity-70 group-hover:opacity-100 grayscale-[50%] group-hover:grayscale-0 transition-all duration-300 max-w-[100px] md:max-w-[160px]")
                                                        )
                                                    )
                                            }
                                        )
                                }
                            )
                        )
                    ),
                //MARK: CERTIFICATES
                    .section(
                        .id("certificates"),
                        .class("min-h-[50vh] flex flex-col justify-center overflow-x-hidden py-20 border-t border-ghibli-text/5 scroll-reveal"),
                        .h2(.class("text-3xl md:text-4xl font-serif mb-16 text-center text-ghibli-text font-bold tracking-wide"), "Certifications"),
                        .div(
                            .class("relative w-full max-w-4xl mx-auto rounded-3xl overflow-hidden shadow-2xl bg-ghibli-card border border-ghibli-text/10 group"),
                            .div(
                                .id("cert-carousel-track"),
                                .class("flex w-full aspect-[3/2] md:aspect-[3/2] transition-transform duration-500 ease-in-out"),
                                .forEach(MockData.certificates.enumerated()) { index, cert in
                                    .img(.src("img/certif/\(cert)"), .alt("Certificate \(index + 1)"), .class("w-full h-full object-cover flex-shrink-0"))
                                }
                            ),
                            .div(
                                .id("cert-carousel-dots"),
                                .class("absolute bottom-6 left-1/2 -translate-x-1/2 flex space-x-3 z-10 p-3 bg-black/40 backdrop-blur-md rounded-full shadow-lg"),
                                .forEach(MockData.certificates.enumerated()) { index, _ in
                                    .button(
                                        .id("cert-dot-\(index)"),
                                        .class("w-3 h-3 rounded-full transition-all duration-300 border-none outline-none cursor-pointer" + (index == 0 ? " bg-white scale-125" : " bg-white/50")),
                                        .attribute(named: "onclick", value: "goToCert(\(index))")
                                    )
                                }
                            )
                        )
                    ),
                //MARK: CONTACT
                    .section(
                        .id("contact"),
                        .class("min-h-[70vh] flex flex-col justify-center py-20 items-center text-center border-t border-ghibli-text/5 scroll-reveal"),
                        .div(
                            .class("max-w-2xl w-[90%] md:w-full bg-ghibli-card/40 backdrop-blur-sm border border-ghibli-text/5 p-8 md:p-16 rounded-3xl md:rounded-[2.5rem] shadow-2xl hover:shadow-ghibli-accent/10 transition-shadow duration-500"),
                            .h2(
                                .class("text-3xl md:text-4xl font-serif mb-6 font-bold text-ghibli-text tracking-wide"),
                                .attribute(named: "data-i18n", value: "contact.title"),
                                "Let's Connect"
                            ),
                            .p(
                                .class("text-lg md:text-xl text-ghibli-text/80 mb-10 leading-relaxed"),
                                .attribute(named: "data-i18n", value: "contact.description"),
                                "Currently open for new opportunities. Whether you have a question or just want to say hi, I'll try my best to get back to you!"
                            ),
                            .a(
                                .class("inline-block px-8 md:px-10 py-3 md:py-4 bg-ghibli-accent text-ghibli-bg rounded-xl md:rounded-2xl font-serif font-bold text-base md:text-lg hover:bg-ghibli-accent-hover hover:-translate-y-1 hover:shadow-xl transition-all duration-300"),
                                .href("mailto:ahmadalwabil201@gmail.com"),
                                .attribute(named: "data-i18n", value: "contact.cta"),
                                "Say Hello 👋"
                            )
                        )
                    )
                ),
                .footer(
                    .class("text-center py-8 text-sm text-ghibli-sub"),
                    .p(
                        .attribute(named: "data-i18n", value: "footer.copyright"),
                        "© 2026 Ahmad Al Wabil. Built with Publish, a Swift-powered static site generator."
                    )
                ),
                
                //MARK: PROJECT MODALS
                .div(
                    .id("modals-container"),
                    .forEach(MockData.projects) { project in
                            .div(
                                .id("modal-\(project.id)"),
                                .class("fixed inset-0 z-[100] hidden flex items-end md:items-center justify-center"),
                                
                                // Backdrop Overlay
                                .div(
                                    .id("modal-backdrop-\(project.id)"),
                                    .class("absolute inset-0 bg-[#121A1C]/70 backdrop-blur-sm opacity-0 transition-opacity duration-300"),
                                    .attribute(named: "onclick", value: "closeModal('\(project.id)')")
                                ),
                                
                                // Modal Card
                                .div(
                                    .id("modal-content-\(project.id)"),
                                    .class("relative w-full md:max-w-4xl glass-modal rounded-t-[2.5rem] md:rounded-[2.5rem] shadow-2xl opacity-0 max-h-[92vh] flex flex-col pointer-events-auto"),
                                    
                                    // Modal Header Bar
                                    .div(
                                        .class("w-full flex justify-end items-center px-6 pt-6 pb-2 shrink-0 relative"),
                                        .div(.class("w-16 h-1.5 bg-ghibli-text/20 rounded-full mx-auto md:hidden absolute left-1/2 -translate-x-1/2 top-4")),
                                        .button(
                                            .attribute(named: "onclick", value: "closeModal('\(project.id)')"),
                                            .class("w-10 h-10 bg-ghibli-text/5 hover:bg-ghibli-accent hover:text-white rounded-full flex items-center justify-center text-ghibli-text transition-colors outline-none cursor-pointer border-none z-10 font-bold"),
                                            .text("✕")
                                        )
                                    ),
                                    
                                    // Scrollable Content Container
                                    .div(
                                        .class("px-8 pb-10 overflow-y-auto w-full custom-scrollbar"),
                                        // Hero Carousel
                                        .div(
                                            .class("relative w-full aspect-[4/3] md:aspect-[21/9] bg-[#121A1C]/50 rounded-3xl overflow-hidden mb-10 shadow-xl border border-ghibli-text/5 group"),
                                            
                                            // Fallback if no display images
                                            .if(project.imagesDisplay.isEmpty,
                                                .img(.class("w-full h-full object-cover"), .src("img/project/\(project.thumbnail)"), .alt(project.title))
                                            ),
                                            
                                            // Carousel Track
                                            .if(!project.imagesDisplay.isEmpty,
                                                .div(
                                                    .id("carousel-track-\(project.id)"),
                                                    .class("flex w-full h-full transition-transform duration-500 ease-in-out"),
                                                    .forEach(Array(project.imagesDisplay.enumerated())) { item in
                                                            .img(.class("w-full h-full object-cover flex-shrink-0"), .src("img/project/\(item.element)"), .alt("\(project.title) Snapshot \(item.offset + 1)"))
                                                    }
                                                )
                                            ),
                                            
                                            // Pagination Dots (Only if more than 1 image)
                                            .if(project.imagesDisplay.count > 1,
                                                .div(
                                                    .class("absolute bottom-4 left-1/2 -translate-x-1/2 flex space-x-2 z-10 p-2 md:p-3 bg-black/40 backdrop-blur-md rounded-full shadow-lg"),
                                                    .forEach(Array(project.imagesDisplay.enumerated())) { item in
                                                            .div(
                                                                .id("carousel-dot-\(project.id)-\(item.offset)"),
                                                                .class(item.offset == 0 ? "w-4 h-2 rounded-full transition-all duration-300 bg-white" : "w-2 h-2 rounded-full transition-all duration-300 bg-white/50")
                                                            )
                                                    }
                                                )
                                            )
                                        ),
                                        .h2(.class("text-3xl md:text-4xl font-serif text-ghibli-text font-bold mb-4 tracking-wide text-center"), .text(project.title)),
                                        .p(
                                            .class("text-ghibli-accent text-lg font-medium mb-10 text-center"),
                                            .attribute(named: "data-i18n", value: "projects.\(project.id).subtitle"),
                                            .text(project.subtitle)
                                        ),
                                        
                                            .div(
                                                .class("flex flex-wrap justify-center gap-3 mb-10"),
                                                .forEach(project.tags) { tag in
                                                        .span(.class("text-sm bg-ghibli-accent/10 text-ghibli-accent border border-ghibli-accent/20 font-medium px-5 py-2 rounded-full tag-pill"), .text(tag))
                                                }
                                            ),
                                        
                                            .section(
                                                .class("prose prose-lg md:prose-xl prose-invert max-w-3xl mx-auto text-ghibli-text/90 leading-relaxed font-sans text-left space-y-6"),
                                                .attribute(named: "data-i18n-html", value: "projects.\(project.id).description"),
                                                .forEach(project.description.components(separatedBy: "\n\n")) { paragraph in
                                                        .p(.text(paragraph))
                                                }
                                            )
                                    )
                                )
                            )
                    }
                ),
                
                    .script(.src("js/main.js"))
            )
        )
    }
    
    // Protokol pabrik standar Publish
    func makeSectionHTML(for section: Section<MyWeb>, context: PublishingContext<MyWeb>) throws -> HTML { HTML() }
    func makeItemHTML(for item: Item<MyWeb>, context: PublishingContext<MyWeb>) throws -> HTML { HTML() }
    func makePageHTML(for page: Page, context: PublishingContext<MyWeb>) throws -> HTML {
        if page.path.string.hasPrefix("project/") {
            let id = page.path.string.replacingOccurrences(of: "project/", with: "")
            if let project = MockData.projects.first(where: { $0.id == id }) {
                return ProjectDetailPage.render(for: project, context: context)
            }
        }
        return HTML()
    }
    func makeTagListHTML(for page: TagListPage, context: PublishingContext<MyWeb>) throws -> HTML? { nil }
    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<MyWeb>) throws -> HTML? { nil }
}
