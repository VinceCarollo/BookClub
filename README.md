# Book Club

This app allows visitors and authors to create Book resources. Books belong to Authors. Users have CRUD functionality for their reviews which belong to a book. Common associations like authors book index pages are available to the user as well.

### Installing

- Clone Repo
```bash
git clone git@github.com:VinceCarollo/BookClub.git
```
- bundle
```bash
bundle install
```

- Set up Database
```bash
bundle exec rails db:{create,migrate,seed}
```

## Running the tests

- Rspec/Capybara
- Shoulda-Matchers
```bash
bundle exec rspec
```

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

## Built With

* [Ruby](https://rubyonrails.org/) - 2.4.1
* [Rails](https://rubyonrails.org/) - 5.1.7
* [PostgreSQL](https://www.postgresql.org/)

## Versioning

* [Bundle](https://bundler.io/)

## Authors

* **Vince Carollo** - [VinceCarollo](https://github.com/VinceCarollo)
