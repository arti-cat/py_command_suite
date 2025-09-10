---
name: http
signature:
  url: string
  method: string (optional, default: "GET")
  headers: object (optional)
  prompt: string (optional)
returns:
  ok: boolean
  status_code: number
  content: string
  headers: object
limits:
  timeout_seconds: 30
  max_response_bytes: 1000000
  max_requests_per_session: 10
safety:
  makes_requests: true
  sandbox: true
  allowed_domains: ["docs.*", "api.*", "*.github.com", "*.stackoverflow.com", "*.readthedocs.io"]
  denied_domains: ["*", "localhost", "127.0.0.1", "*.local"]
  allowed_methods: ["GET", "HEAD", "OPTIONS"]
  denied_methods: ["POST", "PUT", "DELETE", "PATCH"]
---

# HTTP Command

Makes safe HTTP requests to documentation and API reference sites.

## Purpose

Enables controlled web access for research and documentation fetching while maintaining security:
- Access to official documentation and API references
- Integration with context pack creation workflows
- Support for AI-powered content extraction and summarization
- Strict domain and method filtering for security

## Usage

```
http(url="https://docs.python.org/3/library/requests.html")
http(url="https://api.github.com/repos/python/cpython", method="GET") 
http(url="https://docs.example.com/api/auth", prompt="Extract authentication examples")
```

## Parameters

**url** (required): Target URL for the HTTP request
- Must be from an allowed domain (documentation sites)
- HTTPS preferred and enforced when possible
- URL validation prevents access to internal/private networks

**method** (optional): HTTP method to use
- Defaults to "GET" for safe, read-only requests
- Only safe methods allowed (GET, HEAD, OPTIONS)
- POST/PUT/DELETE blocked to prevent unintended side effects

**headers** (optional): Custom HTTP headers
- Common headers like User-Agent, Accept can be specified
- Authentication headers blocked for security
- Content-Type automatically set based on request

**prompt** (optional): AI processing instruction
- When provided, content is processed by AI model for extraction
- Useful for getting specific information from large documentation
- Helps create focused context packs from verbose web content

## Return Values

**ok**: Whether the request completed successfully
**status_code**: HTTP response status code (200, 404, etc.)
**content**: Response body content (potentially processed by AI)
**headers**: Response headers as key-value object

## Allowed Domains

**Documentation Sites:**
- `docs.*` - Official documentation sites
- `*.readthedocs.io` - Read the Docs hosted documentation
- `*.github.com` - GitHub repositories and documentation
- `api.*` - API reference and documentation sites

**Community Resources:**
- `*.stackoverflow.com` - Stack Overflow Q&A
- `*.stackexchange.com` - Stack Exchange network sites

**Framework/Library Docs:**
```bash
# ALLOWED
http(url="https://docs.python.org/3/")
http(url="https://fastapi.tiangolo.com/")
http(url="https://api.github.com/")
http(url="https://docs.docker.com/")

# BLOCKED
http(url="https://malicious-site.com/")
http(url="http://localhost:8000/")
http(url="https://internal-api.company.com/")
```

## AI-Powered Content Extraction

When a `prompt` is provided, the response content is processed by an AI model:

```python
# Extract specific information
http(
    url="https://docs.fastapi.tiangolo.com/tutorial/security/",
    prompt="Extract code examples showing OAuth2 implementation"
)

# Summarize documentation
http(
    url="https://docs.python.org/3/library/asyncio.html",
    prompt="Summarize key asyncio concepts and provide usage examples"
)
```

**AI Processing Benefits:**
- Reduces verbose documentation to key points
- Extracts relevant code examples and patterns
- Formats content for better agent consumption
- Maintains citations to original sources

## Error Handling

**Blocked Domain:**
```json
{
  "ok": false,
  "error": "Domain not allowed: malicious-site.com",
  "allowed_domains": ["docs.*", "api.*", "*.github.com", "..."],
  "suggestion": "Use official documentation or API reference sites"
}
```

**Request Timeout:**
```json
{
  "ok": false,
  "error": "Request timed out after 30 seconds",
  "url": "https://slow-docs-site.com/",
  "suggestion": "Try a more specific documentation page"
}
```

**HTTP Error Response:**
```json
{
  "ok": false,
  "status_code": 404,
  "error": "Page not found",
  "url": "https://docs.example.com/missing-page",
  "suggestion": "Check URL spelling or try site search"
}
```

## Content Processing

**Size Limits:**
- Responses larger than 1MB are truncated
- AI processing focuses on most relevant content
- Large responses cached locally to avoid re-fetching

**Format Handling:**
- HTML content converted to markdown for better readability
- JSON responses parsed and formatted
- Binary content rejected with helpful error messages

**Content Validation:**
- Malicious content pattern detection
- Encoding validation and normalization
- Link extraction and validation for citations

## Integration with Research Workflows

**Documentation Gathering:**
```python
# Fetch API documentation for context pack
http(
    url="https://api.stripe.com/docs/payments",
    prompt="Extract payment processing examples and error handling patterns"
)

# Get library usage examples
http(
    url="https://requests.readthedocs.io/en/stable/",
    prompt="Show basic authentication examples with requests library"
)
```

**Context Pack Creation:**
- HTTP responses automatically formatted for context packs
- Version information extracted when available
- Citations and source URLs preserved
- Content optimized for agent consumption

## Rate Limiting and Caching

**Request Limits:**
- Maximum 10 requests per session to prevent abuse
- Domain-specific rate limiting for popular sites
- Automatic retry with backoff for rate limit responses

**Caching Strategy:**
- Successful responses cached for 1 hour by default
- Documentation content cached longer (24 hours)
- Cache invalidation based on content freshness
- Offline fallback for cached content

## Best Practices

**URL Selection:**
- Prefer official documentation over third-party sources
- Use specific page URLs rather than site homepages
- Include version information in documentation URLs when possible

**Prompt Design:**
- Be specific about what information you need
- Ask for code examples when relevant
- Request formatting that works well for agents

**Resource Management:**
- Use caching effectively to minimize redundant requests
- Combine multiple information needs into single, well-crafted prompts
- Monitor request quota usage

**Security Awareness:**
- Only access trusted documentation sites
- Never use for accessing internal or private resources
- Be cautious with dynamic or user-generated content

## Implementation Notes

This command provides secure web access with:
- Comprehensive domain filtering and URL validation
- Integration with AI processing for content extraction
- Response size limits and content validation
- Caching and rate limiting for performance
- Support for documentation-focused research workflows