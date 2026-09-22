import SwiftUI


@MainActor final class AgentEngine:ObservableObject {
    
 @Published var apiKey="your key"; @Published var model="gemini-3.5-flash"; @Published var incident="Users are reporting that checkout is failing."
 @Published private(set) var steps:[AgentStep]=[]; @Published private(set) var calls:[ToolCall]=[]; @Published private(set) var answer:String?; @Published private(set) var running=false
 let system="You are a production incident agent. Investigate using tools, do not invent telemetry, correlate evidence, recommend remediation but never claim production changed, then verify."
    
    
 func run() async {
  guard !running else{return}; running=true; steps=[];calls=[];answer=nil; add("Understand incident",incident,.success)
  do {
   let s=GeminiService(key:apiKey,model:model); var contents:[[String:Any]]=[["role":"user","parts":[["text":system+" Incident: "+incident]]]]
   for _ in 0..<10 {
    let reply=try await s.generate(contents:contents,tools:OpsTools.definitions)
    var parts:[[String:Any]]=[]
    if let t=reply.text { parts.append(["text":t]) }
    for c in reply.calls { parts.append(["functionCall":["name":c.name,"args":c.args]]) }
    contents.append(["role":"model","parts":parts])
    if reply.calls.isEmpty { answer=reply.text ?? "Investigation complete."; add("Agent conclusion",answer ?? "",.success); break }
    var results:[[String:Any]]=[]
    for c in reply.calls {
     add(title(c.name),"Gemini selected \(c.name). Running Swift tool...",.running)
     let out=await OpsTools.run(c.name,c.args); calls.append(ToolCall(name:c.name,result:out))
     steps[steps.count-1]=AgentStep(title:title(c.name),detail:out,status:c.name=="verify_remediation" ? .success:.warning)
     results.append(["functionResponse":["name":c.name,"response":["result":out]]])
    }
    contents.append(["role":"user","parts":results])
   }
  } catch {
      print(error.localizedDescription)
      add("Agent error",error.localizedDescription,.failed);answer=error.localizedDescription
  }
  running=false
 }
    
    
    
 func reset(){steps=[];calls=[];answer=nil}
 private func add(_ t:String,_ d:String,_ s:StepStatus){steps.append(.init(title:t,detail:d,status:s))}
 private func title(_ n:String)->String { ["check_api_health":"Check API health","search_recent_errors":"Search recent errors","get_response_times":"Check response times","analyze_logs":"Analyze logs","propose_remediation":"Suggest remediation","verify_remediation":"Verify remediation"][n] ?? n }
}
