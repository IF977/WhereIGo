Feature: Login usuario
    Como um usuario
    Eu quero entrar na minha conta 
    Para que eu possa ter minhas informações salvas 
    
    Scenario: Login com sucesso - provider
      Given Eu estou na pagina de login, nao estou logado e sou provider
      And Eu coloco mc@troinha no campo email
      And Eu coloco 123mctroia123 no campo password
      And Eu clico em Entrar
      Then Eu devo ser direcionado para a pagina de estabelecimentos recomendados
      And Eu devo ver o texto Bares e restaurantes baseados no que você mais gosta
      
    Scenario: Login sem sucesso - email inval
      ido - provider
      Given Eu estou na pagina de login, nao estou logado e sou provider
      And Eu coloco troia@mc no campo email
      And Eu coloco 123mctroia123 no campo password
      And Eu clico em Entrar
      Then Eu devo ver o texto Usuário não encontrado!

    Scenario: Login sem sucesso - senha invalida - provider
      Given Eu estou na pagina de login, nao estou logado e sou provider
      And Eu coloco mc@troinha no campo email
      And Eu coloco 123 no campo password
      And Eu clico em Entrar
      Then Eu devo ver o texto Usuário ou senha incorretas!  

    Scenario: Login com sucesso - cliente
      Given Eu estou na pagina de login, nao estou logado e sou cliente
      And Eu coloco mc@dada no campo email
      And Eu coloco dadaboladao no campo password
      And Eu clico em Entrar
      Then Eu devo ser direcionado para a pagina de estabelecimentos recomendados
      Then Eu devo ver o texto Bares e restaurantes baseados no que você mais gosta
      
    Scenario: Login sem sucesso - email invalido - cliente
      Given Eu estou na pagina de login, nao estou logado e sou cliente
      And Eu coloco dada@mc no campo email
      And Eu coloco 123567 no campo password
      And Eu clico em Entrar
      Then Eu devo ver o texto Usuário não encontrado!

    Scenario: Login sem sucesso - senha invalida - provider
      Given Eu estou na pagina de login, nao estou logado e sou provider
      And Eu coloco mc@troinha no campo email
      And Eu coloco 123 no campo password
      And Eu clico em Entrar
      Then Eu devo ver o texto Usuário ou senha incorretas!       