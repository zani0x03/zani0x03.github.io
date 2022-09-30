---
layout: default
---
# Publications

<ul>
  {% for post in site.posts %}
    {% if post.original == true %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a> - <a href="{{ post.next.url }}">{{post.next.title}}</a>    
    </li>
    {% endif %}
  {% endfor %}
</ul>