When(/^[Eu ]*coloco ([^"]*) no campo ([^"]*)$/) do |data,input|
    fill_in input, with: data
end

When(/^[Eu ]*deixo em branco no campo ([^"]*)$/) do |input|
    fill_in input, with: nil
end

When(/^[Eu ]*clico em ([^"]*)$/) do |button|
    click_button(button)
end

When(/^I click on the ([^"]*) link$/) do |link|
  click_link(link)
end
        
When (/^Eu clico no nome do estabelecimento$/) do
  visit ("/c/establishment/" + @establishment.id.to_s)
end

When (/^Eu clico no botao "positivo"$/) do
    visit("/c/establishment/" + @establishment.id.to_s + "/review?review=true")
end

When (/^Eu clico no botao "negativo"$/) do
    visit("/c/establishment/" + @establishment.id.to_s + "/review?review=false")
end

When (/^Eu clico no botao "Novo estabelecimento"$/) do
    visit"/p/establishment/new"
end

When (/^Eu clico no botao "Editar"$/) do
    visit ("/p/establishment/edit/" + @establishment.id.to_s)
end