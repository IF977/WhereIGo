Then(/^Eu devo ver o texto ([^"]*)$/) do |text|
    expect(page).to have_content(text)
end

Then(/^Eu devo ir para próxima etapa do cadastro$/) do
  visit "/register/role"
end

Then(/^Eu devo ser direcionado para a pagina de dashboard$/) do
    page.assert_current_path('/dashboard/all_establishments')
end

Then(/^Eu devo ser direcionado para a pagina de criacao de estabelecimento$/) do
    page.assert_current_path('/dashboard/establishment/new')
end

Then(/^Eu devo ser direcionado para a pagina de edicao de estabelecimento$/) do
    page.assert_current_path('/dashboard/my_establishment/edit/' + @establishment.id.to_s)
end

Then(/^Eu devo ser direcionado para a pagina do estabelecimento$/) do
    page.assert_current_path("/establishment/" + @establishment.id.to_s)
end

Then(/^Eu sou direcionado para a pagina dos meus estabelecimentos$/) do
    page.assert_current_path("/dashboard/my_establishments")
end
