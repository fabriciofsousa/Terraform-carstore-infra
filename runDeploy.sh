#!/bin/bash

set -e  # Interrompe o script em caso de erro
set -x  # Exibe os comandos no terminal para depuração

REGION="us-east-1"
CLUSTER_NAME="carstore-eks"
export AWS_PROFILE=carstore
export AWS_REGION=us-east-1

# Inicializar e aplicar o Terraform
echo "Inicializando Terraform..."
cd ./envs/dev
terraform init
terraform plan
terraform destroy -auto-approve

# Configurar kubeconfig para o cluster EKS
echo "Configurando o acesso ao cluster EKS..."
aws eks --profile $AWS_PROFILE --region $REGION update-kubeconfig --name $CLUSTER_NAME --alias carstore-eks

# Selecionar o contexto correto
kubectl config use-context carstore-eks

# Validar a conexão com o cluster
echo "Validando a conexão com o cluster EKS..."
kubectl get nodes || { echo "Erro: Não foi possível conectar ao cluster EKS."; exit 1; }

# Aplicar manifests em ordem lógica
echo "Aplicando manifests Kubernetes..."

# Recursos iniciais (usuários, secrets, configmaps)
kubectl apply -f ./k8s/userAdmin.yaml || { echo "Erro ao aplicar userAdmin.yaml"; exit 1; }

# Deployment principal da aplicação
kubectl apply -f ./k8s/deployment.yaml || { echo "Erro ao aplicar deployment.yaml"; exit 1; }

# Service para a aplicação
kubectl apply -f ./k8s/service-clientes.yaml || { echo "Erro ao aplicar service-clientes.yaml"; exit 1; }

# NGINX Ingress Controller (necessário antes do Ingress)
kubectl apply -f ./k8s/ngix.yaml || { echo "Erro ao aplicar ngix.yaml"; exit 1; }

# Componentes de monitoramento
kubectl apply -f ./k8s/metrics.yaml || { echo "Erro ao aplicar metrics.yaml"; exit 1; }
kubectl apply -f ./k8s/dashboard.yaml || { echo "Erro ao aplicar dashboard.yaml"; exit 1; }

# Ingress da aplicação (depois do Service e NGINX estarem prontos)
kubectl apply -f ./k8s/ingress.yaml || { echo "Erro ao aplicar ingress.yaml"; exit 1; }

# Listar recursos para validação
echo "Exibindo Pods, Services e Ingress no cluster..."
kubectl get pods --all-namespaces
kubectl get svc --all-namespaces
kubectl get ingress --all-namespaces

echo "Deploy completo com sucesso! Todos os manifestos aplicados."
