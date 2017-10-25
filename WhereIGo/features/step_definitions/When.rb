When("Eu clico em {string}") do |button|
  click_button(button)
end

When(/^[Eu ]*coloco ([^"]*) no campo ([^"]*)$/) do |data,input|
    fill_in input, with: data
end