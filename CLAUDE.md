# Claude Code: Python Command Suite Guidelines

You are working on tools that complement Claude Code. The project has just started. 

We currently have a `/.claude_example` directory full of incredible agents, commands and hooks pulled from a similar repository that focuses on different languages. Our project focuses on Python development. 

## Requirements

* Every tool MUST follow documentation and best practices set out by Boris and Anthropic's claude code team. ([Anthropic Claude Code docs](https://context7.com/anthropics/claude-code))
* Tools primary focus should be Python development and code generation, setup or configuration steps, or library/API documentation. 
* UV Astral package manager should be used to install and update packages - `uv add`, and for running uv commands - `uv run`.
* pyhton installed as 'python3' 

## Current Stage

* USE context7 to research and document in `/AI_DOCS/py_command_suite/*.md` best practices for claude code features, agents, commands, hooks, output styles, etc.
* CREATE a `/project_prime` command that 'primes' claude code with py_command_suite project specific information. This should differ from a `CLAUDE.md` file in that it is for providing context to claude and his agents. Agents differ in a key way as they are interacted with by the main claude agent, meaning agents have ZERO project context unless the main agent has a way to prime it. 

## Directory Information

* `/.claude` contains all claude code agents, commands, hooks, etc. 
* `/AI_DOCS` [PROJECT SPECIFIC DIRECTORY], exists in ALL projects and contains documentation for whatever project is being worked on. This often would include documentation from context7 for external libraries and APIs used by the project.

## Context7 Usage

### MCP

Always use context7 when I need code generation, setup or configuration steps, or library/API documentation. This means you should automatically use the Context7 MCP tools to resolve library id and get library docs without me having to explicitly ask.

### API

Use the Context7 API to search libraries and fetch documentation programmatically

### API URL
[https://context7.com/api/v1](https://context7.com/api/v1)

### API Key
contained in `.env` file

### Search
```bash
curl -X GET "https://context7.com/api/v1/search?query=react+hook+form" \
  -H "Authorization: Bearer CONTEXT7_API_KEY"
```

### Search Parameters
* `query`: Search term for finding libraries

### Search Response
```json
{
  "results": [
    {
      "id": "/react-hook-form/documentation",
      "title": "React Hook Form",
      "description": "📋 Official documentation", 
      "totalTokens": 50275,
      "totalSnippets": 274,
      "stars": 741,
      "trustScore": 9.1,
      "versions": []
    },
    ...
  ]
}
```

### Get Docs
```bash
curl -X GET "https://context7.com/api/v1/vercel/next.js?type=txt&topic=ssr&tokens=5000" \
  -H "Authorization: Bearer CONTEXT7_API_KEY"
```

### Get Docs Parameters
* `type`: Response format (txt, json)
* `topic`: Filter by topic
* `tokens`: Token limit

### Get Docs Response Format - TXT
```text
TITLE: Dynamically Load Component Client-Side Only in Next.js Pages Router
DESCRIPTION: Explains how to disable Server-Side Rendering (SSR) for a dynamically...
SOURCE: https://github.com/vercel/next.js/blob/canary/docs/01-app/02-guides/lazy...

LANGUAGE: JSX
CODE:
```
```jsx
'use client'

import dynamic from 'next/dynamic'

const DynamicHeader = dynamic(() => import('../components/header'), {
  ssr: false,
})
```

---

```text
TITLE: Resolve `Math.random()` SSR Issues with React Suspense in Next.js
DESCRIPTION: This solution demonstrates how to wrap a Client Component that uses...
...
```

### Get Docs Response Format - JSON
```json
[
  {
    "codeTitle": "Configure Next.js for Server-Side Rendering",
    "codeDescription": "These snippets illustrate how to modify...",
    "codeLanguage": "diff",
    "codeTokens": 199,
    "codeId": "https://github.com/vercel/next.js/...",
    "pageTitle": "Items",
    "codeList": [
      {
        "language": "diff",
        "code": "--- a/package.json\n+++ b/package.json..."
      }
    ],
    "relevance": 0.016666668
  },
  ...
]
```