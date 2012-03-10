RAILS_ENV=production bundle exec rake assets:precompile
git add .
git commit -a -m "commmit de deploy na produção"
git push
git push heroku master

