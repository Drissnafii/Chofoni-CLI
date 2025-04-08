# BEAST MODE: Auto-detects API endpoints + caches them
function chofoni {
    param (
        [string]$url = "/api/profile"  # Now accepts SHORT paths (or full URLs)
    )

    # 1. AUTO-DETECT BASE URL (if not provided)
    $script:ApiBaseUrl = "http://127.0.0.1:8000"
    if (-not $url.StartsWith("http")) {
        $url = "$script:ApiBaseUrl$url"
    }

    # 2. FETCH ENDPOINTS ON FIRST RUN (then cache)
    if (-not $script:DiscoveredEndpoints) {
        try {
            $routes = Invoke-RestMethod "$script:ApiBaseUrl/routes" -ErrorAction SilentlyContinue
            $script:DiscoveredEndpoints = $routes.endpoints | ForEach-Object { "$script:ApiBaseUrl$_" }
            Write-Host "Discovered API endpoints:" -ForegroundColor Cyan
            $script:DiscoveredEndpoints | ForEach-Object { Write-Host "  -> $_" -ForegroundColor DarkCyan }
        }
        catch {
            Write-Warning "WARNING: No /routes endpoint found. Falling back to defaults."
            $script:DiscoveredEndpoints = @(
                "$script:ApiBaseUrl/api/profile",
                "$script:ApiBaseUrl/api/projects",
                "$script:ApiBaseUrl/api/skills"
            )
        }
    }

    # 3. SMART AUTOCOMPLETE (even for partial paths!)
    Register-ArgumentCompleter -CommandName chofoni -ParameterName url -ScriptBlock {
        param ($commandName, $parameterName, $wordToComplete)
        $wordToComplete = if ($wordToComplete -notmatch "^http") { "/api/$wordToComplete" } else { $wordToComplete }
        $script:DiscoveredEndpoints | Where-Object { $_ -like "*$wordToComplete*" } | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
    }

    # 4. FETCH + PRETTY-PRINT (like always)
    try {
        $response = Invoke-RestMethod -Uri $url -Method Get
        $response | ConvertTo-Json -Depth 10
    }
    catch {
        Write-Error "!! FAILED to fetch $url. Is your API running? Full error: $_"
    }
}

# Shortcut alias
function cfn { chofoni @args }