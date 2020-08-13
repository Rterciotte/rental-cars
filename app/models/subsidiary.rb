class Subsidiary < ApplicationRecord
    validates :name, :CNPJ, :Address, presence: true

    validates :name, uniqueness: { case_sensitive: false }
end
