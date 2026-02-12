<img width="550" height="165"  src="https://github.com/user-attachments/assets/640c34b0-6e3b-477e-a03e-192483473493" />


***
### 1. Para agilizar baixe (faça o 'pull') das 3 imagens que vamos utilizar:

```
docker pull ricardokleber/rk-elasticsearch:latest
```
```
docker pull ricardokleber/rk-kibana:latest
```
```
docker pull ricardokleber/rk-ssh:latest
```

### 2. Baixe o docker-compose pronto usando 'git clone':

```
git clone https://github.com/ricardokleber/rk-elk9-lab-ssh-01.git
```

### 3. Crie/instale os Dockers:

```
docker compose up -d
```

### 4. O contêiner que mais demora para ficar pronto (e que todos os demais dependem dele) é o Elasticsearch. Verifique se os logs param de ser gerados para que você possa seguir nas próximas configurações:

```
docker compose logs -f elasticsearch
```

### 5. Solicite agora que o Elasticsearch crie uma senha randômica para o usuário administrativo 'elastic':

```
docker exec -it elasticsearch /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic
```
### O Resultado será algo como:

`Password for the [elastic] user successfully reset.`

`New value: sqyTGEXI=CpgcWGDEyNY`

### A senha do usuário será esse valor indicado em 'New value' (copie e guarde para acessar o sistema).

### 6. Usando um navegador acesse o Elasticsearch e digite a URL:
```
https://10.10.10.101:9200
```

### Forneça como credenciais o login 'elastic' e a senha gerada no tópico anterior:
<img width="394" height="201" src="https://github.com/user-attachments/assets/27b6114f-2017-4440-bb8b-9ab2074eb9c7" />

### O Resultado será algo como:
<img width="394" height="247" src="https://github.com/user-attachments/assets/1f41d19a-798f-4b93-a3bd-6e5cc2aaea55" />

## Se o resultado foi este arquivo no formato JSON, O Elasticsearch está funcionando normalmente e a senha gerada foi aceita para autenticação no sistema.

### 7. Agora você poderá então acessar o Kibana, usando um navegador e digitando a URL:
```
http://10.10.10.102:5601
```
### O sistema solicitará um 'Token' para autorizar o acesso...

### 8. Usando o terminal solicite agora que o Elasticsearch crie o 'token' de autenticação do Kibana no Elasticsearch:

```
docker exec -it elasticsearch /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana
```
### O Resultado será algo como:

`eyJ2ZXIiOiI4LjE0LjAiLCJhZHIiOlsiMTcyLjE4LjAuMjo5MjAwIl0sImZnciI6Ijg4YjY1OGMyMGQ1N2FlNDFjNzJjYTg0ODljOGQ0N2EyZTY1YWVkMDg4ZjIzMmUxMWFiNzFmYmQ0NDI2Zjk1MjkiLCJrZXkiOiI1Qmp4TFp3QmZJRlBFajJYM0d2MTphSG9LbUREV0toMUo5SmotRUVLRjJnIn0=`

### 9. Copie esse token para a área de transferência e cole na caixa de diálogo aberta no navegador ao tentar acessar o Kibana.

<img width="444" height="333" src="https://github.com/user-attachments/assets/66c0c71f-f774-482d-ad9a-0622fe156bc2" />

### 10. Clique no botão 'Configure Elastic' e então o sistema solicitará um código de Verificação.
<img width="444" height="333" src="https://github.com/user-attachments/assets/ce696dfa-6379-4488-82a0-2236e7d4ca73" />

### 11. Usando o terminal solicite agora que o Kibana gere um 'Código de Validação':

```
docker exec -it kibana bin/kibana-verification-code
```
### O Resultado será algo como:

`Your verification code is:  569 844`

### Insira este código no navegador e aguarde...
<img width="444" height="360" src="https://github.com/user-attachments/assets/3d17c3a6-efc4-4ff2-94a7-4122504d10b8" />

### Após alguns segundos de configuração do ambiente, a tela de login do Elasticsearch solicitará novamente o login/senha (login = elastic e senha gerada para o acesso ao Elasticsearch):
<img width="444" height="290" src="https://github.com/user-attachments/assets/6d9fc821-b258-4137-b605-2dee83858f4e" />

### Seu sistema ELK está instalado, configurado e pronto para a próxima etapa....
<img width="610" height="433" src="https://github.com/user-attachments/assets/beb0ca5e-f1c9-4883-8b1c-38114a500765" />

### 12. Para usar a comunicação direta de hosts com o Elasticsearch usando Elastic Agents, é necessário ativar o componente 'Fleet' no Kibana:

```docker exec -it kibana /usr/share/kibana/bin/kibana-encryption-keys generate
```
### O Resultado será algo como:

`xpack.encryptedSavedObjects.encryptionKey: 80def75427d73b5b94f4bb4aa84c26d9`

`xpack.reporting.encryptionKey: 51c22dd95f7acb6da3aca4fa6d8661f3`

`xpack.security.encryptionKey: 0b27d3dbd3b266024d14536484e00ae7`

### Copie essas 3 linhas para a área de transferência.

### 13. Acesse agora o Docker do Kibana para configurar o componente 'Fleet':

```
docker exec -it kibana bash
```
### Concatene o conteúdo da área de transferência no arquivo de configuração do Kibana:

```
cat >> /usr/share/kibana/config/kibana.yml
```



***
## Veja o Vídeo com o Tutorial na Prática no Youtube:
<a href="https://www.youtube.com/@rkifrn" target="_blank"><img width="400" height="120" src="https://github.com/user-attachments/assets/c3ceb2d8-daba-4864-9613-15aebf301423" /></a>
