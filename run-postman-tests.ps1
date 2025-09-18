# Скрипт для запуска Postman тестов Homework API
Write-Host "=== Running Homework API Postman Tests ===" -ForegroundColor Cyan

# Проверяем, что newman установлен
try {
    $newmanVersion = newman --version
    Write-Host "Newman version: $newmanVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: Newman not found. Please install it with: npm install -g newman" -ForegroundColor Red
    exit 1
}

# Проверяем, что файлы существуют
$collectionFile = "postman/Homework-API-Complete-Tests.postman_collection.json"
$environmentFile = "postman/Homework-API-Complete-Environment.postman_environment.json"

if (-not (Test-Path $collectionFile)) {
    Write-Host "Error: Collection file not found: $collectionFile" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $environmentFile)) {
    Write-Host "Error: Environment file not found: $environmentFile" -ForegroundColor Red
    exit 1
}

Write-Host "Collection: $collectionFile" -ForegroundColor Yellow
Write-Host "Environment: $environmentFile" -ForegroundColor Yellow

# Запускаем тесты с отображением данных запроса и ответа
Write-Host "`nRunning tests with request/response data display..." -ForegroundColor Yellow

newman run $collectionFile `
    --environment $environmentFile `
    --reporters cli `
    --verbose `
    --disable-unicode `
    --timeout-request 30000

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n=== All Tests Passed! ===" -ForegroundColor Green
} else {
    Write-Host "`n=== Some Tests Failed! ===" -ForegroundColor Red
    Write-Host "Check the output above for details." -ForegroundColor Yellow
}

Write-Host "`nTest execution completed." -ForegroundColor Cyan
