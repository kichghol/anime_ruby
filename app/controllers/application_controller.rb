class ApplicationController < ActionController::Base
  before_action :set_connected

  private

  def set_connected()
    @cache = ActiveSupport::Cache::MemoryStore.new() if @cache.nil?
    token = Rails.cache.read('currentToken')
    if token
      @connected=true
    else
      @connected=false
    end
  end


end
