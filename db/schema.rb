# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121224100356) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "comptes", :force => true do |t|
    t.string   "societe"
    t.string   "adresse1"
    t.string   "adresse2"
    t.string   "cp"
    t.string   "ville"
    t.string   "pays"
    t.string   "code_compta"
    t.text     "notes"
    t.string   "created_by"
    t.string   "modified_by"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.string   "genre"
    t.string   "tel"
    t.string   "fax"
    t.string   "email"
    t.string   "web"
    t.string   "origine_id"
  end

  create_table "comptes_produits", :id => false, :force => true do |t|
    t.integer "compte_id"
    t.integer "produit_id"
  end

  create_table "contacts", :force => true do |t|
    t.string   "nom"
    t.string   "prenom"
    t.string   "civilite"
    t.string   "tel"
    t.string   "fax"
    t.string   "mobile"
    t.string   "email"
    t.string   "fonction"
    t.text     "notes"
    t.string   "created_by"
    t.string   "modified_by"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "compte_id"
  end

  create_table "contacts_produits", :id => false, :force => true do |t|
    t.integer "contact_id"
    t.integer "produit_id"
  end

  create_table "devis", :force => true do |t|
    t.string   "ref"
    t.datetime "date"
    t.string   "statut"
    t.string   "ref_compte"
    t.string   "mode_reg"
    t.integer  "validite"
    t.boolean  "done"
    t.string   "fichier_joint_file_name"
    t.string   "fichier_joint_content_type"
    t.integer  "fichier_joint_file_size"
    t.datetime "fichier_joint_updated_at"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.integer  "compte_id"
    t.integer  "contact_id"
    t.integer  "user_id"
    t.integer  "opportunite_id"
    t.integer  "modele_id"
    t.integer  "total_ht_cents",             :default => 0,     :null => false
    t.string   "total_ht_currency",          :default => "USD", :null => false
    t.integer  "total_ttc_cents",            :default => 0,     :null => false
    t.string   "total_ttc_currency",         :default => "USD", :null => false
    t.string   "societe"
    t.string   "adresse1"
    t.string   "adresse2"
    t.string   "cp"
    t.string   "ville"
    t.string   "pays"
    t.string   "nom"
    t.string   "prenom"
    t.string   "civilite"
    t.string   "fonction"
    t.decimal  "taux_tva"
    t.integer  "total_tva_cents",            :default => 0,     :null => false
    t.string   "total_tva_currency",         :default => "USD", :null => false
  end

  create_table "documents", :force => true do |t|
    t.string   "nom"
    t.text     "notes"
    t.string   "fichier_joint_file_name"
    t.string   "fichier_joint_content_type"
    t.integer  "fichier_joint_file_size"
    t.datetime "fichier_joint_updated_at"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "compte_id"
  end

  create_table "evenements", :force => true do |t|
    t.datetime "debut"
    t.datetime "fin"
    t.text     "notes"
    t.string   "created_by"
    t.string   "modified_by"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "contact_id"
    t.integer  "compte_id"
    t.integer  "type_id"
    t.integer  "user_id"
    t.string   "fichier_joint_file_name"
    t.string   "fichier_joint_content_type"
    t.integer  "fichier_joint_file_size"
    t.datetime "fichier_joint_updated_at"
    t.integer  "tache_id"
    t.text     "notes2"
  end

  create_table "items", :force => true do |t|
    t.string   "ref"
    t.text     "designation"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "devi_id"
    t.integer  "prix_ht_cents",     :default => 0,     :null => false
    t.string   "prix_ht_currency",  :default => "USD", :null => false
    t.integer  "total_ht_cents",    :default => 0,     :null => false
    t.string   "total_ht_currency", :default => "USD", :null => false
    t.decimal  "quantite"
  end

  create_table "modeles", :force => true do |t|
    t.string   "societe"
    t.string   "adresse"
    t.string   "ville"
    t.integer  "cp"
    t.string   "pays"
    t.string   "tel"
    t.string   "fax"
    t.string   "site"
    t.string   "email"
    t.string   "capital"
    t.string   "ape"
    t.string   "siret"
    t.string   "tva"
    t.string   "fichier_joint_file_name"
    t.string   "fichier_joint_content_type"
    t.integer  "fichier_joint_file_size"
    t.datetime "fichier_joint_updated_at"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "opportunites", :force => true do |t|
    t.string   "nom"
    t.text     "description"
    t.string   "statut"
    t.string   "remarque"
    t.float    "montant"
    t.datetime "echeance"
    t.string   "fichier_joint_file_name"
    t.string   "fichier_joint_content_type"
    t.integer  "fichier_joint_file_size"
    t.datetime "fichier_joint_updated_at"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "compte_id"
    t.integer  "contact_id"
    t.integer  "user_id"
    t.float    "marge"
  end

  create_table "origines", :force => true do |t|
    t.string   "nom"
    t.text     "description"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "produits", :force => true do |t|
    t.string   "nom"
    t.text     "description"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "relations", :force => true do |t|
    t.string   "nom"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "compte1_id"
    t.integer  "compte2_id"
  end

  create_table "taches", :force => true do |t|
    t.text     "notes"
    t.string   "statut"
    t.datetime "created_at",                 :null => false
    t.string   "created_by"
    t.datetime "modified_at"
    t.string   "modified_by"
    t.datetime "updated_at",                 :null => false
    t.integer  "contact_id"
    t.integer  "compte_id"
    t.integer  "user_id"
    t.string   "echeance"
    t.string   "fichier_joint_file_name"
    t.string   "fichier_joint_content_type"
    t.integer  "fichier_joint_file_size"
    t.datetime "fichier_joint_updated_at"
  end

  create_table "templates", :force => true do |t|
    t.string   "societe"
    t.string   "adresse"
    t.string   "ville"
    t.integer  "cp"
    t.string   "pays"
    t.string   "tel"
    t.string   "fax"
    t.string   "site"
    t.string   "email"
    t.string   "capital"
    t.string   "ape"
    t.string   "siret"
    t.string   "tva"
    t.string   "fichier_joint_file_name"
    t.string   "fichier_joint_content_type"
    t.integer  "fichier_joint_file_size"
    t.datetime "fichier_joint_updated_at"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "types", :force => true do |t|
    t.string   "libelle"
    t.string   "direction"
    t.string   "created_by"
    t.string   "modified_by"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "prenom"
    t.string   "nom"
    t.string   "tel"
    t.string   "mobile"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
