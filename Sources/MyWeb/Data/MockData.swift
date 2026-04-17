import Foundation

struct MockData {
    static let projects: [Project] = [
        Project(
            id: "project-1",
            title: "Talangin",
            subtitle: "Track Shared Expenses",
            description: """
            Talangin is an application designed to help young people manage shared expenses across multiple social circles using smart receipt scanning and automatic calculations, making payments transparent, fair, and free from miscalculations or the awkwardness of asking others to pay.
            
            I served as the Tech Lead on this project, responsible for defining the technical architecture, leading feature development, and managing the deployment to TestFlight.
            """,
            date: "Jan 2026",
            thumbnail: "T1.png",
            tags: ["SwiftUI", "SwiftData", "Vision", "OCR"],
            imagesDisplay: ["T1.png", "T2.png"]
        ),
        Project(
            id: "project-2",
            title: "Klar",
            subtitle: "macOS Customer Service Chat Platform",
            description: """
            Klar is a macOS application designed to help business owners and customer service teams efficiently handle repetitive technical customer inquiries through AI-powered automation. The application integrates with the WhatsApp Business API, allowing customers to interact seamlessly via WhatsApp while the AI system handles and responds to common technical queries.
            
            I worked as the Tech Lead on this project, where I was responsible for defining the technical architecture, connecting the WhatsApp Business API with the backend system, and integrating the backend AI services. In addition, I implemented frontend API calls to ensure smooth communication between the macOS application, backend services, and the AI system, while coordinating the overall development process.
            """,
            date: "Dec 2025",
            thumbnail: "klar-display1.webp",
            tags: ["SwiftUI", "AppKit", "Combine", "Network", "Ollama", "nodeJs", "Python", "Whatsapp Business API"],
            imagesDisplay: ["klar-display1.webp", "klar-display2.webp", "klar-display3.webp", "klar-display4.webp"]
        ),
        Project(
            id: "project-3",
            title: "Coco.co",
            subtitle: "Redesign Snorkeling App",
            description: """
            Coco.co is a redesign project aimed at improving user acquisition by introducing new features and enhancing the existing design. It is a snorkeling trip application that provides users with information about snorkeling destinations. In this project, I worked as an iOS developer, collaborating closely with the team.

            We developed a shared digital space feature that allows contributors and planners to view, edit, and confirm trip details collaboratively, reducing fragmented communication and minimizing reliance on a single planner.
            """,
            date: "Sep 2025",
            thumbnail: "cc-display1.webp",
            tags: ["CoreData", "UIKit", "SwiftUI", "Network", "SwiftUI", "Swift Testing", "Combine"],
            imagesDisplay: ["cc-display1.webp", "cc-display2.webp"]
        ),
        Project(
            id: "project-4",
            title: "Air Love",
            subtitle: "Cooperative Mobile Game",
            description: """
            Air Love is a cooperative mobile game built using the Unity game engine and Unity Netcode for GameObjects to support a seamless two-player experience. The game assigns players to different but interdependent roles that must be performed simultaneously in order to progress.
            
            The gameplay is designed to emphasize cooperation through shared objectives, encouraging communication and teamwork between players. By focusing on coordinated actions and collaborative problem-solving, the game provides a structured cooperative experience intended to strengthen interaction and engagement between players.
            
            I worked as a game developer on this project, contributing to the development of the game mechanics proof of concept and implementing a parallax background system. This project marked my first experience in game development using Unity 2D.
            """,
            date: "July 2025",
            thumbnail: "al-thumbnail.webp",
            tags: ["Unity2d", "C#"],
            imagesDisplay: ["al-display1.webp", "al-display2.webp", "al-display3.webp", "al-display4.webp"]
        ),
        Project(
            id: "project-5",
            title: "FenScan",
            subtitle: "Scan Hanzi for non-halal Ingredients",
            description: """
                FenScan is an iOS application developed to assist travelers in Taiwan who are not familiar with Chinese Hanzi when purchasing souvenirs for relatives or family members who cannot consume food or beverage products containing non-halal ingredients. The application utilizes machine learning to classify halal and non-halal ingredients written in Chinese Hanzi.

                I worked as an iOS developer on this project and also contributed to the data training process. The main challenges involved data collection, model training and evaluation, and integrating the trained machine learning model into the iOS application
                """,
            date: "Juny 2025",
            thumbnail: "fenscan-display1.webp",
            tags: [ "CoreML", "Combine", "Vision", "OCR","SwiftData", "VisionKit"],
            imagesDisplay: ["fenscan-display1.webp", "fenscan-display2.webp"]
        ),
        Project(
            id: "project-6",
            title: "SwiftPark",
            subtitle: "Managing Valet Parking App",
            description: """
                SwiftPark is an iOS application developed to help valet parking officers track and manage vehicles entering valet parking areas. The application simplifies the check-in and check-out process by enabling accurate data recording, real-time vehicle status tracking, and organized vehicle management. An OCR feature is used to extract text from captured images, reducing the need for manual data entry.

                 I worked as a developer on this project, and the main challenge was implementing OCR to reliably convert images into text that could be used as structured data within the application.
                """,
            date: "Mei 2025",
            thumbnail: "SP3.png",
            tags: ["CoreData", "AvFoundation", "Vision", "Combine", "VisionKit", "OCR"],
            imagesDisplay: ["SP3.png","SP2.png","SP4.png","SP1.png"]
        ),
    ]
    
    static let certificates: [String] = ["certif-11.webp","certif-1.webp", "certif-2.webp", "certif-3.png", "certif-4.png", "certif-5.png", "certif-6.png", "certif-7.png", "certif-8.png", "certif-9.png", "certif-10.png"]
}
