	namespace :mail do
	
	desc "TODO"
	task :get_mail => :environment do
	require 'rubygems'
	require 'mail'
	

		# Récupération des mails
		emails = getMails()
		if (!emails.nil?)
		# Stockage du nombre de mails dans une variable
		$nb = 1
		puts("Nombre de mails : #{emails.length} (apres recuperation)")
		# Pour chaque mail reçu, on affiche son ID
		emails.each do |mail|
		begin
			puts mail.to
			# S'il n'y a qu'un expediteur
			if (mail.from.length == 1)
				# Récupération des utilisateurs ayant l'adresse mail expediteur
				users = User.where(:email => mail.from)
			
				# Si on trouve bien un seul utilisateur, on continue
				if (users.length == 1)
					user = users.first
					puts ("User ID : #{user.id}")
					# S'il n'y a qu'un destinataire
					if (mail.to.length == 1)
				
						# Récupération des clients ayant l'adresse mail destinataire
						contacts = Contact.where(:email => mail[:to].decoded)

						# Si on trouve bien un seul contact, on continue
						if (contacts.length == 1)
							contact = contacts.first
							puts ("Contact ID : #{contact.id}")
							if (!contact.account_id.nil?)
							# Action à faire dans le cas parfait
							puts("Le compte existe")

							# Création de l'évènement
							event = Event.new
							event.date_begin = mail.date.strftime("%Y-%m-%e %H:%M:%S")
							event.date_end = mail.date.strftime("%Y-%m-%e %H:%M:%S")
							event.notes = "Sujet : #{mail.subject} \n #{convert(mail.body.decoded)}"
							event.created_by = user.id
							event.contact_id = contact.id
							event.account_id = contact.account_id	
							event.event_type_id = connection.type_event_id
							event.user_id = user.id
							event.save
						else 
							# Pas de compte rataché au contact
							puts("Le contact existe, mais n'est rattache a aucun compte")

							# Création de l'email
							email = Email.new
							email.user_id = user.id
							email.to = mail[:to].decoded
							email.object = mail.subject
							email.content = convert(mail.body.decoded)
							email.send_at = mail.date.strftime("%Y-%m-%e %H:%M:%S")
							email.contact_id = contact.id
							email.save
						end 
						
						# Si on ne trouve pas de contact
						elsif(contacts.length < 1)
							puts("Le contact n'existe pas")

							# Création de l'email
							email = Email.new
							email.user_id = user.id
							email.to = mail[:to].decoded
							email.object = mail.subject
							email.content = convert(mail.body.decoded)
							email.send_at = mail.date.strftime("%Y-%m-%e %H:%M:%S")
							begin
							email.save
							rescue
							puts("Erreur capturee")
							email.content = convert2(mail.body.decoded)
							email.save
							end
						else
							puts("Deux contacts portent la meme adresse mail")
							# On crée un email pour chacun des contacts
							contacts.each do |contact|
								# Création de l'email
								email = Email.new
								email.user_id = user.id
								email.to = contact.email
								email.object = mail.subject
								email.content = convert(mail.body.decoded)
								email.send_at = mail.date.strftime("%Y-%m-%e %H:%M:%S")
								
								# Si le contact à un compte...
								if (!contact.account_id.nil?)
									email.account_id = contact.account_id
								end
								email.save
							end
						end
				
					# Si il y plus d'un destinataire		
					else
						# Action a effectuer si .to > 1
						puts("Plus d'un destinataire trouve : #{mail.to}")
						mail.to.each do |destinataire|
						
							# Récupération des clients ayant l'adresse mail destinataire
							contacts = Contact.where(:email => destinataire)

							# Si on trouve bien un seul contact, on continue
							if (contacts.length == 1)
								contact = contacts.first
								puts ("Contact ID : #{contact.id}")
							if (!contact.account_id.nil?)
								# Action à faire dans le cas parfait
								puts("Le compte existe")

								# Création de l'event
								event = Event.new
								event.date_begin = mail.date.strftime("%Y-%m-%e %H:%M:%S")
								event.date_end = mail.date.strftime("%Y-%m-%e %H:%M:%S")
								event.notes = "Sujet : #{mail.subject} \n #{convert(mail.body.decoded)}"
								event.created_by = user.id
								event.contact_id = contact.id
								event.account_id = contact.account_id	
								event.event_type_id = connection.type_event_id
								event.user_id = user.id
								event.save
							else 
								# Pas de compte rataché au contact
								puts("Le contact existe, mais n'est rattache a aucun compte")
								email = Email.new
								email.user_id = user.id
								email.to = destinataire
								email.object = mail.subject
								email.content = convert(mail.body.decoded)
								email.send_at = mail.date.strftime("%Y-%m-%e %H:%M:%S")
								email.contact_id = contact.id
								email.save
							end 
						
							# Si on ne trouve pas de contact
							elsif(contacts.length < 1)
								# Action permettant de creer le contact
								puts("Le contact n'existe pas")
								email = Email.new
								email.user_id = user.id
								#email.to = mail.to.to_s.gsub('["',"").gsub('"]',"")
								email.to = destinataire
								email.object = mail.subject
								email.content = convert(mail.body.decoded)
								email.send_at = mail.date.strftime("%Y-%m-%e %H:%M:%S")
								email.save
							else
								# Action permettant de gerer les contacts multiples
								puts("Deux contacts portent la meme adresse mail")
							
								contacts.each do |contact|
									email = Email.new
									email.user_id = user.id
									email.to = destinataire
									email.object = mail.subject
									email.content = convert(mail.body.decoded)
									email.send_at = mail.date.strftime("%Y-%m-%e %H:%M:%S")
								
									# Si le contact à un compte...
									if (!contact.account_id.nil?)
										email.account_id = contact.account_id
									end
									email.save
								end
							end
						end	
						
					end		
				
				# Si on ne trouve pas d'utilisateur pouvant être l'expediteur	
				else
					# Action a effectuer si on ne trouve pas l'expediteur
					puts("Aucun collaborateur n'utilise l'adresse mail #{mail.from}")
				end
		
			# Si il y plus d'un expéditeur
			else
				# Action a effectuer si .from > 1
				puts("Plus d'un expediteur trouve : #{mail.from}")
			end
		
		rescue Exception => e
			puts "Il y a eu une erreur de type #{e.class} avec un email"
		end
		end
		# On affiche le nombre de mails restants (normalement 0)
		puts("Nombre de mails : #{getMails().length} (apres recuperation)")
	end
	end
	end

	desc "TODO"
	task :send_mail => :environment do
	end

	def convert(text)
			return text.force_encoding('iso8859-1').encode('UTF-8')
	end

	def getMails()
		# Récupération de la connexion
		connection = WebmailConnection.first
		puts("Connexion recuperee : #{connection.server}:#{connection.port} (#{connection.login}:#{connection.password})")

		# Test de validité de la connexion
		$state = connection.check

		# Si la connexion est marquée comme active et est valide
		puts("Active connection : #{connection.active}")
		puts("Connection state : #{$state}")
			
		if connection.active && $state
			begin
			rescue 
				puts("An error occured")
				return nil
			else
				# Récupération des éléments de connexion
				Mail.defaults do
					retriever_method :pop3, :address => connection.server,
							:port		 => connection.port,
							:user_name 	 => connection.login,
							:password 	 => connection.password,
							:enable_ssl 	 => false

					# Récupération des mails
					return Mail.all
				end
			end
		else
			return nil
		end
	end
