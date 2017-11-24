Feature: Uso da busca
    Como um cliente
    Eu quero buscar estabelecimento no campo de busca
    Para poder achar estabelecimentos mais rápido 
  
      Scenario: Buscando restaurantes existentes 
        Given Eu estou logado como cliente
        And Existe um estabelecimento visível a mim 
        #Estabelecimento: Feijao do Edu 
        When Eu digito Feijao no campo filter
        Then Eu devo ver o texto Feijao do Edu
        
      Scenario: Buscando restaurantes existentes 
        Given Eu estou logado como cliente
        And Existe um estabelecimento visível a mim
        #Estabelecimento: Feijao do Edu 
        When Eu digito Bar do ze no campo filter
        Then Eu devo ver o texto Nenhum estabelecimento encontrado!