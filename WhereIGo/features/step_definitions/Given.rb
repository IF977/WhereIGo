Given(/^Eu estou na pagina de registro de estabelecimento$/) do
  #visit "/register/provider/establishment"
  visit "/p/dashboard"
end

Given(/^Eu estou na pagina inicial$/) do
  visit(root_path)
end

Given(/^Eu estou na pagina de login, nao estou logado e sou provider$/) do
  visit "/login"
  @user = User.new(name: "mctroinha", "is_provider": true, email:'mc@troinha', password_digest:'123mctroia123')
  @user.save
end

Given(/^Eu estou na pagina de login, nao estou logado e sou cliente$/) do
  visit "/login"
  @user = User.new(name: "mcdada", "is_client": true, email:'mc@dada', password_digest:'dadaboladao')
  @user.save
end

Given(/^Eu estou logado como provider$/) do
    @user = User.new(name: "mcboco", "is_provider": true, email:'mc@boco', password_digest:'boco123')
    @user.save
    visit "/login"
    fill_in "email", with: "mc@boco"
    fill_in "password", with: "boco123"
    click_button("Entrar")
end