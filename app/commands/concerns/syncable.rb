# frozen_string_literal: true

module Syncable
  extend ActiveSupport::Concern

  included do
    def validate_synchrony(category: :buy)
      if send(category) == current[category]
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
    end
  end
end
