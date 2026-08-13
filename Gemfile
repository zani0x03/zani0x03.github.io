# frozen_string_literal: true

source "https://rubygems.org"

# Antes este arquivo usava `gemspec`, porque o repositório nasceu como fork de
# pages-themes/hacker e o .gemspec do tema ficou na raiz. Isso montava a lista de
# arquivos com `git ls-files`, o que não sobrevive a um contexto de build sem .git
# (ex.: dentro de um container). Este repositório é um *site*, não um tema
# publicado — então as dependências passam a ser declaradas diretamente.

gem "jekyll", "~> 4.3"
gem "jekyll-theme-hacker", "~> 0.2"
gem "jekyll-seo-tag", "~> 2.8"
gem "webrick", "~> 1.7"
