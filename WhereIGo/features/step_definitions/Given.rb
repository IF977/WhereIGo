Given(/^Eu estou na pagina de registro de estabelecimento$/) do
  visit "/register/provider/establishment"
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

Given(/^Eu estou logado$/) do
    @user = User.new(name: "mcboco", "is_provider": true, email:'mc@troinha', password_digest:'123mctroia123')
    @user.save
    visit(login_path)
    fill_in "session[email]", with: "user@cin.ufpe"
    fill_in "session[password]", with: "123456"
    click_button("Fazer Login")
end