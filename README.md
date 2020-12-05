# Group 02 Wallet App

- Staging server linked to development branch: https://walletest-reborn.herokuapp.com/
- Production server linked to master branch: https://walletest-born.herokuapp.com/

## Entrega 1 (16/09)

- [X] Modelo de datos
- [X] Mock-ups
- [X] Relatos de usuario
- [X] Planificación de relatos en las distintas entregas
- [X] Configuración de ambiente de desarrollo
- [X] CRUD de usuarios
- [X] Lógica de sesiones
- [X] Tests de modelos / controladores / vistas / rutas

+ Modelo de datos y Mock-ups se encuentran en la carpeta [docs](https://github.com/IIC3745-2020-2/grupo02/tree/master/docs). Actualmente está desactualizado
+ [HU](https://github.com/IIC3745-2020-2/grupo02/issues) se encuentran en las issue del repo 
+ La planificación de las HU se encuentra en forma de ([milestones](https://github.com/IIC3745-2020-2/grupo02/milestones), lo cual se encuentran en las issue del repo 

## Entrega 4

+ El informe de pruebas de usuarios se encuentra en la carpeta [docs.](https://github.com/IIC3745-2020-2/grupo02/tree/master/docs) El enlace al material adicional de las pruebas se encuentra en el informe.

## Development setup

* `touch .env`
* `docker-compose build`
* `docker-compose run --rm web bundle install`
* `docker-compose run --rm web yarn install`
* `docker-compose run --rm web rails db:create db:schema:load`
* Copy `development.key` inside `config/credentials`
* `docker-compose up -d`
* Open `localhost:3000` with any browser

### Run tests and linters

* Run almost all: `docker-compose exec web rake`
* `docker-compose exec web bundle exec rspec`
* `docker-compose exec web yarn eslint`
* `docker-compose exec web rake scss_lint`
* `docker-compose exec web rubocop`
* `docker-compose exec web rake erblint`
* `docker-compose exec web bundle-audit check --update`
* `docker-compose exec web brakeman -z -q`

### Development tips

* Check new versions of gems: `docker-compose exec web bundle outdated --no-local`
* Clear docker space on disk: `docker system prune -a --volumes`
* Edit credentials: `docker-compose run --rm web rails credentials:edit --environment X`
* Fix eslint offences automatically: `docker-compose exec web yarn run eslint --fix --ext .js,.es6 app/javascripts`
* Fix rubocop offences automatically: `docker-compose exec web rubocop -a`
* Fix erblint offences automatically: `docker-compose exec web bundle exec erblint --lint-all -a`

* Populate database `docker-compose run --rm web rails db:seed` (works and doesn't die) and [useful website](https://makeitrealcamp.gitbook.io/ruby-on-rails-5/seeds)
* Execute migrations `docker-compose run --rm web rails db:migrate`