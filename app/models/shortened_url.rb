class ShortenedUrl < ApplicationRecord
  SHORT_PATH_LENGTH = 4 # length 3 => 46,656 possibilities; length 4 => 1,679,616 possibilities
  belongs_to :user

  before_validation :normalize_target_url, if: lambda { |s| s.target_url_changed? }
  before_validation :generate_short_path, if: lambda { |s| s.short_path.blank? }
  validates :target_url, presence: { message: "already has a shortened url"}, format: URI::regexp(%w(http https)), uniqueness: true
  validates :short_path, presence: true, uniqueness: true
  validates :user, presence: true

  def self.lookup_target_url_by_short_path(short_path, base_url)
    shortened_url = find_by(short_path: normalized_short_path(short_path))
    shortened_url && shortened_url.target_url
  end

  def self.lookup_short_url_by_target_url(raw_target_url, base_url)
    shortened_url = find_by(target_url: normalized_target_url(raw_target_url))
    shortened_url && shortened_url.short_url(base_url)
  end

  def self.normalized_target_url(raw_target_url)
    target_url = (raw_target_url.presence || "").strip
    target_url = "http:" + target_url if target_url =~ /^\/\//
    target_url = "http://" + target_url if target_url.present? && !(target_url =~ /^[a-z]+\:\/\//)
    target_url
  end

  def self.normalized_short_path(short_path)
    (short_path.presence || "").strip
  end

  def short_url(base_url)
    short_url = (base_url.presence || "").strip
    short_url += "/" unless short_url =~ /\/$/
    short_url += short_path
    short_url
  end

  private

  def normalize_target_url
    self.target_url = ShortenedUrl.normalized_target_url(target_url)
    true
  end

  def generate_short_path
    200.times do
      self.short_path = (('a'..'z').to_a + ('0'..'9').to_a).sample(SHORT_PATH_LENGTH).join
      break unless ShortenedUrl.exists?(short_path: short_path)
    end
    raise RuntimeError("could not create unique short url") if short_path.blank? # if 200 consecutive failures means something is wrong
    true
  end
end
