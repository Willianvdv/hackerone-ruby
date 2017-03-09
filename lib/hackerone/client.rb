require "active_support/core_ext/hash"
require "graphql/client"
require "graphql/client/http"
require 'rubygems'
require 'httparty'

module Hackerone
  class HackyTokenFetcher
    # HackerOne doesn't support authentication tokens that don't expire. Therefore
    # we need to do this kinda ugly re-fetch a new token every 30min using the user's
    # logged in session. To make matters worse, this fetcher doesn't support 2FA.

    include HTTParty

    base_uri 'https://hackerone.com'

    debug_output if ENV['HACKERONE_DEBUG']

    def initialize(email, password)
      current_user_response = self.class.get(
        '/current_user',
        headers: {
          'accept' => 'application/json, text/javascript, */*; q=0.01',
          'x-requested-with' => 'XMLHttpRequest'
        }
      )

      response_cookie = parse_cookie(current_user_response)
      authenticity_token = current_user_response["csrf_token"]

      post_response = self.class.post(
        '/users/sign_in/',
        body: {
          authenticity_token: authenticity_token,
          user: { email: email, password: password }
        },
        headers: {'Cookie' => response_cookie.to_cookie_string }
      )

      @cookie = parse_cookie(post_response)
    end

    def token
      current_user_response = self.class.get(
        '/current_user',
        headers: {
          'accept' => 'application/json, text/javascript, */*; q=0.01',
          'x-requested-with' => 'XMLHttpRequest',
          'cookie' => @cookie.to_cookie_string,
        }
      )

      current_user_response['graphql_token']
    end

    private

    def parse_cookie(resp)
      cookie_hash = CookieHash.new
      resp.get_fields('set-cookie').each { |c| cookie_hash.add_cookies(c) }
      cookie_hash
    end
  end

  def self.credentials_given?
    ENV['HACKERONE_EMAIL'].present? && ENV['HACKERONE_PASSWORD'].present?
  end

  def self.token
    hackerone_email = ENV['HACKERONE_EMAIL']
    hackerone_password = ENV['HACKERONE_PASSWORD']

    ::Hackerone::HackyTokenFetcher
      .new(hackerone_email, hackerone_password)
      .token
  end

  def self.symbolize_keys(hash)
    hash.keys.each do |key|
      hash[key.to_sym] = hash.delete(key)
    end

    hash
  end

  HTTP = GraphQL::Client::HTTP.new("https://hackerone.com/graphql") do
    def headers(_ctx)
      return {} unless Hackerone.credentials_given?

      { "X-Auth-Token" => Hackerone.token }
    end
  end

  Schema = GraphQL::Client.load_schema(HTTP)
  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
end
