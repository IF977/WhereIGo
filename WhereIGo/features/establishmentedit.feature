Feature: Edição de Estabelecimento
    Como um dono de estabelecimento
    Eu quero editar ou remover informações cadastradas
    Para que eu possa atualizar os dados do meu estabelecimento
    
    Background:
      Given Eu estou logado como provider
      And Eu tenho um estabelecimento
      And Eu estou na pagina do estabelecimento
      When Eu clico no botao "Editar"
      Then Eu devo ser direcionado para a pagina de edicao de estabelecimento
      
    Scenario: Edicao de nome - valida
        And Eu coloco bar do ze no campo establishment_name
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto Estabelecimento editado com sucesso.
    
    Scenario: Edicao de nome para vazio - invalida
        And Eu deixo em branco no campo establishment_name
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto O campo nome é obrigatório.
      
    Scenario: Edicao de email - valida
        And Eu coloco caldo@edu no campo establishment_email
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto Estabelecimento editado com sucesso.
        
    Scenario: Edicao de email para vazio - valida
        And Eu deixo em branco no campo establishment_email
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto Estabelecimento editado com sucesso.
                
    Scenario: Edicao de descricao - valida
        And Eu coloco O cardapio mais variado do Recife no campo establishment_description
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto Estabelecimento editado com sucesso.
        
    Scenario: Edicao de descricao para vazio - valida
        And Eu deixo em branco no campo establishment_description
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto Estabelecimento editado com sucesso.

    Scenario: Edicao de endereco - valida
        And Eu coloco Rua do Alemao no campo establishment_address
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto Estabelecimento editado com sucesso.
                
    Scenario: Edicao de endereco para vazio - invalida
        And Eu deixo em branco no campo establishment_address
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto O campo endereço é obrigatório.
        
    Scenario: Edicao de website para vazio - valida
        And Eu deixo em branco no campo establishment_website
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto Estabelecimento editado com sucesso.
        
    Scenario: Edicao de website - valida
        And Eu coloco novo.site.com no campo establishment_website
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto Estabelecimento editado com sucesso.
        
    Scenario: Edicao de foto - valida
        And Eu anexo uma imagem em browse
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto Estabelecimento editado com sucesso.