Feature: Login usuario
    Como um usuario
    Eu quero entrar na minha conta 
    Para que eu possa ter minhas informações salvas 
    
    Scenario: Login com sucesso
      Given Eu estou na pagina de login e nao estou logado
      And Eu coloco mc@troinha no campo email
      And Eu coloco 123mctroia123 no campo password
      And Eu clico em Entrar
      Then Eu devo ser direcionado para a pagina do dashboard
      Then Eu devo ver o texto Meus estabelecimentos 
      
    Scenario: Login sem sucesso - email invalido
      Given Eu estou na pagina de login e nao estou logado
      And Eu coloco troia@mc no campo email
      And Eu coloco 123mctroia123 no campo password
      And Eu clico em Entrar
      Then Eu devo ver o texto Usuário não encontrado!

    Scenario: Login sem sucesso - senha invalida
      Given Eu estou na pagina de login e nao estou logado
      And Eu coloco mc@troinha no campo email
      And Eu coloco 123 no campo password
      And Eu clico em Entrar
      Then Eu devo ver o texto Usuário ou senha incorretas!  