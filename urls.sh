#!/bin/bash
echo -e "VERIFICANDO DEPENDENCIAS\n"
command -v kubectl >/dev/null 2>&1 || { echo "Necessário instalar KUBECTL.  Saindo..." >&2; exit 1; }

URL_GOLDPINGER=$(kubectl get svc -n app-goldpinger goldpinger -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
URL_GRAFANA=$(kubectl get svc -n app-grafana grafana -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
URL_PROMETHEUS=$(kubectl get svc -n prometheus prometheus -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
SENHA_GRAFANA=$(kubectl get secret --namespace app-grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode)

echo -e "
Para Acessar o PROMETHEUS\n
http://$URL_PROMETHEUS:8080/ \n

Para Acessar o GOLDPINGER\n
http://$URL_GOLDPINGER/ \n

Para Acessar o GRAFANA\n
http://$URL_GRAFANA/ \n
USUÁRIO: admin
SENHA: $SENHA_GRAFANA \n

";