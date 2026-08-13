# Checklist de Pré-Publicação

Antes de publicar qualquer artigo, certifique-se de que ele atende aos seguintes critérios:

## 🎯 Foco em Cultura e Arquitetura
- [ ] O artigo foca em **Cultura AppSec**, **Security Champions**, ou **Arquitetura de Segurança**? (Evitar tutoriais puramente baseados em ferramentas).
- [ ] O texto reflete minha filosofia pessoal e experiência real?
- [ ] Existe uma "Call to Action" ou uma reflexão para o leitor ao final?

## 🌎 Qualidade e Bilíngue
- [ ] A versão em Português foi revisada gramaticalmente?
- [ ] A versão em Inglês está tecnicamente precisa e flui naturalmente?
- [ ] Os metadados `lang`, `ref` e `categories` estão configurados corretamente?
- [ ] O link de troca de idioma está funcionando entre as duas versões?

## 🔒 Zero terceiros

O site não faz nenhuma requisição externa e não executa JavaScript. É isso que permite a
CSP com `script-src 'none'` — o argumento mais forte que este blog tem em AppSec. Um único
vídeo embutido ou imagem hospedada fora derruba a propriedade inteira, e ninguém percebe
até alguém abrir o painel de rede.

- [ ] O artigo não embute vídeo, iframe, widget ou imagem de fora do próprio domínio?
- [ ] Rodei a verificação abaixo e ela não acusou nada?

```bash
# no diretório do post, ou na raiz do repositório
grep -rnE 'https?://' _posts/<seu-post>.md | grep -v 'zani0x03'
```

Links de texto para fora (`[fulano](https://...)`) são normais e não contam — o que não pode
é **carregar recurso**: `<img src>`, `<iframe>`, `<script>`, `<link>`. Imagem de artigo vai
para `assets/images/` e é servida daqui.

## 🚀 Divulgação
- [ ] O snippet para o LinkedIn está pronto e adaptado ao conteúdo?
- [ ] A mensagem para o Slack da OWASP está pronta?
- [ ] O artigo foi testado localmente para garantir que o visual "Hacker" e as fontes estão carregando corretamente?

---
*Manter a qualidade e a consistência é a chave para construir autoridade.*
