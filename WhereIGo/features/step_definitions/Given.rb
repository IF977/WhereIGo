Given(/^Eu estou na pagina de registro de estabelecimento$/) do
  visit "/p/dashboard"
end

Given(/^Eu estou na pagina do estabelecimento$/) do
  visit ("/p/establishment/show/" + @establishment.id.to_s)
end

Given(/^Eu estou na pagina do estabelecimento a ser comentado$/) do
  visit ("/c/establishment/" + @establishment.id.to_s)
end

Given(/^Eu estou na pagina inicial$/) do
  visit(root_path)
end

Given(/^Eu estou na pagina de login, nao estou logado e sou provider$/) do
  visit "/login"
  @user = User.new(name: "mctroinha", is_provider: true, email:'mc@troinha', password_digest:'123mctroia123')
  @user.save
end

Given(/^Eu estou na pagina de login, nao estou logado e sou cliente$/) do
  visit "/login"
  @user = User.new(name: "mcdada", is_client: true, email:'mc@dada', password_digest:'dadaboladao')
  @user.save
end

Given(/^Eu estou logado como cliente$/) do
    @user = User.new(name: "mcboco", is_client: true, email:'mc@pedro', password_digest:'pedro123')
    @user.save
    visit "/login"
    fill_in "email", with: "mc@pedro"
    fill_in "password", with: "pedro123"
    click_button("Entrar")
    visit "/c/dashboard"
end


Given(/^Eu estou logado como provider$/) do
    @user = User.new(name: "mcboco", is_provider: true, email:'mc@boco', password_digest:'boco123')
    @user.save
    visit "/login"
    fill_in "email", with: "mc@boco"
    fill_in "password", with: "boco123"
    click_button("Entrar")
    visit "/p/dashboard"

end

Given(/^Existe um estabelecimento visível a mim$/) do
    @establishment = Establishment.new(name: "Feijao do Edu", cnpj:"11995678901234", address: "Rua do Feijao", email:"caldo@feijao", website:"caldofeijao.com", user_id: 1)
    @establishment.save!
end

Given(/^Eu tenho um estabelecimento$/) do
    @establishment = Establishment.new(name: "Caldinho do Edu", cnpj:"99995678901234", address: "Rua do CDU", email:"caldo@caldo", website:"caldo.com", user_id: 1)
    @establishment.save!
end
