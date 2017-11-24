When(/^[Eu ]*coloco ([^"]*) no campo ([^"]*)$/) do |data,input|
    fill_in input, with: data
end

When(/^[Eu ]*deixo em branco no campo ([^"]*)$/) do |input|
    fill_in input, with: nil
end

When(/^[Eu ]*clico em ([^"]*)$/) do |button|
    click_button(button)
end

When (/^Eu clico no nome do estabelecimento$/) do
  visit ("/establishment/" + @establishment.id.to_s)
end

When (/^Eu clico no botao "positivo"$/) do
    visit("/establishment/" + @establishment.id.to_s + "/review?review=true")
end

When (/^Eu clico no botao "negativo"$/) do
    visit("/establishment/" + @establishment.id.to_s + "/review?review=false")
end

When (/^Eu clico no botao "Novo estabelecimento"$/) do
    visit ("/dashboard/establishment/new")
end

When (/^Eu clico no botao "Editar"$/) do
    visit ("/dashboard/my_establishment/edit/" + @establishment.id.to_s)
end

When (/^Eu clico no botão do garfo e faca$/) do
    visit ("/dashboard/my_establishments")
end

When(/^Eu anexo uma imagem em browse$/) do
  path = File.join('features', 'photos', '19848903.jpeg')
  attach_file('establishment_image', path)
end

When(/^[Eu ]*digito ([^"]*) no campo ([^"]*)$/) do |data,input|
    fill_in input, with: data
    visit('/search/establishments?filter=' + data)
end