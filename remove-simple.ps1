Write-Host "=== Removing Homework API from Kubernetes ===" -ForegroundColor Cyan

Write-Host "Removing Ingress..." -ForegroundColor Yellow
kubectl delete -f k8s/ingress.yaml -n homework

Write-Host "Removing API Gateway..." -ForegroundColor Yellow
kubectl delete -f k8s/api-gateway.yaml -n homework

Write-Host "Removing microservices..." -ForegroundColor Yellow
kubectl delete -f k8s/auth-service.yaml -n homework
kubectl delete -f k8s/userprofile-service.yaml -n homework
kubectl delete -f k8s/billing-service.yaml -n homework
kubectl delete -f k8s/order-service.yaml -n homework
kubectl delete -f k8s/notification-service.yaml -n homework

Write-Host "Removing databases..." -ForegroundColor Yellow
kubectl delete -f k8s/postgres-billing.yaml -n homework
kubectl delete -f k8s/postgres-orders.yaml -n homework
kubectl delete -f k8s/postgres-notifications.yaml -n homework

Write-Host "Removing RabbitMQ..." -ForegroundColor Yellow
kubectl delete -f k8s/rabbitmq.yaml -n homework

Write-Host "Waiting for resources to be deleted..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

Write-Host "Removing namespace..." -ForegroundColor Yellow
kubectl delete namespace homework

Write-Host "=== Cleanup Complete ===" -ForegroundColor Cyan
Write-Host "All Homework API resources have been removed from Kubernetes." -ForegroundColor Green
