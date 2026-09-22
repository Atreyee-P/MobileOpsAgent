# Mobile Ops Agent — Gemini + SwiftUI

Mobile Ops Agent

An LLM-powered Mobile Operations Agent built with SwiftUI, Swift and Gemini function calling.

The project explores how an AI agent can investigate application/API issues by using tools, analyzing their results and producing a final incident report.

Problem

When an application experiences API failures or performance problems, engineers typically need to check several different sources:

API health
Recent errors
Response times
Application logs
Possible remediation
Verification after remediation

Instead of manually checking each source, this project explores an agent-driven approach.

Agent Workflow
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
How It Works

The user describes an application problem.

Gemini analyzes the request and decides which tool should be called.

The Swift application executes the requested tool and sends the result back to Gemini.

Gemini can then decide whether another tool is required.

The process continues until the agent has enough information to produce a final report.

User
  ↓
SwiftUI
  ↓
Agent Engine
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
Next Function Call
  ↓
Final Report
Tools

The current prototype includes tools for:

API Health

Checks whether an API/service is healthy.

Recent Errors

Searches recent application/service errors.

Response Times

Checks API response-time information.

Log Analysis

Analyzes simulated application logs to identify potential issues.

Remediation

Suggests a possible remediation based on the investigation.

Verification

Checks the result after remediation.

Technologies
Swift
SwiftUI
Gemini API
Gemini Function Calling
Async/Await
URLSession
Tool-based Agent Architecture
Architecture
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
Example

A user might report:

"Users are experiencing slow checkout and occasional API failures."

The agent can investigate:

Check API Health
        ↓
Search Recent Errors
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

The goal is not simply to generate a text response, but to demonstrate how an LLM can interact with application-defined tools.

Security

The Gemini API key should not be embedded in the production application.

This project uses an API key entered at runtime for development/testing.

For a production implementation, the recommended architecture would place the Gemini API behind a secure backend rather than exposing the API key inside the iOS application.

Future Improvements

Possible next steps:

Real application telemetry
Real API monitoring
Crash/log integration
Backend-based Gemini access
Authentication and authorization
Human approval before remediation
Persistent incident history
Production observability integration
Author

Atreyee P.

Senior iOS Developer exploring Generative AI and Agentic AI.
