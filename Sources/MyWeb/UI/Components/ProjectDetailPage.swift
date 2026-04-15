import Publish
import Plot

struct ProjectDetailPage {
    static func render(for project: Project, context: PublishingContext<MyWeb>) -> HTML {
        HTML(
            .lang(context.site.language),
            .head(
                .title("\(project.title) - Ahmad Wabil"),
                .meta(.charset(.utf8)),
                .meta(.name("viewport"), .content("width=device-width, initial-scale=1")),
                .stylesheet("../../styles/global.css")
            ),
            .body(
                .class("bg-ghibli-bg text-ghibli-text font-sans leading-relaxed m-0 p-0 min-h-screen flex flex-col"),
                
                // Navigation Bar
                .header(
                    .class("w-full bg-white/90 backdrop-blur-md sticky top-0 z-50 border-b border-ghibli-text/10 px-6 py-4 flex items-center justify-between shadow-sm"),
                    .a(
                        .class("flex items-center gap-3 text-ghibli-text font-serif hover:-translate-x-1 hover:text-ghibli-accent transition-all duration-300 no-underline font-bold text-xl"),
                        .href("../../index.html"),
                        .raw("""
                        <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg>
                        """),
                        "Home"
                    ),
                    .div(
                        .class("w-8") // Placeholder to balance flex-between
                    )
                ),
                
                // Main Detail Content
                .main(
                    .class("flex-grow max-w-4xl mx-auto w-full px-6 pt-16 pb-24"),
                    .article(
                        .class("bg-ghibli-card/40 backdrop-blur-md rounded-[2.5rem] border border-ghibli-text/5 p-8 md:p-16 shadow-2xl"),
                        
                        // Header Text
                        .header(
                            .class("mb-16 text-center flex flex-col items-center"),
                            .h1(.class("text-4xl md:text-5xl font-serif font-bold text-ghibli-text mb-6 tracking-wide"), .text(project.title)),
                            .p(.class("text-xl md:text-2xl text-ghibli-accent font-medium mb-10 max-w-2xl leading-relaxed"), .text(project.subtitle)),
                            
                            .div(
                                .class("flex flex-wrap justify-center gap-4 mb-10"),
                                .forEach(project.tags) { tag in
                                    .span(.class("text-sm md:text-base bg-ghibli-accent/10 border border-ghibli-accent/20 text-ghibli-accent px-5 py-2 rounded-full font-medium"), .text(tag))
                                }
                            ),
                            
                            .span(.class("text-base text-ghibli-text/60 italic"), .text(project.date))
                        ),
                        
                        // Hero Thumbnail
                        .div(
                            .class("w-full aspect-[4/3] md:aspect-[21/9] bg-[#1e2b2e]/50 rounded-[2rem] overflow-hidden mb-16 shadow-2xl border border-white/5 relative group"),
                            .img(
                                .class("w-full h-full object-cover group-hover:scale-105 transition-transform duration-700"),
                                .src("../../assets/\(project.thumbnail)"),
                                .alt("\(project.title) cover image")
                            )
                        ),
                        
                        // Project Concept / Description
                        .section(
                            .class("text-lg md:text-xl text-ghibli-text/90 leading-loose max-w-3xl mx-auto font-sans"),
                            .p(.text(project.description))
                        )
                    )
                ),
                
                // Footer
                .footer(
                    .class("text-center py-10 text-sm text-ghibli-sub border-t border-ghibli-text/5 mt-auto"),
                    .p("Coded passionately in Swift. © 2026 Ahmad Wabil")
                )
            )
        )
    }
}
