class User < ApplicationRecord
    has_many :checking_accounts, dependent: :destroy

    has_secure_password

    validates :name, :last_name, :email, :cpf, presence: true
    validates :name, :last_name, format: { with: REGEX_LETRA }
    validates :email, uniqueness: { case_sensitive: false }, format: { with: REGEX_EMAIL }
    validates :cpf, uniqueness: true, format: { with: REGEX_CPF }
    validates :password, length: { is: 6 }

    enum role: { comum: 0, vip: 1, manager: 2 }
end
