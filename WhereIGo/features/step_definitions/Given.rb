Given(/^Eu estou na pagina de registro de estabelecimento$/) do
  visit "/register/provider/establishment"
end

Given(/^Eu estou na pagina inicial$/) do
  visit(root_path)
end