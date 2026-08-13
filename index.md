---
layout: default
title: Home
lang: pt
ref: home
---

# Bem-vindo ao meu terminal

Aqui compartilho minhas experiências e reflexões sobre **Segurança de Aplicações**, **Arquitetura** e a **Cultura** necessária para construir software resiliente.

---

## Últimas Publicações

{%- comment -%}
ATENÇÃO À INDENTAÇÃO. O HTML abaixo fica na coluna 0 de propósito.

Jekyll roda Liquid primeiro e Markdown depois, então quem vê o resultado é o
kramdown — e para ele qualquer linha indentada com 4+ espaços é bloco de código.
Com o HTML indentado, a home renderizava `&lt;h3&gt;Outros&lt;/h3&gt;` como texto
visível na página, em vez de um título.

Os hifens nas tags Liquid existem pelo mesmo motivo: removem o espaço em branco que
as próprias tags deixariam para trás.
{%- endcomment -%}

{%- assign posts_by_lang = site.posts | where: "lang", page.lang -%}

{%- if posts_by_lang.size > 0 -%}
{%- assign known_categories = "appsec-culture,architecture,tech-tips,random" | split: "," -%}

{%- comment -%}
`item.categories`, no plural. O front matter usa `categories:`, e em Jekyll
`page.categories` é sempre array — `page.category` não é campo padrão e resolve para
nil, o que fazia nenhuma seção renderizar. A correção fica no template: mexer no front
matter mudaria a categoria que compõe o permalink padrão, e com isso as URLs dos posts.
{%- endcomment -%}

{%- for cat in known_categories -%}
{%- assign cat_posts = posts_by_lang | where_exp: "item", "item.categories contains cat" -%}
{%- if cat_posts.size > 0 %}
<h3>{{ cat | replace: "-", " " | capitalize }}</h3>
<ul>
{%- for post in cat_posts %}
<li><a href="{{ post.url | relative_url }}">{{ post.title }}</a> <small>{{ post.date | date: "%d/%m/%Y" }}</small></li>
{%- endfor %}
</ul>
{% endif -%}
{%- endfor -%}

{%- comment -%}
"Outros" = posts que não caem em NENHUMA categoria conhecida.

A versão anterior testava `item.category == nil`, sempre verdadeiro porque o campo não
existe. Resultado: todo post apareceria duas vezes — na seção da categoria dele e aqui.
Passava despercebido só porque os posts de 2022 não têm categoria conhecida; quebraria
no primeiro artigo novo.

Liquid não tem filtro de rejeição nem `push` para montar array, daí varrer duas vezes:
uma para saber se há algo a exibir, outra para exibir.
{%- endcomment -%}

{%- capture has_other -%}
{%- for post in posts_by_lang -%}
{%- assign is_known = false -%}
{%- for cat in known_categories -%}
{%- if post.categories contains cat -%}{%- assign is_known = true -%}{%- endif -%}
{%- endfor -%}
{%- unless is_known -%}x{%- endunless -%}
{%- endfor -%}
{%- endcapture -%}

{%- if has_other != "" %}
<h3>Outros</h3>
<ul>
{%- for post in posts_by_lang -%}
{%- assign is_known = false -%}
{%- for cat in known_categories -%}
{%- if post.categories contains cat -%}{%- assign is_known = true -%}{%- endif -%}
{%- endfor -%}
{%- unless is_known %}
<li><a href="{{ post.url | relative_url }}">{{ post.title }}</a> <small>{{ post.date | date: "%d/%m/%Y" }}</small></li>
{%- endunless -%}
{%- endfor %}
</ul>
{%- endif -%}

{%- else %}

Novos conteúdos em breve.

{%- endif -%}
