FROM openjdk:8-jdk-bullseye
MAINTAINER Lucas Vieira "lucasvieira@protonmail.com"

ARG USER_HOME_DIR="/root"

# Versões de software
ARG MAVEN_VERSION=3.5.4
ARG NODE_VERSION=12.13.0
ARG LAUNCH4J_VERSION=3.14

# Configuração do Maven
ARG MAVEN_BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries
RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
	&& echo "Baixando o Maven..." \
	&& curl -fsSL -o /tmp/apache-maven.tar.gz ${MAVEN_BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
	&& echo "Descompactando Maven..." \
	&& tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
	&& echo "Limpeza e criação de links..." \
	&& rm -f /tmp/apache-maven.tar.gz \
	&& ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
RUN mvn --version

# Configuração do NVM
ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN chmod +x $NVM_DIR/nvm.sh

# Instalação do Node.js
ENV NODE_VERSION ${NODE_VERSION}
RUN . $NVM_DIR/nvm.sh \
	&& nvm install ${NODE_VERSION} \
	&& nvm use ${NODE_VERSION} \
	&& nvm alias default ${NODE_VERSION}
ARG NODE_INSTALL_PATH="${NVM_DIR}/versions/node/v${NODE_VERSION}/bin"
ENV PATH "${NODE_INSTALL_PATH}:${PATH}"
RUN node --version
RUN npm --version

# Configuração do Vue.js
RUN npm install -g vue-cli
RUN vue --version

# Configuração do Launch4J
ARG LAUNCH4J_BASE_URL=https://sonik.dl.sourceforge.net/project/launch4j/launch4j-3/${LAUNCH4J_VERSION}
RUN echo "Baixando o LAUNCH4J..." \
	&& curl -fsSL -o /tmp/launch4j.tar.gz ${LAUNCH4J_BASE_URL}/launch4j-${LAUNCH4J_VERSION}-linux-x64.tgz \
	&& echo "Descompactando o LAUNCH4J..." \
	&& mkdir -p /usr/share/launch4j \
	&& tar -xzf /tmp/launch4j.tar.gz -C /usr/share/launch4j --strip-components=1 \
	&& echo "Limpeza..." \
	&& rm -f /tmp/launch4j.tar.gz
ENV PATH "/usr/share/launch4j:${PATH}"
RUN launch4j --version

# 7zip
RUN apt update && apt install -y p7zip-full

CMD ["/bin/bash"]

