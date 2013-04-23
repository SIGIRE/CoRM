# CORM
## Le CRM qui vous facilite la vie
Version: 0.8.0 (nightly)

### About CORM
CoRM is a **Customer Relationship Manager** (CRM) designed for *small businesses* about 1 to 100 collaborators. This software helps you to manage your relations between each actor that composing the business environment.

Actually, CoRM is not modular and does not support the multilingual translation with *I18n*. These evolution are planned, so don't worry about.


### Getting started

 * Install Ruby and Rails (if you don't have)
 * Download sources from git
 * Unpack zip file into a new folder

#### Configuration

 * config/database.yml - to define your database connections
 * config/routes.rb - to define your routes

#### Preparation

**Fresh install**: you're lucky !
'''shell
rake db:create
rake db:migrate # if you are with a dev version
rails s
'''

**Migration from older version**:
'''shell
rake db:migrate
rails s
'''

