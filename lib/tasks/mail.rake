namespace :mail do
  desc "TODO"
  task :get_mail => :environment do
	require 'rubygems'
	require 'mail'

	Mail.defaults do
		retriever_method :pop3, :address => "pop.sigire.net",
				:port		 => 110,
				:user_name 	 => 'demo-crm@sigire.net',
				:password 	 => 'Lm4HDba%',
				:enable_ssl 	 => false
	
	# Stockage du nombre de mails dans une variable
	$nb = Mail.all.length
	puts($nb)

	# Récupération des mails
	emails = Mail.find_and_delete(:count => $nb)

	# Pour chaque mail reçu, on affiche son ID
	emails.each do |mail|
		# S'il n'y a qu'un expediteur
		if (mail.from.length == 1)
			# Récupération des utilisateurs ayant l'adresse mail expediteur
			@users = User.where(:email => mail.from)
			
			# Si on trouve bien un seul utilisateur, on continue
			if (@users.length == 1)
				$USER_ID = @users.first.id
				puts ("User ID : #{$USER_ID}")
				# S'il n'y a qu'un destinataire
				if (mail.to.length == 1)
				
					# Récupération des clients ayant l'adresse mail destinataire
					@contacts = Contact.where(:email => mail.to)

					# Si on trouve bien un seul contact, on continue
					if (@contacts.length == 1)
						contact = @contacts.first
						$CONTACT_ID = contact.id
						puts ("Contact ID : #{$CONTACT_ID}")
					if (!contact.account_id.nil?)
						# Action à faire dans le cas parfait
						puts("Le compte existe")
					else 
						# Pas de compte rataché au contact
						puts("Le compte n'existe pas")
					end
						
					# Si on ne trouve pas de contact
					elsif(@contacts.length < 1)
						# Action permettant de creer le contact
					else
						# Action permettant de gerer les contacts multiples
					end
				
				# Si il y plus d'un destinataire		
				else
					# Action a effectuer si .to > 1
					puts("Plus d'un destinataire trouve : #{mail.to}")
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
		
	end

	# On affiche le nombre de mails restants (normalement 0)
	puts("Nombre de mails : #{Mail.all.length}")
	end
  end

  desc "TODO"
  task :send_mail => :environment do
  end

end
