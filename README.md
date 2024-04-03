##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [3.3.0]
- Rails [7.1.3]
- Redis [6.2.0]
- Postgres
- Nodejs

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

After running above you have one user and one admin with below credentials

```ruby
Email: kuldeep@gmail.com
Password: password

Email: admin@gmail.com
Password: admin123
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bin/dev
```

And now you can visit the site with the URL <http://localhost:3000>

## User Loans screen
![loan-screen](https://github.com/KuldeepChotaliya146/loan-management-system/assets/64406135/10de51f2-5e64-409f-9a90-b02ea2bc1ccf)

## Admin request screen
![admin-request-screen](https://github.com/KuldeepChotaliya146/loan-management-system/assets/64406135/a995ea9f-305a-4022-b38d-bd64f6a9471a)

## User loan approve by admin
![admin-approved-loan](https://github.com/KuldeepChotaliya146/loan-management-system/assets/64406135/37c95e19-cd04-49af-aba3-ae6592beaf34)





