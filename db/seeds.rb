# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Creating default event types
if EventType.all.empty?

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
end;

#creating default anomalies types
if Anomaly.all.empty?

    Anomaly.create({ :name => 'duplicate_import', :notes => 'Doublon détecté dans l\'import', :level=>3 })
    Anomaly.create({ :name => 'duplicate_db', :notes => 'Doublon détecté dans la base', :level=>3 })
    Anomaly.create({ :name => 'company_name', :notes => 'Nom Société incorrect', :level=>3 })
    Anomaly.create({ :name => 'category', :notes => 'Catégorie incorrecte', :level=>3 })
    Anomaly.create({ :name => 'title', :notes => 'Civilité incorrecte', :level=>3 })
    Anomaly.create({ :name => 'name', :notes => 'Nom Prénom incorrect', :level=>3 })
    Anomaly.create({ :name => 'no_company', :notes => 'Compte société inexistant', :level=>2 })
    Anomaly.create({ :name => 'ok', :notes => '-', :level=>1 })
end

