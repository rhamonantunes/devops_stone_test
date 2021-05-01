# Projeto Stone Devops

## Requisitos
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [AWS cli ](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [aws-iam-autenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)

---

## Executando

1. Primeiro entre na pasta "s3_setup" e execute os comandos:

> **_NOTE:_**  Verificar se o nome do s3 bucket não está em uso ou processo de exclusão:
"Bucket with the same name already exists" or "A conflicting conditional operation is currently in progress against this resource. Please try again."
> [monitoring_setup/backend.tf#L3](monitoring_setup/backend.tf#L3)
> [monitoring_setup/kubernetes.tf#L8](monitoring_setup/kubernetes.tf#L8)
> [eks_setup/backend.tf#L3](eks_setup/backend.tf#L3)
> [s3_setup/s3.tf#L2](s3_setup/s3.tf#L2)
> [s3_setup/s3.tf#L18](s3_setup/s3.tf#L18)
> [s3_setup/empty-s3.py#L4](s3_setup/empty-s3.py#L4)
> [s3_setup/empty-s3.py#L7](s3_setup/empty-s3.py#L7)

```shell
terraform init
terraform apply
```

2. Em seguida, entre na pasta "eks_setup" e execute os comandos:
```shell
terraform init
terraform apply
```

3. Em seguida, entre na pasta "monitoring_setup" e execute os comandos:
```shell
terraform init
terraform apply
```

4. Use o script abaixo para gerar as URLs de acesso aos serviços Prometheus, Grafana e Goldpinger:
```shell
chmod u+x urls.sh
./urls.sh
```
