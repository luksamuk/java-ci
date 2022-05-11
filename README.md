# docker-java8-ci

Este repositório contém o Dockerfile para a geração de uma imagem Docker para
a compilação de projetos web Front-End usando OpenJDK 8.

A imagem deriva-se de uma instância do Debian 11, e possui as seguintes
dependências instaladas:

- Java 8 (OpenJDK 8);
- Maven versão 3.5.4;
- Node.js versão 12.13.0;
- Launch4j versão 3.14;
- 7zip.

## Gerando a imagem Docker

Para gerar a imagem com o nome `java-ci`, vá até o diretório deste projeto e
execute no console:

```bash
docker image build -t java-ci:latest .
```

Caso você queira enviar a versão da imagem gerada para o seu Dockerhub:

```bash
docker tag java-ci seu-nome-de-usuario/java-ci:latest
docker image push seu-nome-de-usuario/java-ci:latest
```

## Usando imagem pré-configurada

Existe uma imagem pré-configurada, que pode ser baixada via Docker:

```bash
docker run -it --rm luksamuk/java-ci:1.1
```
