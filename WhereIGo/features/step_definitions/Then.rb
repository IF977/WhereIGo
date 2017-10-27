Then(/^Eu devo ver o texto ([^"]*)$/) do |text|
    expect(page).to have_content(text)
end

Then(/^Eu devo ir para próxima etapa do cadastro$/) do
  visit "/register/role"
end

Then(/^Eu devo ser direcionado para a pagina do dashboard$/) do
    #assert_current_path(login_path)
    page.assert_current_path('/p/dashboard')
end