import Plot

extension Node where Context == HTML.BodyContext {
    static func projectCard(for project: Project) -> Node {
        .article(
            .class("bg-ghibli-card rounded-2xl overflow-hidden hover:-translate-y-2 ghibli-glow transform-gpu transition-all duration-500 block border border-ghibli-text/5"),
            .a(
                .class("no-underline block h-full"),
                .href("javascript:void(0)"),
                .attribute(named: "onclick", value: "openModal('\(project.id)')"),
                .div(
                    .class("flex flex-row md:flex-col h-full"),
                    
                    // Thumbnail
                    .div(
                        .class("w-2/5 md:w-full min-h-[120px] md:h-48 bg-ghibli-card shrink-0 relative overflow-hidden group"),
                        .if(!project.thumbnail.isEmpty,
                            .img(
                                .class("w-full h-full object-cover opacity-80 group-hover:opacity-100 transition-transform duration-500 group-hover:scale-105"),
                                .src("img/project/\(project.thumbnail)"),
                                .alt(project.title)
                            )
                        )
                    ),
                    
                    // Text Description Area
                    .div(
                        .class("p-4 md:p-6 flex flex-col flex-grow"),
                        .h3(.class("text-base md:text-xl text-ghibli-text font-serif m-0 mb-1 font-bold tracking-wide"), .text(project.title)),
                        .h4(
                            .class("text-[11px] md:text-sm text-ghibli-accent m-0 mb-2 md:mb-4 font-medium"),
                            .attribute(named: "data-i18n", value: "projects.\(project.id).subtitle"),
                            .text(project.subtitle)
                        ),
                        
                        // Hide description on mobile to keep it horizontal and compact
                        .p(
                            .class("hidden md:-webkit-box text-sm md:text-base text-ghibli-text/80 mb-4 line-clamp-3"),
                            .attribute(named: "data-i18n", value: "projects.\(project.id).description"),
                            .text(project.description)
                        ),
                        
                        // Tags (limited on mobile visually)
                        .div(
                            .class("flex flex-wrap gap-1.5 md:gap-2 mb-2 md:mb-4"),
                            .forEach(project.tags.prefix(3)) { tag in
                                .span(.class("text-[9px] md:text-xs bg-white/5 border border-ghibli-text/10 text-ghibli-sub px-1.5 md:px-2 py-0.5 md:py-1 rounded"), .text(tag))
                            }
                        ),
                        
                        .span(.class("text-[10px] md:text-sm text-ghibli-text/40 mt-auto"), .text(project.date))
                    )
                )
            )
        )
    }
}
