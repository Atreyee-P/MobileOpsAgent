import Foundation
enum GeminiError: LocalizedError {
 case missingKey, badResponse(String)
 var errorDescription:String? { switch self { case .missingKey: return "Enter a Gemini API key."; case .badResponse(let s): return s } }
}
struct GeminiCall { let name:String; let args:[String:Any] }
struct GeminiReply { let text:String?; let calls:[GeminiCall] }

struct GeminiService {
 let key:String; let model:String
 func generate(contents:[[String:Any]], tools:[[String:Any]]) async throws -> GeminiReply {
  guard !key.isEmpty else { throw GeminiError.missingKey }
  let m=model.addingPercentEncoding(withAllowedCharacters:.urlPathAllowed) ?? model
     guard let url=URL(string:"https://generativelanguage.googleapis.com/v1beta/models/\(m):generateContent?key=\(key)") else {
         throw GeminiError.badResponse("Invalid Gemini URL.")
     }
     print(url)
  var r=URLRequest(url:url); r.httpMethod="POST"; r.setValue("application/json",forHTTPHeaderField:"Content-Type")
  var body:[String:Any]=["contents":contents]
  if !tools.isEmpty { body["tools"]=[["functionDeclarations":tools]] }
  r.httpBody=try JSONSerialization.data(withJSONObject:body)
     let (data, res) = try await URLSession.shared.data(for: r)

     guard let h = res as? HTTPURLResponse else {
         throw GeminiError.badResponse("Invalid HTTP response")
     }

     print("🔵 Gemini HTTP status:", h.statusCode)

     let responseBody = String(data: data, encoding: .utf8) ?? "<empty response>"

     print("🔵 Gemini response:")
     print(responseBody)

     guard (200...299).contains(h.statusCode) else {
         throw GeminiError.badResponse(responseBody)
     }
  guard let root=try JSONSerialization.jsonObject(with:data) as? [String:Any],
        let c=(root["candidates"] as? [[String:Any]])?.first,
        let content=c["content"] as? [String:Any],
        let parts=content["parts"] as? [[String:Any]] else {
      
      throw GeminiError.badResponse("Invalid Gemini response.")
  }
  var text:String?; var calls:[GeminiCall]=[]
  for p in parts {
   if let t=p["text"] as? String { text=(text ?? "")+t }
   if let f=p["functionCall"] as? [String:Any], let n=f["name"] as? String {
    calls.append(GeminiCall(name:n,args:f["args"] as? [String:Any] ?? [:]))
   }
  }
  return GeminiReply(text:text,calls:calls)
 }
}
