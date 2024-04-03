##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [3.3.0]
- Rails [7.1.2]
- Redis [6.2.0]
- Postgres

##### 1. Check out the repository

```bash
git clone https://github.com/KuldeepChotaliya146/loan-management-system.git
```

##### 2. Install Gems

Install Gem dependencies using bundle install

```bash
bundle install
```

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:setup
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bin/dev
```

And now you can visit the site with the URL <http://localhost:3000>
