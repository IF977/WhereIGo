Feature: Como um cliente
    Eu quero poder selecionar preferências de estabelecimento
    Para encontrar estabelecimentos compatíveis com meu gosto
    
    Background:
        Given Existem restaurantes cadastrados 
        And Eu estou na pagina inicial
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
      Then Eu devo ver o texto Bares e restaurantes baseados no que você mais gosta
      And Eu devo ver o texto Nenhum estabelecimento encontrado!
      
    Scenario: Escolhendo preferencia de comida
      Given Eu estou na pagina de preferencias de musica
      When Eu clico em Continuar
      Then Eu devo ser direcionado para a pagina de preferencias de ambiente
      When Eu clico em Continuar
      Then Eu devo ser direcionado para a pagina de preferencias de comida
      When Eu marco Carne de Sol no checkbox de comida
      And Eu clico em Continuar 
      Then Eu tenho uma conta criada com preferencia de comida 
      And Eu devo ver o texto Bares e restaurantes baseados no que você mais gosta
      And Eu devo ver o texto Edmilson Da Carne de Sol 
      
    Scenario: Escolhendo preferencia de musica
      Given Eu estou na pagina de preferencias de musica
      When Eu marco Jazz no checkbox de musica
      And Eu clico em Continuar
      Then Eu devo ser direcionado para a pagina de preferencias de ambiente
      When Eu clico em Continuar
      Then Eu devo ser direcionado para a pagina de preferencias de comida
      When Eu clico em Continuar
      Then Eu tenho uma conta criada com preferencia de musica
      And Eu devo ver o texto Bares e restaurantes baseados no que você mais gosta
      And Eu devo ver o texto Edmilson Da Carne de Sol 
            
            
    Scenario: Escolhendo preferencia de ambiente
      Given Eu estou na pagina de preferencias de musica
      When Eu clico em Continuar
      Then Eu devo ser direcionado para a pagina de preferencias de ambiente
      When Eu marco familiar no checkbox de ambiente
      And Eu clico em Continuar 
      Then Eu devo ser direcionado para a pagina de preferencias de comida
      When Eu clico em Continuar
      Then Eu tenho uma conta criada com preferencia de ambiente
      And Eu devo ver o texto Bares e restaurantes baseados no que você mais gosta
      And Eu devo ver o texto Edmilson Da Carne de Sol 


    Scenario: Escolhendo preferencia de musica, ambiente e comida 
      Given Eu estou na pagina de preferencias de musica
      When Eu marco Jazz no checkbox de musica
      And Eu clico em Continuar
      Then Eu devo ser direcionado para a pagina de preferencias de ambiente
      When Eu marco familiar no checkbox de ambiente
      And Eu clico em Continuar 
      Then Eu devo ser direcionado para a pagina de preferencias de comida
      When Eu marco Carne de Sol no checkbox de comida
      And Eu clico em Continuar
      Then Eu tenho uma conta criada com preferencia de musica, ambiente e comida
      And Eu devo ver o texto Bares e restaurantes baseados no que você mais gosta
      And Eu devo ver o texto Edmilson Da Carne de Sol             