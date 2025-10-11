# Terraform-carstore-infra
Infraestrutura para o projeto FIAP CarStore utilizando Terraform.

## Estrutura do Projeto
- **modules/eks**: Cluster EKS (Elastic Kubernetes Service)
- **modules/cognito**: Autenticação e autorização com AWS Cognito
- **modules/rds**: Banco PostgreSQL (RDS)
- **modules/dynamodb**: Banco DynamoDB (Solução NoSQL)
- **modules/ecr**: Repositório de imagens Docker (ECR)
- **modules/vpc**: Rede VPC, subnets, internet gateway, etc.
- **envs/dev**: Ambiente de desenvolvimento (main.tf, variables.tf, outputs.tf, etc.)

## Requisitos Mínimos
Antes de rodar o Terraform, certifique-se de que você possui:
1. **Conta AWS ativa**
2. **Usuário IAM** com permissões adequadas
    - Recomenda-se anexar a política `AdministratorAccess` ao usuário para simplificar o processo (laboratório/teste).
    - Alternativamente, crie uma política customizada com permissões para:
        - `ec2:*`
        - `eks:*`
        - `rds:*`
        - `dynamodb:*`
        - `ecr:*`
        - `cognito-idp:*`
        - `iam:*`
3. **AWS CLI instalado** e configurado
   ```bash
   aws configure --profile carstore
   ```
   Informe:
    - AWS Access Key ID
    - AWS Secret Access Key
    - Região (ex: `us-east-1`)
    - Saída (json)

   Para validar as credenciais:
   ```bash
   aws sts get-caller-identity --profile carstore
   ```

4. **Terraform >= 1.5.0** instalado
   ```bash
   terraform -v
   ```

## Passo a passo para executar
1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-repo/Terraform-carstore-infra.git
   cd ./envs/dev
   ```

2. Inicialize o Terraform:
   ```bash
   terraform init
   ```

3. Visualize o plano de execução:
   ```bash
   terraform plan
   ```

4. Aplique a infraestrutura na AWS:
   ```bash
   terraform apply
   ```

5. Confirme a criação dos recursos. O Terraform criará:
    - Cluster EKS
    - Banco PostgreSQL (RDS)
    - Banco DynamoDB (NoSQL)
    - Repositório de imagens (ECR)
    - Cognito User Pool
    - VPC e subnets

## Outputs
Após a execução, serão exibidos:
- `cognito_pool_id`
- `documentdb_endpoint`
- `rds_endpoint`
- `cluster_name`

Essas informações serão necessárias para conectar os microserviços ao ambiente.

---
**Observação:** Este projeto foi desenvolvido para fins acadêmicos (FIAP Tech Challenge) e deve ser adaptado antes de uso em produção.
