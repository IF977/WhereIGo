When(/^[Eu ]*coloco ([^"]*) no campo ([^"]*)$/) do |data,input|
    fill_in input, with: data
end

When(/^[Eu ]*clico em ([^"]*)$/) do |button|
    click_button(button)
end

When (/^I press "Novo estabelecimento"$/) do
    visit"/p/establishment/new"
end