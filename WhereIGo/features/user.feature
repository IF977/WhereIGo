Feature: Manage users
  Como um cliente
  Eu quero adicionar informações pessoais a minha conta
  Para que eu possa me diferenciar de outros clientes
  
  #@javascript
  Scenario: Create valid user
    Given Eu estou na pagina inicial
    When Eu preencho "user_name" com "Pedro"
    And Eu preencho "user_email" com "pedro@pedro"
    And Eu preencho "user_password_digest" com "pedro123"
    And Eu clico em "Criar conta"
    Then Eu devo ver a proxima tela de cadastro
