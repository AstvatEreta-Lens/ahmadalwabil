import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct MyWeb: Website {
    enum SectionID: String, WebsiteSectionID {
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {}

    // Update these properties to configure your website:
    var url = URL(string: "https://ahmadwabil.com")!
    var name = "Ahmad Al Wabil | iOS Developer"
    var description = "Personal portfolio showcasing iOS projects and Swift development."
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// Generate website using our new Clean Architecture + Dark Ghibli SPA Theme:
try MyWeb().publish(
    using: [
        .copyResources(),
        .addMarkdownFiles(),
        .sortItems(by: \.date, order: .descending),
        .generateHTML(withTheme: .ghibliSPATheme),
        .generateRSSFeed(including: [.posts]),
        .generateSiteMap()
    ]
)
