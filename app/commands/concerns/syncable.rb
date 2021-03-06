# frozen_string_literal: true

module Syncable
  extend ActiveSupport::Concern

  included do
    def validate_synchrony(category: :buy)
      return if upstream_equals_stored?(category)

      memoize_last category
      obj = new(
        category: categories[category],
        amount: current[category]
      )

      if obj.save
        publish_success(category)
      else
        context.fail!(message: 'Failed saving record.')
      end
    end

    def upstream_equals_stored?(category)
      send(category) == current[category]
    end

    def memoize_last(category)
      if category == :buy
        @last_buy = send(category)
      else
        @last_sell = send(category)
      end
    end

    def colonize(amount = nil)
      return 0 if amount.nil?

      amount / 100
    end
  end
end
