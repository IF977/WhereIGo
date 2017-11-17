Feature: Cadastro Estabelecimento
    Como um dono de estabelecimento
    Eu quero cadastrar informações de meu estabelecimento
    Para que eu possa ter uma maior visibilidade
    
    Background:
      Given Eu estou logado como provider
      And Eu estou na pagina de registro de estabelecimento
      When Eu clico no botao "Novo estabelecimento"
      Then Eu devo ser direcionado para a pagina de criacao de estabelecimento
    
    Scenario: Criação de estabelecimento válido - no cadastro
      When Eu coloco Caldinho do Edu no campo establishment_name
      And Eu coloco caldo@edu no campo establishment_email
      And Eu coloco 12345678901234 no campo establishment_cnpj
      And Eu coloco O melhor de todos, pode confiar! no campo establishment_description
      And Eu coloco Rua do CDU no campo establishment_address
      And Eu coloco caldo.edu.com no campo establishment_website
      And Eu clico em Criar estabelecimento
      Then Eu devo ver o texto Caldinho do Edu

    Scenario: Criação de estabelecimento inválido - nome vazio
      When Eu deixo em branco no campo establishment_name
      And Eu coloco caldo@edu no campo establishment_email
      And Eu coloco 123456789012345888 no campo establishment_cnpj
      And Eu coloco O melhor de todos, pode confiar! no campo establishment_description
      And Eu coloco Rua do CDU no campo establishment_address
      And Eu coloco caldo.edu.com no campo establishment_website
      And Eu clico em Criar estabelecimento
      Then Eu devo ver o texto O campo nome é obrigatório.
     
    Scenario: Criação de estabelecimento inválido - email vazio
      When Eu coloco Caldinho do Edu no campo establishment_name
      And Eu deixo em branco no campo establishment_email
      And Eu coloco 12345678901234 no campo establishment_cnpj
      And Eu coloco O melhor de todos, pode confiar! no campo establishment_description
      And Eu coloco Rua do CDU no campo establishment_address
      And Eu coloco caldo.edu.com no campo establishment_website
      And Eu clico em Criar estabelecimento
      Then Eu devo ver o texto O campo e-mail é obrigatório.
      
    Scenario: Criação de estabelecimento inválido - CNPJ
      When Eu coloco Caldinho do Edu no campo establishment_name
      And Eu coloco caldo@edu no campo establishment_email
      And Eu coloco 123456789012345888 no campo establishment_cnpj
      And Eu coloco O melhor de todos, pode confiar! no campo establishment_description
      And Eu coloco Rua do CDU no campo establishment_address
      And Eu coloco caldo.edu.com no campo establishment_website
      And Eu clico em Criar estabelecimento
      Then Eu devo ver o texto CNPJ inválido.

    Scenario: Criação de estabelecimento inválido - endereco vazio
      When Eu coloco Caldinho do Edu no campo establishment_name
      And Eu coloco caldo@edu no campo establishment_email
      And Eu coloco 12345678901234 no campo establishment_cnpj
      And Eu coloco O melhor de todos, pode confiar! no campo establishment_description
      And Eu deixo em branco no campo establishment_address
      And Eu coloco caldo.edu.com no campo establishment_website
      And Eu clico em Criar estabelecimento
      Then Eu devo ver o texto O campo endereço é obrigatório.
    
    Scenario: Criação de estabelecimento válido - website vazio
      When Eu coloco Caldinho do Edu no campo establishment_name
      And Eu coloco caldo@edu no campo establishment_email
      And Eu coloco 12345678901234 no campo establishment_cnpj
      And Eu coloco O melhor de todos, pode confiar! no campo establishment_description
      And Eu coloco Rua do CDU no campo establishment_address
      And Eu deixo em branco no campo establishment_website
      And Eu clico em Criar estabelecimento
      Then Eu devo ver o texto Caldinho do Edu

    Scenario: Criação de estabelecimento válido - descricao vazia
      When Eu coloco Caldinho do Edu no campo establishment_name
      And Eu coloco caldo@edu no campo establishment_email
      And Eu coloco 12345678901234 no campo establishment_cnpj
      And Eu deixo em branco no campo establishment_description 
      And Eu coloco Rua do CDU no campo establishment_address
      And Eu deixo em branco no campo establishment_website
      And Eu clico em Criar estabelecimento
      Then Eu devo ver o texto Caldinho do Edu