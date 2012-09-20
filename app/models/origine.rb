class Origine < ActiveRecord::Base

	has_many :comptes
	paginates_per 10
end
