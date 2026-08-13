# Build multi-stage: um estágio compila o site com Jekyll, o outro só serve o resultado.
#
# A imagem final não tem Ruby, nem Bundler, nem o código-fonte do site — só nginx e os
# arquivos estáticos gerados. Superfície de ataque mínima, coerente com o assunto do blog.
#
# Este Dockerfile é a ÚNICA definição de como o site é compilado: o mesmo comando roda
# aqui e no `bundle exec jekyll build` local. Não existe uma receita para o CI e outra
# para a máquina.

# ---------------------------------------------------------------------------
# Estágio 1 — compilação
# ---------------------------------------------------------------------------
# Debian (slim), não Alpine: o jekyll-sass-converter 3.x usa sass-embedded, que embute um
# binário do Dart compilado contra glibc. Em Alpine (musl) ele falha em tempo de execução,
# e o erro é obscuro. O peso extra fica só neste estágio, que é descartado.
FROM ruby:3.3-slim-bookworm AS build

WORKDIR /site

# build-essential só é necessário para gems com extensão nativa (ffi, eventmachine).
RUN apt-get update \
 && apt-get install -y --no-install-recommends build-essential \
 && rm -rf /var/lib/apt/lists/*

# Bundler fixado na versão que gerou o Gemfile.lock (seção BUNDLED WITH). Deixar o
# bundler da imagem decidir torna o build não determinístico entre versões do Ruby base.
RUN gem install bundler -v 2.4.22

# Gemfile e lock primeiro, e só depois o resto do site: enquanto as dependências não
# mudarem, esta camada é reaproveitada e o build não refaz o `bundle install`.
COPY Gemfile Gemfile.lock ./

# `--deployment` obriga o Gemfile.lock a ser respeitado à risca: se ele estiver
# desatualizado em relação ao Gemfile, o build FALHA em vez de silenciosamente resolver
# outra versão. É o que faz a imagem ser reprodutível.
#
# O lock precisa declarar as plataformas Linux (`bundle lock --add-platform x86_64-linux
# aarch64-linux`), senão o bundle aqui recusa: por padrão ele nasce só com a plataforma da
# máquina que rodou o bundle install pela primeira vez.
RUN bundle config set --local deployment true \
 && bundle config set --local without 'development test' \
 && bundle install

COPY . .

# JEKYLL_ENV=production ativa o que o Jekyll e os plugins tratam como comportamento de
# produção — entre outras coisas, é o que faz o jekyll-seo-tag emitir o bloco de dado
# estruturado completo.
ENV JEKYLL_ENV=production
RUN bundle exec jekyll build --trace

# ---------------------------------------------------------------------------
# Estágio 2 — serviço
# ---------------------------------------------------------------------------
FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /site/_site /usr/share/nginx/html

# Documental: quem publica a porta é o Service do Kubernetes.
EXPOSE 8080

# nginx roda como não-root pela porta 8080 (ver nginx.conf). Portas abaixo de 1024
# exigiriam privilégio que este pod não tem motivo para ter.
USER nginx

# A imagem base já define o CMD do nginx em foreground.
