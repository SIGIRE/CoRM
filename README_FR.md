# CORM
### Plus facile qu'un CRM
Version: 0.9.1 (nightly)

## A propos de CoRM
Corm est un **Customer Relationship manager** (Gestionnaire de relation client) conçu pour les entreprises de 1 à 100 collaborateurs. Ce logiciel vous aide à gérer vos relations entre chaque acteur qui composent votre environnement.

Corm ne contient pas de fonctionnalités superflues. Ce logiciel est construit pour vous aider, pas pour vous stopper avec des champs obligatoires lors d'un entretien ou quelque chose d'autre.

Pour l'instant, CoRM n'est pas modulaire et ne supporte pas la traduction multilingue avec * I18n *. Ces évolutions sont prévues, alors ne vous inquiétez pas.

## Système requis

 * Ruby 1.9.3p194
 * Rails 3.2.12

### Versions minimum d'adaptateurs de base de données supportés

 * PostgreSQL with gem *pg v0.14*
 * MySQL with gem *mysql2 v0.3.11*
 * SQLite with gem *sqlite3 v1.3.7*

## Pour commencer

 * Installer Ruby and Rails
 * Télécharger et dézipper les sources à partir de GIT

#### Configuration

 * Executez la commande 'bundle install' pour installer les dépendances
 * Modifier config/database.yml pour définir la connexion à la base de données

#### Préparation

Installation de la base de données:

```
rake db:setup
```

Migrer depuis une ancienne version:

```
rake db:migrate
```

Maintenant, vous pouvez executer **rails s** si vous utilisez WEBrick.

Ok, votre server est lancé mais vous devez créer le premier utilisateur: l'administrateur de l'application.
Lancer vous navigateur préféré et aller à **localhost:3000/user/new**

Ca y est, votre utilisateur principal est créé!
Bon, il es temps pour vous d'ajouter des Types d'évènement comme 'Appel entrant' ou  'Appel sortant', vos modèles de devis pour créer vous devis facilement et rapidement...

Pour achever l'installation, je vous conseille de prendre un café bien mérité !
Félicitation !

## License
CoRM est sous la [license GNU Affero](http://www.gnu.org/licenses/agpl-3.0.html "Liens vers la license GNU Affero").
