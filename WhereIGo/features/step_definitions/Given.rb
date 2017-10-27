Given(/^Eu estou na pagina de registro de estabelecimento$/) do
  visit "/register/provider/establishment"
end

Given(/^Eu estou na pagina inicial$/) do
  visit(root_path)
end

Given(/^Eu estou na pagina de login e nao estou logado$/) do
  visit "/login"
  @user = User.new(name: "mctroinha", "is_provider": true, email:'mc@troinha', password_digest:'123mctroia123')
  @user.save
end

