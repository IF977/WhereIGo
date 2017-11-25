Augusto

git config --global user.name "aacgn"; git config --global user.email "aacgn@cin.ufpe.br"; git config --list

Eduardo

git config --global user.name "eduardosm7"; git config --global user.email "esm7@cin.ufpe.br"; git config --list

Marcos

git config --global user.name "mvhb"; git config --global user.email "mvhb@cin.ufpe.br"; git config --list

Vinícius

git config --global user.name "gilesv"; git config --global user.email "viniciusgcp@gmail.com"; git config --list

Apos merge no github, atualizar o repositorio local com
git pull origin master

Para fazer deploy pro Heroku

bundle exec rake assets:precompile

git add .

git commit -m ""

git push

heroku login

git subtree --prefix WhereIGo push heroku master

heroku run RAILS_ENV=production bin/rails assets:precompile

Para fazer atualização do banco de dados

heroku run rake db:create

heroku run rake db:migrate

Para limpar o bando de dados do Heroku

heroku pg:reset DATABASE

heroku run rake db:migrate

Popular com seu banco

heroku run rake db:seed