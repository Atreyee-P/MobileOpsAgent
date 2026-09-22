# Mobile Ops Agent 

An **LLM-powered Mobile Operations Agent** built with **SwiftUI, Swift and Gemini Function Calling**.

The agent investigates application/API issues by calling tools, analyzing results, identifying a likely issue, suggesting remediation, and verifying the result.

##  Agent Workflow

   text
User Problem
     ↓
    Agent
     ↓
Check API Health
     ↓
Check Recent Errors
     ↓
Check Response Times
     ↓
Analyze Logs
     ↓
Identify Likely Issue
     ↓
Suggest Remediation
     ↓
Verify
     ↓
Final Report
```

## 🧠 How It Works

The user describes an application problem.

Gemini decides which tool to use → the Swift application executes the tool → the result is sent back to Gemini → Gemini can continue with another tool until it has enough information to generate the final report.

```text
SwiftUI
   ↓
AgentEngine
   ↓
Gemini
   ↓
Function Call
   ↓
Swift Tool
   ↓
Tool Result
   ↓
Gemini
   ↓
Final Report
```

## Tools

- **API Health** — Check service health
- **Recent Errors** — Search recent errors
- **Response Times** — Analyze API performance
- **Log Analysis** — Analyze application logs
- **Remediation** — Suggest possible action
- **Verification** — Verify the result

## Tech Stack

- Swift
- SwiftUI
- Gemini API
- Gemini Function Calling
- Async/Await
- URLSession
- Tool-based Agent Architecture

## Architecture

```text
SwiftUI
   │
   ▼
AgentEngine
   │
   ▼
GeminiService
   │
   ▼
Gemini
   │
   ├── check_api_health
   ├── search_recent_errors
   ├── get_response_times
   ├── analyze_logs
   ├── propose_remediation
   └── verify_remediation
            │
            ▼
       Tool Results
            │
            ▼
          Gemini
            │
            ▼
       Final Report
```

## Security

The Gemini API key is entered at runtime for development/testing.

For production, the API should be accessed through a secure backend rather than exposing the API key inside the iOS application.

## Future Improvements

- Real application telemetry
- Real API monitoring
- Crash and log integration
- Secure backend integration
- Authentication and authorization
- Human approval for remediation
- Persistent incident history

## About

**Atreyee P.**  
Senior iOS Developer exploring **Generative AI and Agentic AI**.
