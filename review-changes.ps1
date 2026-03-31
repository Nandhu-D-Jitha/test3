# ============================================================
#  test3 - Review Changes Script
#  Usage: .\review-changes.ps1
# ============================================================
$ErrorActionPreference = "Stop"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  test3 - Change Review" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

if (-not (git rev-parse --is-inside-work-tree 2>$null)) {
    Write-Host "ERROR: Not inside a git repository." -ForegroundColor Red
    exit 1
}

git add -A
$status = git status --porcelain
if (-not $status) {
    Write-Host "No changes detected. Working tree is clean.`n" -ForegroundColor Green
    exit 0
}

Write-Host "Changed files:" -ForegroundColor Yellow
git status --short
Write-Host ""

Write-Host "---- DIFF -------------------------------------------------------" -ForegroundColor DarkGray
git diff --cached
Write-Host "-----------------------------------------------------------------`n" -ForegroundColor DarkGray

$decision = Read-Host "Accept or reject these changes? [accept/reject]"
$decision = $decision.Trim().ToLower()

if ($decision -eq "accept") {
    $msg = Read-Host "Enter a commit message"
    if ([string]::IsNullOrWhiteSpace($msg)) {
        $msg = "Update $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    }
    git commit -m "$msg"
    Write-Host "`n[OK] Changes committed successfully!" -ForegroundColor Green
}
elseif ($decision -eq "reject") {
    git restore --staged .
    git restore .
    git clean -fd --quiet
    Write-Host "`n[X] Changes rejected and rolled back to last commit." -ForegroundColor Red
}
else {
    Write-Host "`nInvalid input. No changes were made. Run the script again." -ForegroundColor Yellow
    git restore --staged .
}
Write-Host ""
