import SwiftUI
struct ContentView:View {
 @EnvironmentObject var agent:AgentEngine
 var body:some View { NavigationStack { ScrollView { VStack(alignment:.leading,spacing:16) {
  Text("Mobile Ops Agent").font(.largeTitle.bold())
  Text("Gemini + Function Calling").font(.headline)
  VStack(alignment:.leading,spacing:10) {
   SecureField("Gemini API key",text:$agent.apiKey).textFieldStyle(.roundedBorder)
   TextField("Gemini model",text:$agent.model).textFieldStyle(.roundedBorder)
   TextField("Incident",text:$agent.incident,axis:.vertical).textFieldStyle(.roundedBorder)
  }.padding().background(.thinMaterial).clipShape(RoundedRectangle(cornerRadius:16))
  if agent.running { HStack { ProgressView(); Text("Gemini is investigating..."); Spacer() }.padding().background(.thinMaterial).clipShape(RoundedRectangle(cornerRadius:12)) }
  ForEach(agent.steps) { s in HStack(alignment:.top) { Image(systemName:s.status == .running ? "circle.dotted" : s.status == .failed ? "xmark.circle" : "checkmark.circle.fill"); VStack(alignment:.leading){Text(s.title).bold();Text(s.detail).foregroundStyle(.secondary).textSelection(.enabled)};Spacer() }.padding(.vertical,6) }
  if !agent.calls.isEmpty { Text("Function calls").font(.headline); ForEach(agent.calls){c in VStack(alignment:.leading){Text(c.name).bold();Text(c.result).font(.caption.monospaced())}.padding().background(.thinMaterial).clipShape(RoundedRectangle(cornerRadius:12))} }
  if let a=agent.answer { Text(a).padding().background(.thinMaterial).clipShape(RoundedRectangle(cornerRadius:12)).textSelection(.enabled) }
  Button { Task{await agent.run()} } label:{ HStack{if agent.running{ProgressView().tint(.white)};Text(agent.running ? "Investigating..." : "Run Gemini Agent")}.frame(maxWidth:.infinity) }.buttonStyle(.borderedProminent).disabled(agent.running || agent.apiKey.isEmpty)
 }.padding() }.navigationTitle("Ops Agent").toolbar{ToolbarItem{Button("Reset"){agent.reset()}}} } }
}