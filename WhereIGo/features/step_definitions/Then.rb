Then(/^Eu devo ver o texto ([^"]*)$/) do |text|
    expect(page).to have_content(text)
end

Then(/^Eu devo ir para próxima etapa do cadastro$/) do
  visit "/register/role"
end

Then(/^Eu devo ser direcionado para a pagina do dashboard provider$/) do
    page.assert_current_path('/p/dashboard')
end

Then(/^Eu devo ser direcionado para a pagina do cliente$/) do
    page.assert_current_path('/c/dashboard')
end

Then(/^Eu devo ser direcionado para a pagina de criacao de estabelecimento$/) do
    page.assert_current_path('/p/establishment/new')
end

Then(/^Eu devo ser direcionado para a pagina de edicao de estabelecimento$/) do
    page.assert_current_path('/p/establishment/edit/' + @establishment.id.to_s)
end

Then(/^Eu devo ser direcionado para a pagina do estabelecimento$/) do
    page.assert_current_path("/c/establishment/" + @establishment.id.to_s)
end

