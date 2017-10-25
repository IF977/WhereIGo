Then(/^Eu devo ver o texto ([^"]*)$/) do |text|
    expect(page).to have_content(text)
end

Then(/^Eu devo ir para próxima etapa do cadastro$/) do
  visit "/register/role"
end