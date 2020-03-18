class Category < ActiveRecord::Base

  after_save :cache_to_redis
  before_destroy :flush_from_redis

  def cache_to_redis
    $redis_cache.hset(self.set_field, set_key, {id: self.id, name: self.name}.to_json)
  end

  def flush_from_redis
    $redis_cache.hdel(self.set_field, set_key)
  end

  def set_field
    self.class.to_s.pluralize.downcase
  end

  def set_key
    "#{self.class.to_s.singularize.downcase}_#{self.id}"
  end

  def get_from_redis
    JSON($redis_cache.hget(self.set_field, set_key))
  end

  has_many :articles

  def to_s
    name
  end
end
