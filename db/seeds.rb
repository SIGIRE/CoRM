# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

EventType.create({ :label => 'Appel téléphonique', :direction => 'Entrant' })
EventType.create({ :label => 'Appel téléphonique', :direction => 'Sortant' })
EventType.create({ :label => 'Appel téléphonique', :direction => 'Interne' })

EventType.create({ :label => 'E-mail', :direction => 'Entrant' })
EventType.create({ :label => 'E-mail', :direction => 'Sortant' })
EventType.create({ :label => 'E-mail', :direction => 'Interne' })

EventType.create({ :label => 'Courrier', :direction => 'Entrant' })
EventType.create({ :label => 'Courrier', :direction => 'Sortant' })

EventType.create({ :label => 'Note', :direction => 'Interne' })

EventType.create({ :label => 'Fax', :direction => 'Entrant' })
EventType.create({ :label => 'Fax', :direction => 'Sortant' })

EventType.create({ :label => 'Rendez-vous', :direction => 'Interne' })
EventType.create({ :label => 'Rendez-vous', :direction => 'Externe' })
