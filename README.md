[![CircleCI](https://circleci.com/gh/bcrivelaro/happy_nel.svg?style=svg)](https://circleci.com/gh/bcrivelaro/happy_nel)

### Development

_Make sure you have the latest stable version of docker and docker-compose._

Get your `.env` file:

```bash
cp .env.sample .env
```

After that, you only need Docker:

```bash
$ docker-compose build
$ docker-compose up
$ docker-compose run app rails db:create db:migrate db:seed
```

Create an Admin using `rails console`:

```ruby
Admin.create!(email: 'admin@email.com', password: '123456', password_confirmation: '123456')
```

_NOTE: If you are having permission problems when using Linux, try to run the following commands before proceeding:_

```bash
$ docker-compose down
$ sudo chown -R $USER:$USER .
```

### Automated tests

Run:
```bash
$ docker-compose run app rspec
```