Given(/^Eu estou na pagina dos meus estabelecimentos$/) do
  visit "/dashboard/my_establishments"
end

Given(/^Eu estou na pagina do estabelecimento$/) do
  visit ("/establishment/" + @establishment.id.to_s)
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
  @user = User.new(name: "mcdada", email:'mc@dada', password_digest:'dadaboladao')
  @user.save
end

Given(/^Eu estou logado como cliente$/) do
    @user = User.new(name: "mcboco", email:'mc@pedro', password_digest:'pedro123')
    @user.save
    visit "/login"
    fill_in "email", with: "mc@pedro"
    fill_in "password", with: "pedro123"
    click_button("Entrar")
    visit "/dashboard/all_establishments"
end

Given(/^Eu estou logado como provider$/) do
    @user = User.new(name: "mcboco", is_provider: true, email:'mc@boco', password_digest:'boco123')
    @user.save
    visit "/login"
    fill_in "email", with: "mc@boco"
    fill_in "password", with: "boco123"
    click_button("Entrar")
    visit "/dashboard/all_establishments"

end

Given(/^Existe um estabelecimento visível a mim$/) do
    @establishment = Establishment.new(name: "Feijao do Edu", address: "Rua do Feijao", email:"caldo@feijao", website:"caldofeijao.com", user_id: 1)
    @establishment.save!
end

Given(/^Eu tenho um estabelecimento$/) do
    @establishment = Establishment.new(name: "Caldinho do Edu", address: "Rua do CDU", email:"caldo@caldo", website:"caldo.com", user_id: @user.id)
    @establishment.save!
end

Given(/^Existe um estabelecimento visível a mim chamado Gugu do feijao$/) do
    @establishment = Establishment.new(name: "Gugu do feijao", address: "Rua do gugu", email:"caldo@gugu", website:"caldodudu.com", user_id: 1)
    @establishment.save!
end

Given(/^Existe um estabelecimento visível a mim chamado Feijao do Edu$/) do
    @establishment = Establishment.new(name: "Feijao do Edu", address: "Rua do CDU", email:"caldo@caldo", website:"caldo.com", user_id: 1)
    @establishment.save!
end

Given(/^Eu estou na pagina de preferencias de musica$/) do
  visit ("/register/preferences/music")
end

Given(/^Existem restaurantes cadastrados$/) do
  @establishment = Establishment.new(name: "Edmilson Da Carne de Sol", address: "Rua do CDU", email:"caldo@caldo", website:"caldo.com")
  @establishment.save!
  
  @food = Food.new(name:"carne de sol")
  @food.save!
  
  @foodSpecialities = FoodSpeciality.new(establishment_id: @establishment.id, food_id: @food.id)
  @foodSpecialities.save!
  
  @music = Music.new(name:'Jazz')
  @music.save!
  
  @musicSpecialities = MusicSpeciality.new(establishment_id: @establishment.id, music_id: @music.id)
  @musicSpecialities.save!
  
  @ambient = Ambient.new(name:'Familiar')
  @ambient.save!
  
  @ambientSpecialities = AmbientSpeciality.new(establishment_id: @establishment.id, ambient_id: @ambient.id)
  @ambientSpecialities.save!
  
end