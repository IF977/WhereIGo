Feature: Como um cliente
    Eu quero adicionar avaliações públicas ao estabelecimento
    Para que outras pessoas possam ter conhecimento da qualidade do local

    Background:
      Given Eu estou logado como cliente
      And Eu estou na pagina inicial
      And Existe um estabelecimento visível a mim
      When Eu clico no nome do estabelecimento
      Then Eu devo ser direcionado para a pagina do estabelecimento
      
    Scenario: Avaliação positiva 
      When Eu clico no botao "positivo"
      Then Eu devo ver o texto 100%
    
    Scenario: Avaliação negativa
      When Eu clico no botao "negativo"
      Then Eu devo ver o texto 0%
      
    Scenario: Mais de uma avaliacao com o mesmo usuario - fica a ultima (positiva)
      When Eu clico no botao "negativo"
      And Eu clico no botao "positivo"
      Then Eu devo ver o texto 100%

    Scenario: Mais de uma avaliacao com o mesmo usuario - fica a ultima (negativa)
      When Eu clico no botao "positivo"
      And Eu clico no botao "negativo"
      Then Eu devo ver o texto 0%
            