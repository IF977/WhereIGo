Then(/^Eu devo ver o texto ([^"]*)$/) do |text|
    expect(page).to have_content(text)
end

Then(/^Eu devo ir para próxima etapa do cadastro$/) do
  visit "/register/role"
end

Then(/^Eu devo ser direcionado para a pagina de dashboard$/) do
    page.assert_current_path('/dashboard/all_establishments')
end

Then(/^Eu devo ser direcionado para a pagina de criacao de estabelecimento$/) do
    page.assert_current_path('/dashboard/establishment/new')
end

Then(/^Eu devo ser direcionado para a pagina de edicao de estabelecimento$/) do
    page.assert_current_path('/dashboard/my_establishment/edit/' + @establishment.id.to_s)
end

Then(/^Eu devo ser direcionado para a pagina do estabelecimento$/) do
    page.assert_current_path("/establishment/" + @establishment.id.to_s)
end

Then(/^Eu sou direcionado para a pagina dos meus estabelecimentos$/) do
    page.assert_current_path("/dashboard/my_establishments")
end

Then(/^Eu devo ser direcionado para a pagina de preferencias de ambiente$/) do
    page.assert_current_path('/register/preferences/ambient')
end

Then(/^Eu devo ser direcionado para a pagina de preferencias de comida$/) do
    page.assert_current_path('/register/preferences/food')
end

Then(/^Eu devo ser direcionado para a pagina de estabelecimentos recomendados$/) do
    page.assert_current_path('/dashboard/recommended_establishments')
end

Then(/^Eu tenho uma conta criada com preferencia de comida$/) do
  @user = User.new(name: "Giles", email:'mc@giles', password_digest:'123giles123')
  @user.save!
  @foodPreferences = FoodPreference.new(user_id: @user.id, food_id: @food.id)
  @foodPreferences.save!
end

Then(/^Eu tenho uma conta criada com preferencia de musica$/) do
  @user = User.new(name: "Giles", email:'mc@giles', password_digest:'123giles123')
  @user.save!
  @musicPreferences = MusicPreference.new(user_id: @user.id, music_id: @music.id)
  @musicPreferences.save!
end

Then(/^Eu tenho uma conta criada com preferencia de ambiente$/) do
  @user = User.new(name: "Giles", email:'mc@giles', password_digest:'123giles123')
  @user.save!
  @ambientPreferences = AmbientPreference.new(user_id: @user.id, ambient_id: @ambient.id)
  @ambientPreferences.save!
end

Then(/^Eu tenho uma conta criada com preferencia de musica, ambiente e comida$/) do
  @user = User.new(name: "Giles", email:'mc@giles', password_digest:'123giles123')
  @user.save!
  @foodPreferences = FoodPreference.new(user_id: @user.id, food_id: @food.id)
  @foodPreferences.save!
  @musicPreferences = MusicPreference.new(user_id: @user.id, music_id: @music.id)
  @musicPreferences.save!
  @ambientPreferences = AmbientPreference.new(user_id: @user.id, ambient_id: @ambient.id)
  @ambientPreferences.save!
end
