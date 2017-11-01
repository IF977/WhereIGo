Feature: Edição de Estabelecimento
    Como um dono de estabelecimento
    Eu quero editar ou remover informações cadastradas
    Para que eu possa atualizar os dados do meu estabelecimento
    
    Background:
      Given Eu estou logado como provider
      And Eu tenho um estabelecimento
      And Eu estou na pagina do meu estabelecimento
      When Eu clico no botao "Editar" 
      
    Scenario: Edicao de nome - valida
        And Eu coloco bar do ze no campo establishment_name
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto Meus estabelecimentos
    
    Scenario: Edicao de nome para vazio - invalida
        And Eu deixo em branco no campo establishment_name
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto O campo nome é obrigatório.
      
    Scenario: Edicao de email - valida
        And Eu coloco caldo@edu no campo establishment_email
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto Meus estabelecimentos
        
    Scenario: Edicao de email para vazio - invalida
        And Eu deixo em branco no campo establishment_email
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto O campo e-mail é obrigatório.
                
    Scenario: Edicao de CNPJ - valida
        And Eu coloco 12345678901234 no campo establishment_cnpj
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto Meus estabelecimentos
        
    Scenario: Edicao de CNPJ invalido
        And Eu coloco 123 no campo establishment_cnpj
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto CNPJ inválido.
        
    Scenario: Edicao de endereco - valida
        And Eu coloco Rua do Alemao no campo establishment_address
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto Meus estabelecimentos
                
    Scenario: Edicao de endereco para vazio - invalida
        And Eu deixo em branco no campo establishment_address
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto O campo endereço é obrigatório.
        
    Scenario: Edicao de website para vazio - valida
        And Eu deixo em branco no campo establishment_website
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto Meus estabelecimentos
        
    Scenario: Edicao de website - valida
        And Eu coloco novo.site.com no campo establishment_website
        And Eu clico em Salvar alterações
        Then Eu devo ver o texto Meus estabelecimentos