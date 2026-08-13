---
layout: default
title: Home
lang: en
ref: home
permalink: /en/
---

# Welcome to my terminal

Here I share my experiences and reflections on **Application Security**, **Architecture**, and the **Culture** required to build resilient software.

---

## Latest Publications

{%- comment -%}
See index.md for the reasoning behind everything here: the HTML sits at column 0 on
purpose (kramdown turns 4+ space indentation into a code block, which rendered the
markup as visible text), `categories` in the plural, and the "Other" bucket that used
to duplicate every post.
{%- endcomment -%}

{%- assign posts_by_lang = site.posts | where: "lang", page.lang -%}

{%- if posts_by_lang.size > 0 -%}
{%- assign known_categories = "appsec-culture,architecture,tech-tips,random" | split: "," -%}

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
<h3>Other</h3>
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

New content coming soon.

{%- endif -%}
