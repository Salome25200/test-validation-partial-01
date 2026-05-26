FROM mcr.microsoft.com/devcontainers/java:11

# Instalar utilidades adicionales
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Configurar Maven con memoria limitada para Codespaces
ENV MAVEN_OPTS="-Xmx512m"
