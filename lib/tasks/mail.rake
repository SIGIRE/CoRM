# encoding: utf-8	
	namespace :mail do
	
	desc "TODO"
	task :get_mails => :environment do
	require 'rubygems'
	require 'mail'
	

		# RÃ©cupÃ©ration de la connexion
		connection = WebmailConnection.first

		# Test de validitÃ© de la connexion
		state = WebmailConnection.check(connection)

		# Si la connexion est marquÃ©e comme active et est valide
		puts("Active connection : #{connection.active}")
		puts("Connection state : #{state}")
		
		emails = nil
		event_id = nil	
		if connection.active && state
			begin
			rescue 
				puts("An error occured")
				return nil
			else
				# RÃ©cupÃ©ration des Ã©lÃ©ments de connexion
				Mail.defaults do
					retriever_method :pop3, :address => connection.server,
							:port		 => connection.port,
							:user_name 	 => connection.login,
							:password 	 => connection.password,
							:enable_ssl 	 => false

					# RÃ©cupÃ©ration des mails
					#emails = Mail.find_and_delete
					emails = Mail.all
					event_id = connection.type_event_id
				end
			end
		else
		end

		# Si on a rÃ©cupÃ©rÃ© des emails et un type d'Ã©vÃ¨nement
		if (!emails.nil? and !event_id.nil?)

			# Stockage du nombre de mails dans une variable
			puts("Nombre de mails : #{emails.length} (avant recuperation)")

			# On parcours tous les emails
			emails.each do |mail|
				begin
					# S'il l'email n'a qu'un expediteur
					if (mail.from.length == 1)
	
						# RÃ©cupÃ©ration des utilisateurs ayant l'adresse mail de l'expediteur
						users = User.where(:email => mail.from)
			
						# Si on trouve un seul utilisateur, on continuer
						if (users.length == 1)
								user = users.first
							# S'il y a bien un ou plusieurs destinataires
							if (mail.to.length >= 1)
						
								# On parcours toutes les adresses marquÃ©es comme destinataires
								mail.to.each do |destinataire|
						
									# RÃ©cupÃ©ration des clients ayant l'adresse mail destinataire
									contacts = Contact.where(:email => destinataire)

									# Si on trouve un ou plusieurs contacts, on continue
									if (contacts.length >= 1)
										# On parcours tous les contacts rÃ©cupÃ©rÃ©s
										contacts.each do |contact|
											# Si le contact est associÃ© Ã  un compte, on crÃ©e un Ã©vÃ¨nement
											if (!contact.account_id.nil?)

												# CrÃ©ation de l'Ã©vÃ¨nement
												event = Event.new
												event.date_begin = mail.date.strftime("%Y-%m-%d %H:%M:%S")
												event.date_end = mail.date.strftime("%Y-%m-%d %H:%M:%S")
												event.notes = "Sujet : #{mail.subject} \n #{retrieve_body(mail)}"
												event.created_by = user.id
												event.contact_id = contact.id
												event.account_id = contact.account_id	
												event.event_type_id = event_id
												event.user_id = user.id
												
												# RÃ©cupÃ©ration des piÃ¨ces-jointes
												attachements = retrieve_attachements(mail)
												if (!attachements.nil?)
										            attachements.each do |attachement|
										                event.attach = attachement
										            end
										        end
												event.save
											# Si le contact n'est pas associÃ© Ã  un compte
											else
												# CrÃ©ation de l'email
												email = Email.new
												email.user_id = user.id
												email.to = destinataire
												email.object = mail.subject
												email.content = retrieve_body(mail)
												email.send_at = mail.date.strftime("%Y-%m-%d %H:%M:%S")
												email.contact_id = contact.id
												email.save
												
												puts ("Email n. => #{email.id}")
												# RÃ©cupÃ©ration des piÃ¨ces-jointes
												attachements = retrieve_attachements(mail)
										        if (!attachements.nil?)
										            attachements.each do |attachement|
										                attach = EmailAttachement.new
				                                        attach.attach = attachement
										                email.email_attachements << attach
										            end
										        end
											end
											# <--- FIN SI '!contact.account_id.nil?' 
										end
										# <--- FIN DE LA BOUCLE 'contacts.each'

									# Si on ne trouve pas de contact...
									else
										# CrÃ©ation de l'email
										email = Email.new
										email.user_id = user.id
										email.to = destinataire
										email.object = mail.subject
										email.content = retrieve_body(mail)
										email.send_at = mail.date.strftime("%Y-%m-%d %H:%M:%S")
										email.save
										
										puts ("Email n. => #{email.id}")
										# RÃ©cupÃ©ration des piÃ¨ces-jointes
										attachements = retrieve_attachements(mail)
										if (!attachements.nil?)
										    attachements.each do |attachement|
										        attach = EmailAttachement.new
				                                attach.attach = attachement
										        email.email_attachements << attach
										    end
										end
										puts "END EMAIL"
										
										
									end
									# <--- FIN SI 'contacts.length >= 1'
								end
								# <-- FIN DE LA BOUCLE 'mail.to.each'

							# Si on n'a pas de destinataire renseignÃ©
							else
								 # Aucune action n'est effectuÃ©e
							end
							#Â <-- FIN DE LA BOUCLE 'mail.to.length >= 1'

						#Â Si on n'a pas d'utilisateur pouvant Ãªtre le destinataire
						else
							# Aucune action n'est effectuÃ©e
						end
						# <--- FIN SI 'users.length == 1'

					# Si on n'a pas d'adresse expÃ©ditrice
					else
						# Aucune action n'est effectuÃ©e
					end
					#Â <--- FIN SI 'mail.from.length == 1'
				rescue Exception => e
					puts "Il y a eu une erreur de type #{e.class} avec un email"
					puts "#{e.backtrace.join("\n")}"
				end
				# <--- FIN DE LA RECUPERATION DES EXCEPTIONS
			end
			# <--- FIN DE LA BOUCLE 'emails.each'
			
			# On affiche le nombre de mails restants (normalement 0)
			begin 
				puts("Nombre de mails : #{Mail.all.length} (apres recuperation)")
			rescue Timeout::Error => e
				puts("Impossible de joindre le serveur... reconnexion en cours")	
				puts("Nombre de mails : #{Mail.all.length} (apres recuperation)")
			end
		end
		# <--- FIN SI '!emails.nil?'
	end
	# <--- FIN TÃ‚CHE 'get_mail'

	def convert(text)
			return text.force_encoding('iso8859-1').encode('UTF-8')
	end

	def retrieve_body(mail)
		begin
		text = ""
		encoding = ""
		# Si le mail est de type multipart
		if (mail.multipart?)
			puts "Multipart? => TRUE"
			mail.parts.each do |p|
				puts p.content_type
				if (p.content_type.include? "text/plain")
						text << "#{p.body}\n"
						encoding = p.content_type_parameters["charset"]
				elsif (p.content_type.include? "alternative")
					p.parts.each do |sub|
						if (sub.content_type.include? "text/plain")
							text << "#{sub.body}\n"
							encoding = sub.content_type_parameters["charset"]
						end
					end
				end
			end
		# Si le mail n'est pas de type multipart
		else
			text = mail.body.decoded
		end
		if (!encoding.blank?)
				text = text.force_encoding(encoding).encode('UTF-8')
		else
				if (text.force_encoding("UTF-8").encode('UTF-8').valid_encoding?)
					text = text.force_encoding("UTF-8").encode('UTF-8')
				elsif (text.force_encoding("iso-8859-1").encode('UTF-8').valid_encoding?)
					text = text.force_encoding("iso-8859-1").encode('UTF-8')
				end
		end
	rescue Exception => e
		puts e
		puts e.backtrace.join("\n")
		return nil
	else
		return text
	end
	end

	def retrieve_attachements(mail)
	    puts("Entree dans retrieve_attachements")
		# On vÃ©rifie la prÃ©sence de piÃ¨ces-jointes
		if (mail.attachments.length >= 1)
			puts("Cet email a #{mail.attachments.length} pieces jointes")
			array = []
			i = 1
			mail.attachments.each do |attachement|
			    puts("Attachment n. #{i} - #{attachement.filename} (#{attachement.mime_type})")
				file = StringIO.new(attachement.decoded)
				file.class.class_eval { attr_accessor :original_filename, :content_type }
				file.original_filename = attachement.filename
				file.content_type = attachement.mime_type
				array.push file
				i = i+1
			end

			return array
		else
			puts("Cet email n'a pas de piece jointe!")
			return nil
		end
	end
	end
