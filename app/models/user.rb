class User < ActiveRecord::Base
  rolify
  include RailsSettings::Extend

  attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable, :async,
         authentication_keys: [:login]

  validates :label, uniqueness: {case_sensitive: false}
  validates :label, :first_name, :last_name, presence: true
  validates_format_of :label, with: /\A[a-zA-Z][a-zA-Z0-9_]{2,12}\z/, on: :create

  has_one :contact
  has_many :attachments

  before_create :add_uid

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup

    login = conditions.delete(:login)
    if login
      where(conditions).where(['lower(label) = :value OR lower(email) = :value', {value: login.downcase}]).first
    else
      where(conditions).first
    end
  end


  def to_s
    "#{self.label}<#{self.email}>"
  end
  private
  def add_uid
    self.uid = SecureRandom.uuid
  end
end
