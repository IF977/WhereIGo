Given(/^Eu estou na pagina inicial$/) do
  visit(root_path)
end

When("Eu clico em {string}") do |button|
  click_button(button)
end

When(/^[I ]*put ([^"]*) on the ([^"]*) input$/) do |data,input|
    fill_in input, with: data
end

Then(/^I should see the text ([^"]*)$/) do |text|
    expect(page).to have_content(text)
end
=begin
When("Eu preencho {string} com {string}") do |string, string2|
  page.fill_in(string, :with =>string2)
end

Then(/^Eu devo ver a proxima tela de cadastro$/) do
    visit "/register/role"
end
=end