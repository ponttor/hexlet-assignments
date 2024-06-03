# frozen_string_literal: true

# BEGIN
require 'forwardable'
require 'uri'

class Url
  include Comparable
  extend Forwardable

  attr_reader :url

  def_delegators :url, :scheme, :host, :to_s, :port

  def initialize(url)
    @url = URI(url)
  end

  def query_params
    return {} if url.query.nil?
    url.query.split('&').each_with_object({}) do |i, acc|
      key, value = i.split('=')
      acc[key.to_sym] = value
    end
  end

  def query_param(key, default = nil)
    query_params.fetch(key, default)
  end

  def ==(other)
    return false unless other.is_a?(Url)
    [scheme, host, url.path, port, normalized_query] == [other.scheme, other.host, other.url.path, other.port, other.normalized_query]
  end

  protected

  def normalized_query
    query_params.sort.to_h
  end
end

# END
