Feature: Como um cliente
Eu quero dar feedbacks aos estabelecimentos
Para que eles possam estar em constante evolução

    Background: Estou logado e na página do estabelecimento a ser comentado  
      Given Eu estou logado como cliente
      And Eu estou na pagina inicial
      And Existe um estabelecimento visível a mim
      When Eu clico no nome do estabelecimento
      Then Eu devo ser direcionado para a pagina do estabelecimento
        
    Scenario: Comentario valido 
      When Eu coloco Muito bom, recomendo! no campo establishment_comment_comment
      And Eu clico em Comentar 
      Then Eu devo ver o texto Muito bom, recomendo! 
        
    Scenario: Comentario invalido - campo em branco
      When Eu deixo em branco no campo establishment_comment_comment
      And Eu clico em Comentar 
      Then Eu devo ver o texto O campo comentário está vazio.