import SwiftUI
@main struct MobileOpsAgentApp: App {
 @StateObject var agent=AgentEngine()
 var body: some Scene { WindowGroup { ContentView().environmentObject(agent) } }
}