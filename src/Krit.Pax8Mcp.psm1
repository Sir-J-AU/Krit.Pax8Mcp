<#
.SYNOPSIS
    Krit.Pax8Mcp — Kritical Pax8 MCP wiring toolkit for Claude Code, Codex,
    Cursor and any other MCP-aware agent.

.DESCRIPTION
    Single module to install, validate, rotate and remove the Pax8 hosted MCP
    server (https://mcp.pax8.com/v1/mcp) across every supported agent on a
    Kritical operator machine.

    Both auth paths are supported and can coexist:
      - Legacy x-pax8-mcp-token header (no MFA, instant).
      - OAuth 2.1 + PKCE + Dynamic Client Registration (browser MFA on first call).

    Token lives only in the Kritical secrets folder. Never embedded in any repo.

.AUTHOR
    Joshua Finley · Kritical Pty Ltd · https://kritical.net
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Dot-source Private then Public
$here = Split-Path -Parent $PSCommandPath
foreach ($dir in 'Private','Public') {
    $folder = Join-Path $here $dir
    if (Test-Path -LiteralPath $folder) {
        Get-ChildItem -LiteralPath $folder -Filter '*.ps1' -File | Sort-Object Name | ForEach-Object {
            . $_.FullName
        }
    }
}

Export-ModuleMember -Function @(
    'Install-KritPax8Mcp',
    'Get-KritPax8McpStatus',
    'Test-KritPax8Mcp',
    'Update-KritPax8McpToken',
    'Remove-KritPax8Mcp',
    'Write-KritPax8Banner',
    'Get-KritPax8Banner'
)
