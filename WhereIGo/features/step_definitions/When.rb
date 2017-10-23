=begin
When(/^Eu preencho ([^"]*) com ([^"]*)$/) do |input,data|
    fill_in(input, :with => data)
end

When(/^Eu clico em ([^"]*)$/) do |button|
    click_button(button)
end
=end
When("Eu clico em {string}") do |button|
  click_button(button)
end

When("Eu preencho {string} com {string}") do |string, string2|
  fill_in(string, :with =>string2, visible: false)
end