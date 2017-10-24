Feature: Manage users
  Como um cliente
  Eu quero adicionar informações pessoais a minha conta
  Para que eu possa me diferenciar de outros clientes
  
  #@javascript
  Scenario: Create invalid user
    Given Eu estou na pagina inicial
    When I put Pedro on the user_name input
    And I put pedro@pedro on the user_email input
    And I put 123 on the user_password_digest input
    And Eu clico em "Criar conta"
    Then I should see the text A senha precisa ter no mínimo 6 caracteres.

