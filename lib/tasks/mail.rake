	namespace :mail do
	
	desc "TODO"
	task :get_mails => :environment do
	require 'rubygems'
	require 'mail'
	

		# Récupération des mails
		emails = load_mails()
		
		# Si on a récupéré des emails
		if (!emails.nil?)

			# Stockage du nombre de mails dans une variable
			$nb = 1
			puts("Nombre de mails : #{emails.length} (apres recuperation)")

			# On parcours tous les emails
			emails.each do |mail|
				begin
					# S'il l'email n'a qu'un expediteur
					if (mail.from.length == 1)
	
						# Récupération des utilisateurs ayant l'adresse mail de l'expediteur
						users = User.where(:email => mail.from)
			
						# Si on trouve un seul utilisateur, on continuer
						if (users.length == 1)
								user = users.first
							# S'il y a bien un ou plusieurs destinataires
							if (mail.to.length >= 1)
						
								# On parcours toutes les adresses marquées comme destinataires
								mail.to.each do |destinataire|
						
									# Récupération des clients ayant l'adresse mail destinataire
									contacts = Contact.where(:email => destinataire)

									# Si on trouve un ou plusieurs contacts, on continue
									if (contacts.length >= 1)

										# On parcours tous les contacts récupérés
										contacts.each do |contact|

											# Si le contact est associé à un compte, on crée un évènement
											if (!contact.account_id.nil?)

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
!emails.nil?
											# Si le contact n'est pas associé à un compte
											else
												# Création de l'email
												email = Email.new
												email.user_id = user.id
												email.to = destinataire
												email.object = mail.subject
												email.content = convert(mail.body.decoded)
												email.send_at = mail.date.strftime("%Y-%m-%e %H:%M:%S")
												email.contact_id = contact.id
												email.save
											end
											# <--- FIN SI '!contact.account_id.nil?' 
										end
										# <--- FIN DE LA BOUCLE 'contacts.each'

									# Si on ne trouve pas de contact...
									else
										# Création de l'email
										email = Email.new
										email.user_id = user.id
										email.to = destinataire
										email.object = mail.subject
										email.content = convert(mail.body.decoded)
										email.send_at = mail.date.strftime("%Y-%m-%e %H:%M:%S")
										email.save
									end
									# <--- FIN SI 'contacts.length >= 1'
								end
								# <-- FIN DE LA BOUCLE 'mail.to.each'

							# Si on n'a pas de destinataire renseigné
							else
								 # Aucune action n'est effectuée
							end
							# <-- FIN DE LA BOUCLE 'mail.to.length >= 1'

						# Si on n'a pas d'utilisateur pouvant être le destinataire
						else
							# Aucune action n'est effectuée
						end
						# <--- FIN SI 'users.length == 1'

					# Si on n'a pas d'adresse expéditrice
					else
						# Aucune action n'est effectuée
					end
					# <--- FIN SI 'mail.from.length == 1'
				
				rescue Exception => e
					puts "Il y a eu une erreur de type #{e.class} avec un email"
					puts "#{e.backtrace.join("\n")}"
				end
				# <--- FIN DE LA RECUPERATION DES EXCEPTIONS
			end
			# <--- FIN DE LA BOUCLE 'emails.each'
			
			# On affiche le nombre de mails restants (normalement 0)
			puts("Nombre de mails : #{load_mails.length} (apres recuperation)")
		end
		# <--- FIN SI '!emails.nil?'
	end
	# <--- FIN TÂCHE 'get_mail'

	def convert(text)
			return text.force_encoding('iso8859-1').encode('UTF-8')
	end

	def load_mails()
		# Récupération de la connexion
		connection = WebmailConnection.first
		puts("Connexion recuperee : #{connection.server}:#{connection.port} (#{connection.login}:#{connection.password})")

		# Test de validité de la connexion
		state = WebmailConnection.check(connection)

		# Si la connexion est marquée comme active et est valide
		puts("Active connection : #{connection.active}")
		puts("Connection state : #{state}")
			
		if connection.active && state
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
					return Mail.find_and_delete
				end
			end
		else
			return nil
		end
	end
	end
