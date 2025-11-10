# PowerShell Script to Push CMP701 Repository to GitHub
# Run this script: .\push-to-github.ps1

Write-Host "🚀 Starting GitHub Push Process..." -ForegroundColor Cyan
Write-Host ""

# Check if git is installed
try {
    $gitVersion = git --version
    Write-Host "✅ Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git is not installed. Please install Git first." -ForegroundColor Red
    exit 1
}

# Initialize git if not already initialized
if (-not (Test-Path .git)) {
    Write-Host "📦 Initializing Git repository..." -ForegroundColor Yellow
    git init
    Write-Host "✅ Git repository initialized" -ForegroundColor Green
} else {
    Write-Host "✅ Git repository already initialized" -ForegroundColor Green
}

# Check remote
Write-Host ""
Write-Host "🔗 Checking remote repository..." -ForegroundColor Yellow
$remoteExists = git remote get-url origin 2>$null

if ($remoteExists) {
    Write-Host "✅ Remote 'origin' already exists: $remoteExists" -ForegroundColor Green
} else {
    Write-Host "➕ Adding remote 'origin'..." -ForegroundColor Yellow
    git remote add origin https://github.com/goodluckoguzie/CMP701-Digital-Transformation.git
    Write-Host "✅ Remote added" -ForegroundColor Green
}

# Stage all files
Write-Host ""
Write-Host "📝 Staging all files..." -ForegroundColor Yellow
git add .
Write-Host "✅ Files staged" -ForegroundColor Green

# Check if there are changes to commit
$status = git status --porcelain
if ($status) {
    Write-Host ""
    Write-Host "💾 Committing changes..." -ForegroundColor Yellow
    git commit -m "✨ Enhanced repository with modern navigation, styling, and GitHub Pages setup

- Added comprehensive README with clickable navigation
- Created modern CSS styling with gradients and animations  
- Added GitHub Pages configuration (_config.yml)
- Created index.html for web hosting
- Added navigation templates for weekly modules
- Included setup and improvement documentation
- Enhanced user experience with breadcrumbs and progress indicators"
    Write-Host "✅ Changes committed" -ForegroundColor Green
} else {
    Write-Host "ℹ️  No changes to commit" -ForegroundColor Yellow
}

# Set branch to main
Write-Host ""
Write-Host "🌿 Setting branch to 'main'..." -ForegroundColor Yellow
git branch -M main 2>$null
Write-Host "✅ Branch set to 'main'" -ForegroundColor Green

# Push to GitHub
Write-Host ""
Write-Host "🚀 Pushing to GitHub..." -ForegroundColor Yellow
Write-Host "   (You may be prompted for GitHub credentials)" -ForegroundColor Gray

try {
    git push -u origin main
    Write-Host ""
    Write-Host "✅ Successfully pushed to GitHub!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📋 Next Steps:" -ForegroundColor Cyan
    Write-Host "   1. Go to: https://github.com/goodluckoguzie/CMP701-Digital-Transformation" -ForegroundColor White
    Write-Host "   2. Click Settings → Pages" -ForegroundColor White
    Write-Host "   3. Select source: main branch" -ForegroundColor White
    Write-Host "   4. Your site will be at: https://goodluckoguzie.github.io/CMP701-Digital-Transformation/" -ForegroundColor White
    Write-Host ""
} catch {
    Write-Host ""
    Write-Host "❌ Error pushing to GitHub" -ForegroundColor Red
    Write-Host "   Error: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "💡 Troubleshooting:" -ForegroundColor Yellow
    Write-Host "   - Make sure you're authenticated with GitHub" -ForegroundColor White
    Write-Host "   - Check your internet connection" -ForegroundColor White
    Write-Host "   - Verify the repository exists on GitHub" -ForegroundColor White
    Write-Host ""
}

Write-Host "Script completed!" -ForegroundColor Cyan

