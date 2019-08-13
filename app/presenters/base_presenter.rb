# frozen_string_literal: true

class BasePresenter
  attr_accessor :object

  def initialize(object)
    @object = object
  end

  def self.present(object, context = {})
    new(object).present(context)
  end
end
