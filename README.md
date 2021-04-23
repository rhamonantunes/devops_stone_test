# Projeto Stone Devops

## Requisitos
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [AWS cli ](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [aws-iam-autenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)

---

## Executando

1. Primeiro entre na pasta "s3_setup" e execute os comandos:
```
terraform init
terraform apply
```

2. Em seguida, entre na pasta "eks_setup" e execute os comandos:
```
terraform init
terraform apply
```

3. Em seguida, entre na pasta "monitoring_setup" e execute os comandos:
```
terraform init
terraform apply
```

4. Use o script abaixo para gerar as URLs de acesso aos serviços Prometheus, Grafana e Goldpinger:
```
chmod u+x urls.sh
./urls.sh
```
