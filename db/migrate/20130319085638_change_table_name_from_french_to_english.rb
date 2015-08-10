##
# Migration script to change all tables names from French to English
# in way to open the sources
#
class ChangeTableNameFromFrenchToEnglish < ActiveRecord::Migration

  ##
  # Set the changes up
  #
  def up
    # rename all tables with the new English name
    rename_table(:items, :quotation_lines)
    rename_table(:devis, :quotations)
    rename_table(:opportunites, :opportunities)
    rename_table(:origines, :origins)
    rename_table(:produits, :tags)
    rename_table(:taches, :tasks)
    rename_table(:types, :event_types)
    rename_table(:evenements, :events)
    rename_table(:comptes, :accounts)
    rename_table(:modeles, :quotation_templates)
    rename_table(:comptes_produits, :accounts_tags)
    rename_table(:contacts_produits, :contacts_tags)

    # rename fields && foreign keys
    # for the new Accounts table
    rename_column(:accounts, :origine_id, :origin_id)
      rename_column(:accounts, :societe, :company)
      rename_column(:accounts, :adresse1, :adress1)
      rename_column(:accounts, :adresse2, :adress2)
      rename_column(:accounts, :cp, :zip)
      rename_column(:accounts, :ville, :city)
      rename_column(:accounts, :pays, :country)
      rename_column(:accounts, :code_compta, :accounting_code)
      rename_column(:accounts, :genre, :category)

    # for the new renamed accounts_tags table
    rename_column(:accounts_tags, :compte_id, :account_id)
    rename_column(:accounts_tags, :produit_id, :tag_id)

    # for the new renamed contacts_tags table
    rename_column(:contacts_tags, :produit_id, :tag_id)

    # for the Contacts table
    rename_column(:contacts, :compte_id, :account_id)
      rename_column(:contacts, :nom, :surname)
      rename_column(:contacts, :prenom, :forename)
      rename_column(:contacts, :civilite, :title)
      rename_column(:contacts, :fonction, :job)

    # for the new renamed Quotations tables
    rename_column(:quotations, :ref_compte, :ref_account)
    rename_column(:quotations, :compte_id, :account_id)
    rename_column(:quotations, :opportunite_id, :opportunity_id)
    rename_column(:quotations, :modele_id, :quotation_template_id)
      rename_column(:quotations, :validite, :validity)
      rename_column(:quotations, :societe, :company)
      rename_column(:quotations, :adresse1, :adress1)
      rename_column(:quotations, :adresse2, :adress2)
      rename_column(:quotations, :cp, :zip)
      rename_column(:quotations, :ville, :city)
      rename_column(:quotations, :pays, :country)
      rename_column(:quotations, :nom, :surname)
      rename_column(:quotations, :prenom, :forename)
      rename_column(:quotations, :civilite, :title)
      rename_column(:quotations, :fonction, :job)
      # Totals
      rename_column(:quotations, :total_ht_cents, :total_excl_tax_cents)
      rename_column(:quotations, :total_ht_currency, :total_excl_tax_currency)
      rename_column(:quotations, :total_ttc_cents, :total_incl_tax_cents)
      rename_column(:quotations, :total_ttc_currency, :total_incl_tax_currency)

      # VAT
      rename_column(:quotations, :taux_tva, :VAT_rate)
      rename_column(:quotations, :total_tva_cents, :total_VAT_cents)
      rename_column(:quotations, :total_tva_currency, :total_VAT_currency)
      # File
      rename_column(:quotations, :fichier_joint_file_name, :attach_file_name)
      rename_column(:quotations, :fichier_joint_content_type, :attach_content_type)
      rename_column(:quotations, :fichier_joint_file_size, :attach_file_size)
      rename_column(:quotations, :fichier_joint_updated_at, :attach_updated_at)

    # for the Documents table
    rename_column(:documents, :compte_id, :account_id)
      rename_column(:documents, :nom, :name)
      # File
      rename_column(:documents, :fichier_joint_file_name, :attach_file_name)
      rename_column(:documents, :fichier_joint_content_type, :attach_content_type)
      rename_column(:documents, :fichier_joint_file_size, :attach_file_size)
      rename_column(:documents, :fichier_joint_updated_at, :attach_updated_at)

    # for the new renamed Events table (ex: evenements)
    rename_column(:events, :compte_id, :account_id)
      rename_column(:events, :tache_id, :task_id)
      rename_column(:events, :debut, :date_begin)
      rename_column(:events, :fin, :date_end)
      rename_column(:events, :type_id, :event_type_id)
      #rename_column(:events, :modified_by, :updated_by)
      # File
      rename_column(:events, :fichier_joint_file_name, :attach_file_name)
      rename_column(:events, :fichier_joint_content_type, :attach_content_type)
      rename_column(:events, :fichier_joint_file_size, :attach_file_size)
      rename_column(:events, :fichier_joint_updated_at, :attach_updated_at)

    # for the new renamed quotationLines table (ex: item)
    rename_column(:quotation_lines, :devi_id, :quotation_id)
      rename_column(:quotation_lines, :prix_ht_cents, :price_excl_tax_cents)
      rename_column(:quotation_lines, :prix_ht_currency, :price_excl_tax_currency)
      rename_column(:quotation_lines, :total_ht_cents, :total_excl_tax_cents)
      rename_column(:quotation_lines, :total_ht_currency, :total_excl_tax_currency)
      rename_column(:quotation_lines, :quantite, :quantity)

    # for the new renamed Templates table (ex: modeles)
      rename_column(:quotation_templates, :societe, :company)
      rename_column(:quotation_templates, :adresse, :adress)
      rename_column(:quotation_templates, :cp, :zip)
      rename_column(:quotation_templates, :ville, :city)
      rename_column(:quotation_templates, :pays, :country)
      rename_column(:quotation_templates, :tva, :vat)
      rename_column(:quotation_templates, :siret, :company_registration_number)
      # File
      rename_column(:quotation_templates, :fichier_joint_file_name, :attach_file_name)
      rename_column(:quotation_templates, :fichier_joint_content_type, :attach_content_type)
      rename_column(:quotation_templates, :fichier_joint_file_size, :attach_file_size)
      rename_column(:quotation_templates, :fichier_joint_updated_at, :attach_updated_at)
      rename_column(:quotation_templates, :site, :web)

    # for the new renamed Opportunities table (ex: opportunites)
    rename_column(:opportunities, :compte_id, :account_id)
      rename_column(:opportunities, :echeance, :term)
      rename_column(:opportunities, :remarque, :remark)
      rename_column(:opportunities, :nom, :name)
      rename_column(:opportunities, :montant, :amount) # hesite avec total
      # File
      rename_column(:opportunities, :fichier_joint_file_name, :attach_file_name)
      rename_column(:opportunities, :fichier_joint_content_type, :attach_content_type)
      rename_column(:opportunities, :fichier_joint_file_size, :attach_file_size)
      rename_column(:opportunities, :fichier_joint_updated_at, :attach_updated_at)
      rename_column(:opportunities, :marge, :profit)

    # for the new renamed Origins table (ex: Origines)
      rename_column(:origins, :nom, :name)

    # for the new renamed Tags table (ex: Produits)
      rename_column(:tags, :nom, :name)

    # for the Relations table
    rename_column(:relations, :compte1_id, :account1_id)
    rename_column(:relations, :compte2_id, :account2_id) # Double relation ou pas ?
      rename_column(:relations, :nom, :name)

    # for the new Tasks table (ex: tache)
    rename_column(:tasks, :compte_id, :account_id)
      rename_column(:tasks, :echeance, :term)
      # File
      rename_column(:tasks, :fichier_joint_file_name, :attach_file_name)
      rename_column(:tasks, :fichier_joint_content_type, :attach_content_type)
      rename_column(:tasks, :fichier_joint_file_size, :attach_file_size)
      rename_column(:tasks, :fichier_joint_updated_at, :attach_updated_at)

    # for the new renamed EventTypes table (ex: Types)
      rename_column(:event_types, :libelle, :label)

    # for the table Users
      rename_column(:users, :prenom , :forename)
      rename_column(:users, :nom    , :surname)
  end

  ##
  # Rollback changes
  #
  def down
    # rename fields && foreign keys
    # for the new Accounts table
    rename_column(:accounts, :origin_id, :origine_id)
      rename_column(:accounts, :company, :societe)
      rename_column(:accounts, :adress1, :adresse1)
      rename_column(:accounts, :adress2, :adresse2)
      rename_column(:accounts, :zip, :cp)
      rename_column(:accounts, :city, :ville)
      rename_column(:accounts, :country, :pays)
      rename_column(:accounts, :accounting_code, :code_compta)
      rename_column(:accounts,  :category, :genre)

    # for the new renamed accounts_tags table
    rename_column(:accounts_tags, :account_id, :compte_id)
    rename_column(:accounts_tags, :tag_id, :produit_id)

    # for the new renamed contacts_tags table
    rename_column(:contacts_tags, :tag_id, :produit_id)

    # for the Contacts table
    rename_column(:contacts, :account_id, :compte_id)
      rename_column(:contacts, :surname, :nom)
      rename_column(:contacts, :forename, :prenom)
      rename_column(:contacts, :title, :civilite)
      rename_column(:contacts, :job, :fonction)

    # for the new renamed Quotations tables
    rename_column(:quotations,  :ref_account, :ref_compte)
    rename_column(:quotations,  :account_id, :compte_id)
    rename_column(:quotations, :opportunity_id, :opportunite_id)
    rename_column(:quotations,  :quotation_template_id, :modele_id)
      rename_column(:quotations, :validity, :validite)
      rename_column(:quotations, :company, :societe)
      rename_column(:quotations, :adress1, :adresse1)
      rename_column(:quotations, :adress2, :adresse2)
      rename_column(:quotations, :zip, :cp)
      rename_column(:quotations, :city, :ville)
      rename_column(:quotations, :country, :pays)
      rename_column(:quotations, :surname, :nom)
      rename_column(:quotations, :forename, :prenom)
      rename_column(:quotations, :title, :civilite)
      rename_column(:quotations, :job, :fonction)
      # Totals
      rename_column(:quotations, :total_excl_tax_cents, :total_ht_cents)
      rename_column(:quotations, :total_excl_tax_currency, :total_ht_currency)
      rename_column(:quotations, :total_incl_tax_cents, :total_ttc_cents)
      rename_column(:quotations, :total_incl_tax_currency, :total_ttc_currency)
      # VAT
      rename_column(:quotations, :VAT_rate, :taux_tva)
      rename_column(:quotations, :total_VAT_cents, :total_tva_cents)
      rename_column(:quotations, :total_VAT_currency, :total_tva_currency)
      # File
      rename_column(:quotations, :attach_file_name, :fichier_joint_file_name)
      rename_column(:quotations, :attach_content_type, :fichier_joint_content_type)
      rename_column(:quotations, :attach_file_size, :fichier_joint_file_size)
      rename_column(:quotations, :attach_updated_at, :fichier_joint_updated_at)

    # for the Documents table
    rename_column(:documents, :account_id, :compte_id)
      rename_column(:documents, :name, :nom)
      rename_column(:documents, :attach_file_name, :fichier_joint_file_name)
      rename_column(:documents, :attach_content_type, :fichier_joint_content_type)
      rename_column(:documents, :attach_file_size, :fichier_joint_file_size)
      rename_column(:documents, :attach_updated_at, :fichier_joint_updated_at)

    # for the new renamed Events table (ex: evenements)
    rename_column(:events, :account_id, :compte_id)
    rename_column(:events, :task_id, :tache_id)
    rename_column(:events, :event_type_id, :type_id)
      rename_column(:events, :date_begin, :debut)
      rename_column(:events, :date_end, :fin)
      #rename_column(:events, :modified_by, :updated_by)
      rename_column(:events, :attach_file_name, :fichier_joint_file_name)
      rename_column(:events, :attach_content_type, :fichier_joint_content_type)
      rename_column(:events, :attach_file_size, :fichier_joint_file_size)
      rename_column(:events, :attach_updated_at, :fichier_joint_updated_at)

    # for the new renamed quotationLines table (ex: item)
    rename_column(:quotation_lines, :quotation_id, :devi_id)
      # Price and Total
      rename_column(:quotation_lines, :price_excl_tax_cents, :prix_ht_cents)
      rename_column(:quotation_lines, :price_excl_tax_currency, :prix_ht_currency)
      rename_column(:quotation_lines, :total_excl_tax_cents, :total_ht_cents)
      rename_column(:quotation_lines, :total_excl_tax_currency, :total_ht_currency)
      rename_column(:quotation_lines, :quantity, :quantite)

    # for the new renamed Templates table (ex: modeles)
      rename_column(:quotation_templates, :company, :societe)
      rename_column(:quotation_templates, :adress, :adresse)
      rename_column(:quotation_templates, :zip, :cp)
      rename_column(:quotation_templates, :city, :ville)
      rename_column(:quotation_templates, :country, :pays)
      rename_column(:quotation_templates, :vat, :tva)
      rename_column(:quotation_templates, :company_registration_number, :siret)
      rename_column(:quotation_templates, :web, :site)
      rename_column(:quotation_templates, :attach_file_name, :fichier_joint_file_name)
      rename_column(:quotation_templates, :attach_content_type, :fichier_joint_content_type)
      rename_column(:quotation_templates, :attach_file_size, :fichier_joint_file_size)
      rename_column(:quotation_templates, :attach_updated_at, :fichier_joint_updated_at)

    # for the new renamed Opportunities table (ex: opportunites)
    rename_column(:opportunities, :account_id, :compte_id)
      rename_column(:opportunities, :term, :echeance)
      rename_column(:opportunities, :remark, :remarque)
      rename_column(:opportunities, :name, :nom)
      rename_column(:opportunities, :amount, :montant) # hesite avec total
      rename_column(:opportunities, :profit, :marge)
      rename_column(:opportunities, :attach_file_name, :fichier_joint_file_name)
      rename_column(:opportunities, :attach_content_type, :fichier_joint_content_type)
      rename_column(:opportunities, :attach_file_size, :fichier_joint_file_size)
      rename_column(:opportunities, :attach_updated_at, :fichier_joint_updated_at)

    # for the new renamed Origins table (ex: Origines)
      rename_column(:origins, :name, :nom)

    # for the new renamed Tags table (ex: Produits)
      rename_column(:tags, :name, :nom)

    # for the Relations table
    rename_column(:relations, :account1_id, :compte1_id)
    rename_column(:relations, :account2_id, :compte2_id) # Double relation ou pas ?
      rename_column(:relations, :name, :nom)

    # for the new Tasks table (ex: tache)
    rename_column(:tasks, :account_id, :compte_id)
      rename_column(:tasks, :term, :echeance)
      rename_column(:tasks, :attach_file_name, :fichier_joint_file_name)
      rename_column(:tasks, :attach_content_type, :fichier_joint_content_type)
      rename_column(:tasks, :attach_file_size, :fichier_joint_file_size)
      rename_column(:tasks, :attach_updated_at, :fichier_joint_updated_at)

    # for the new renamed EventTypes table (ex: Types)
      rename_column(:event_types, :label, :libelle)

    # for the table Users
      rename_column(:users, :forename,  :prenom)
      rename_column(:users, :surname,   :nom)
    # rename all tables with the new French name
    rename_table(:quotation_lines, :items)
    rename_table(:quotations, :devis)
    rename_table(:opportunities, :opportunites)
    rename_table(:origins, :origines)
    rename_table(:tags, :produits)
    rename_table(:tasks, :taches)
    rename_table(:event_types, :types)
    rename_table(:events, :evenements)
    rename_table(:accounts, :comptes)
    rename_table(:quotation_templates, :modeles)
    rename_table(:accounts_tags, :comptes_produits)
    rename_table(:contacts_tags, :contacts_produits)
  end

end
