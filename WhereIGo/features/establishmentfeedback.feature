Feature: Como um cliente
Eu quero dar feedbacks aos estabelecimentos
Para que eles possam estar em constante evolução

    Background: Estou logado e na página do estabelecimento a ser comentado  
        Given Eu estou logado como cliente
        And Existe um estabelecimento visível a mim 
        And Eu estou na pagina do estabelecimento a ser comentado
        
    Scenario: Comentario valido 
        When Eu coloco Muito bom, recomendo! no campo establishment_comment_comment
        And Eu clico em Comentar 
        Then Eu devo ver o texto Muito bom, recomendo! 
        
    Scenario: Comentario invalido - campo em branco
        When Eu deixo em branco no campo establishment_comment_comment
        And Eu clico em Comentar 
        Then Eu devo ver o texto Comentário inválido! 