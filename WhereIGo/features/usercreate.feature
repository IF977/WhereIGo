Feature: Cadastro usuário
  Como um cliente
  Eu quero adicionar informações pessoais a minha conta
  Para que eu possa me diferenciar de outros clientes
  
  Scenario: Criação de usuário válida
    Given Eu estou na pagina inicial
    When Eu coloco Troinha no campo user_name
    And Eu coloco mc@troinha no campo user_email
    And Eu coloco 123mctroia123 no campo user_password_digest
    And Eu clico em Criar conta
    Then Eu devo ver o texto Eu quero encontrar bares e restaurantes
  
  Scenario: Criação de usuário - senha invalida
    Given Eu estou na pagina inicial
    When Eu coloco Pedro no campo user_name
    And Eu coloco pedro@pedro no campo user_email
    And Eu coloco 123 no campo user_password_digest
    And Eu clico em Criar conta
    Then Eu devo ver o texto A senha precisa ter no mínimo 6 caracteres.

  Scenario: Criação de usuario invalida - email vazio
    Given Eu estou na pagina inicial
    When Eu coloco Pedro no campo user_name
    And Eu deixo em branco no campo user_email
    And Eu coloco 123456 no campo user_password_digest
    And Eu clico em Criar conta
    Then Eu devo ver o texto O campo e-mail é obrigatório.
  
  Scenario: Criação de usuario - nome invalido
    Given Eu estou na pagina inicial
    When Eu deixo em branco no campo user_name
    And Eu coloco joao@pedro no campo user_email
    And Eu coloco 456123 no campo user_password_digest
    And Eu clico em Criar conta
    Then Eu devo ver o texto O campo nome é obrigatório.    