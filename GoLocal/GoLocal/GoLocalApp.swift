import SwiftUI
import SwiftData

let dateFormatter = DateFormatter()

@main
struct GoLocalApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss";

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(sharedModelContainer)
        }
    }
}

struct GoLocalApp_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .modelContainer(GoLocalApp().sharedModelContainer)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
    }
}
