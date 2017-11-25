Feature: Como um cliente
    Eu quero poder selecionar preferências de estabelecimento
    Para encontrar estabelecimentos compatíveis com meu gosto
    
    Background:
        Given Eu estou na pagina inicial
        When Eu coloco Giles no campo user_name
        And Eu coloco mc@giles no campo user_email
        And Eu coloco 123giles123 no campo user_password_digest
        And Eu clico em Criar conta
        And Eu clico no botão Eu quero encontrar bares e restaurantes
 
    
    Scenario: Não escolhendo nenhuma preferencia
      Given Eu estou na pagina de preferencias de musica
      When Eu clico em Continuar
      Then Eu devo ser direcionado para a pagina de preferencias de ambiente
      When Eu clico em Continuar
      Then Eu devo ser direcionado para a pagina de preferencias de comida
      When Eu clico em Continuar 
      Then Eu devo ver o texto Bares e restaurantes perto de você 