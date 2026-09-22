# Mobile Ops Agent — Gemini + SwiftUI

Real Gemini function-calling agent for a production-style incident investigation.

Flow:
User incident → Gemini → function call → Swift tool → function result → Gemini → next action → final report.

Tools:
- check_api_health
- search_recent_errors
- get_response_times
- analyze_logs
- propose_remediation
- verify_remediation

Requirements: Xcode 15+, iOS 17+, Gemini API key.

Open MobileOpsAgent.xcodeproj, select an iPhone Simulator, Run, enter your API key and a currently supported Gemini model.

The tools use simulated telemetry so the demo needs no backend.

Production: do not embed an API key in an iOS binary; use an authenticated backend between the app and Gemini.
