# Relatório final

## Introdução

O objetivo deste projeto foi aplicar o conteúdo ministrado na matéria sobre programação funcional, utilizando a linguagem Elm para
o frontend da aplicação e a linguagem Haskell para o backend.

O projeto escolhido foi um jogo de cartas com temática na biologia, onde o jogador vencedor deve construir o monstro da missão sorteada
para ele. Tudo isso num sistema "dont" inspirado pelo dontpad, onde ao acessar uma url, já se pode jogar um jogo ou criar um.

## Desenvolvimento técnico

A seguir serão listados alguns pontos interessantes implementados no projeto.

### Mecanismo de persistência

Para persistir os jogos que estão acontecendo na plataforma, utilizamos um mecanismo de persistência na API Haskell com as MVar. Conseguimos
assim criar uma lista "mutável" de jogos e então podemos suportar jogos simultâneos em diferentes URL's. Escolhemos utilizar Mvar ao invés
de um banco pois como só precisaríamos de uma lista de jogos em andamento na aplicação, estaríamos utilizando técnologia demais para um problema
simples, assim as MVar atenderam muito bem o nosso propósito.


### Rotas, subscribers e tasks

O primeiro desafio encontrado foi implementar um sistema de rotas igual ao do dontpad, em que qualquer url precedida por dontpad/ é valida.
O padrão escolhido para este projeto foi /nome-do-jogo/nome-do-jogador, nesta url seria então possível entrar em um jogo criado ou criar um
se não existisse.

Para conseguirmos acesso ao evento de mudança de url no navegador e então validarmos as rotas, tivemos que deixar o browser.sandbox ou
o browser.element para utilizar o browser.application do Elm, já que apenas este nos fornecia os eventos de mudança de url no navegador.
Assim quando a url mudava, uma mensagem chegava no update do Elm e passávamos essa url para uma função de router que tinha o propósito de fazer
o parsing da url e delegar para uma função específica, que no caso era funções que faziam requests para a API.

Além das rotas, tinha-se a necessidade de atualizar o jogo de tempos em tempos, para isso criamos uma subscription de Time.every que executa
uma request para a API a cada 2 segundos, assim conseguimos manter o jogo atual sempre atualizado.


### Union types

Alguns union types foram criados, tanto no Elm quanto no Haskell. O principal uso neste projeto foram para os genes das cartas,
todos os genes possívels foram definidos como um union type Gene. Outro uso foi no módulo Api, que é responsável pela comunicação
com o Haskell. Nele definimos o union type ApiRequest que nos possibilitou encapsular as chamadas da api desta maneira 
Api.get (CreateGame "jogo1").

## Qualidade do produto
