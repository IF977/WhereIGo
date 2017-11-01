When(/^[Eu ]*coloco ([^"]*) no campo ([^"]*)$/) do |data,input|
    fill_in input, with: data
end

When(/^[Eu ]*deixo em branco no campo ([^"]*)$/) do |input|
    fill_in input, with: nil
end


When(/^[Eu ]*clico em ([^"]*)$/) do |button|
    click_button(button)
end

When (/^Eu clico no botao "Novo estabelecimento"$/) do
    visit"/p/establishment/new"
end

When (/^Eu clico no botao "Editar"$/) do
    visit ("/p/establishment/edit/" + @establishment.id.to_s)
end