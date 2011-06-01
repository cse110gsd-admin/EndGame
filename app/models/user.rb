class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,      :presence => true,
                        :length => { :minimum => 5 },  # Executive decision for minimum 5 
                        :length => { :maximum => 18 }, # Again arbitrary decision
                        :uniqueness => true
  #for uniqueness, optional "uniqueness => {:case_sensitive => ture/false } "
  validates :password,  :presence => true,
                        :confirmation => true,
                        :length => { :within => 6..40 } # minimum 5 char password.

  validates :email,     :presence => true,
                        :uniqueness => {:case_sensitive => false},
                        :format => { :with => email_regex } #checks that email is in email format
  
  has_many :entries,  :dependent => :destroy
  has_many :templates, :dependent => :destroy
  has_many :events, :dependent => :destroy
  
  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
