Write-Host "=== Deploying Homework API to Kubernetes ===" -ForegroundColor Cyan

Write-Host "Creating namespace..." -ForegroundColor Yellow
kubectl apply -f k8s/namespace.yaml

Write-Host "Deploying databases..." -ForegroundColor Yellow
kubectl apply -f k8s/postgres-billing.yaml -n homework
kubectl apply -f k8s/postgres-orders.yaml -n homework
kubectl apply -f k8s/postgres-notifications.yaml -n homework

Write-Host "Deploying RabbitMQ..." -ForegroundColor Yellow
kubectl apply -f k8s/rabbitmq.yaml -n homework

Write-Host "Waiting for RabbitMQ..." -ForegroundColor Yellow
kubectl wait --for=condition=ready pod -l app=rabbitmq-service -n homework --timeout=300s

Write-Host "Deploying microservices..." -ForegroundColor Yellow
kubectl apply -f k8s/auth-service.yaml -n homework
kubectl apply -f k8s/userprofile-service.yaml -n homework
kubectl apply -f k8s/billing-service.yaml -n homework
kubectl apply -f k8s/order-service.yaml -n homework
kubectl apply -f k8s/notification-service.yaml -n homework

Write-Host "Deploying API Gateway..." -ForegroundColor Yellow
kubectl apply -f k8s/api-gateway.yaml -n homework

Write-Host "Deploying Ingress..." -ForegroundColor Yellow
kubectl apply -f k8s/ingress.yaml -n homework

Write-Host "Waiting for services..." -ForegroundColor Yellow
kubectl wait --for=condition=ready pod -l app=api-gateway -n homework --timeout=300s
kubectl wait --for=condition=ready pod -l app=auth-service -n homework --timeout=300s
kubectl wait --for=condition=ready pod -l app=userprofile-service -n homework --timeout=300s
kubectl wait --for=condition=ready pod -l app=billing-service -n homework --timeout=300s
kubectl wait --for=condition=ready pod -l app=order-service -n homework --timeout=300s
kubectl wait --for=condition=ready pod -l app=notification-service -n homework --timeout=300s

Write-Host "=== Deployment Complete ===" -ForegroundColor Cyan
kubectl get pods -n homework
