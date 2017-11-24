Feature: Cadastro Estabelecimento
    Como um dono de estabelecimento
    Eu quero cadastrar informações de meu estabelecimento
    Para que eu possa ter uma maior visibilidade
    
    Background:
      Given Eu estou logado como provider
      When Eu clico no botão do garfo e faca
      Then Eu sou direcionado para a pagina dos meus estabelecimentos
      Given Eu estou na pagina dos meus estabelecimentos
      When Eu clico no botao "Novo estabelecimento"
      Then Eu devo ser direcionado para a pagina de criacao de estabelecimento
    
    Scenario: Criação de estabelecimento válido - no cadastro
      When Eu coloco Caldinho do Edu no campo establishment_name
      And Eu coloco caldo@edu no campo establishment_email
      And Eu coloco O melhor de todos, pode confiar! no campo establishment_description
      And Eu coloco Rua do CDU no campo establishment_address
      And Eu coloco caldo.edu.com no campo establishment_website
      And Eu clico em Criar estabelecimento
      Then Eu devo ver o texto Caldinho do Edu

    Scenario: Criação de estabelecimento inválido - nome vazio
      When Eu deixo em branco no campo establishment_name
      And Eu coloco caldo@edu no campo establishment_email
      And Eu coloco O melhor de todos, pode confiar! no campo establishment_description
      And Eu coloco Rua do CDU no campo establishment_address
      And Eu coloco caldo.edu.com no campo establishment_website
      And Eu clico em Criar estabelecimento
      Then Eu devo ver o texto O campo nome é obrigatório.
     
    Scenario: Criação de estabelecimento válido - email vazio
      When Eu coloco Caldinho do Edu no campo establishment_name
      And Eu deixo em branco no campo establishment_email
      And Eu coloco O melhor de todos, pode confiar! no campo establishment_description
      And Eu coloco Rua do CDU no campo establishment_address
      And Eu coloco caldo.edu.com no campo establishment_website
      And Eu clico em Criar estabelecimento
      Then Eu devo ver o texto Caldinho do Edu
      

    Scenario: Criação de estabelecimento inválido - endereco vazio
      When Eu coloco Caldinho do Edu no campo establishment_name
      And Eu coloco caldo@edu no campo establishment_email
      And Eu coloco O melhor de todos, pode confiar! no campo establishment_description
      And Eu deixo em branco no campo establishment_address
      And Eu coloco caldo.edu.com no campo establishment_website
      And Eu clico em Criar estabelecimento
      Then Eu devo ver o texto O campo endereço é obrigatório.
    
    Scenario: Criação de estabelecimento válido - website vazio
      When Eu coloco Caldinho do Edu no campo establishment_name
      And Eu coloco caldo@edu no campo establishment_email
      And Eu coloco O melhor de todos, pode confiar! no campo establishment_description
      And Eu coloco Rua do CDU no campo establishment_address
      And Eu deixo em branco no campo establishment_website
      And Eu clico em Criar estabelecimento
      Then Eu devo ver o texto Caldinho do Edu

    Scenario: Criação de estabelecimento válido - descricao vazia
      When Eu coloco Caldinho do Edu no campo establishment_name
      And Eu coloco caldo@edu no campo establishment_email
      And Eu deixo em branco no campo establishment_description 
      And Eu coloco Rua do CDU no campo establishment_address
      And Eu deixo em branco no campo establishment_website
      And Eu clico em Criar estabelecimento
      Then Eu devo ver o texto Caldinho do Edu