class Trial < ApplicationRecord
    validates :name, presence: true, length: { minimum: 2 }
    validates :short_description, presence: true, length: { minimum: 10 }
    validates :long_description, presence: true, length: { minimum: 10 }
    validates :logo_url, presence: true, length: { minimum: 10 }

end
