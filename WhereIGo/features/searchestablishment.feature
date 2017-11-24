Feature: Uso da busca
    Como um cliente
    Eu quero buscar estabelecimento no campo de busca
    Para poder achar estabelecimentos mais rápido 

      Scenario: Buscando restaurantes existentes (apenas de um) - caminho feliz
        Given Eu estou logado como cliente
        And Existe um estabelecimento visível a mim chamado Feijao do Edu 
        And Existe um estabelecimento visível a mim chamado Gugu do feijao
        When Eu digito Gugu no campo filter
        Then Eu devo ver o texto Gugu do feijao 
  
      Scenario: Buscando restaurantes existentes (mais de um) - caminho feliz
        Given Eu estou logado como cliente
        And Existe um estabelecimento visível a mim chamado Feijao do Edu 
        And Existe um estabelecimento visível a mim chamado Gugu do feijao
        When Eu digito Feijao no campo filter
        Then Eu devo ver o texto Feijao do Edu
        And Eu devo ver o texto Gugu do feijao 
        
      Scenario: Buscando restaurantes inexistentes - caminho triste 
        Given Eu estou logado como cliente
        And Existe um estabelecimento visível a mim chamado Feijao do Edu 
        And Existe um estabelecimento visível a mim chamado Gugu do feijao
        When Eu digito Bar do ze no campo filter
        Then Eu devo ver o texto Nenhum estabelecimento encontrado!