Feature: Cadastro Estabelecimento
    Como um dono de estabelecimento
    Eu quero cadastrar informações de meu estabelecimento
    Para que eu possa ter uma maior visibilidade
    
    
    Scenario: Criação de estabelecimento válido
      Given Eu estou na pagina de registro de estabelecimento
      When Eu coloco Caldinho do Edu no campo establishment_name
      And Eu coloco caldo@edu no campo establishment_email
      And Eu coloco 12345678901234 no campo establishment_cnpj
      And Eu coloco Rua do CDU no campo establishment_address
      And Eu coloco caldo.edu.com no campo establishment_website
      And Eu clico em Criar estabelecimento
      Then Eu devo ver o texto Caldinho do Edu