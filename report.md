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

### Recursos básicos

Apesar de não conseguirmos finalizar o escopo do projeto, alguns recursos básicos da aplicação como: roteamento estilo dontpad e comunicação com a api haskell foram bem implementados.

### Interações eficientes

As interações foram implementadas utilizando bem a arquitetura Elm, sempre lançando mensagens para o update e então performando algun tipo de ação.

### Integração front + back

A integração front e back poderia ter sido melhor dividida, pois fazemos bastante coisa no front que talvez poderiam ser executadas no back, porém os dois sistemas foram conectados adequadamente e o front utiliza o back como mecanismo de persistência, o que nos proporcionou rodar diferentes jogos em diferentes url's simultaneamente.

### Método

Utilizamos a ferramenta [create-elm-app](https://github.com/halfzebra/create-elm-app) que facilita bastante o desenvolvimento, pois possui um servidor diferente do elm reactor que possibilita a utilização de roteamente de urls, além de um console de debug na página que facilita enxergar o estado da aplicação em determinados momentos. Esta ferramenta também possui um comando para build que tenta criar um versão bastante otimizada da aplicação.
