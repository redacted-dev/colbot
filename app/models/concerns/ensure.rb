# frozen_string_literal: true

module Ensure
  def ensure_context_includes(*params)
    params.each do |param|
      if context[param].nil?
        Rails.logger.error("#{self.class.name}# Missing #{param} parameter in context")
        context.fail!(message: 'Command failed')
      end
    end
  end

  def ensure_one(*params)
    if params.all? { |param| context[param].nil? }
      Rails.logger.error(
          "#{self.class.name}# Requires at least one of the following parameters: " \
        "#{params.join(',')} in the context"
      )
      context.fail!(message: 'Command failed')
    end
  end
end