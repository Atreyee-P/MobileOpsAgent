import Foundation
enum StepStatus { case running, success, warning, failed }
struct AgentStep: Identifiable { let id=UUID(); let title:String; let detail:String; let status:StepStatus }
struct ToolCall: Identifiable { let id=UUID(); let name:String; let result:String }