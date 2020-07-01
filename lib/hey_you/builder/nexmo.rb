module HeyYou
  class Builder
    class Nexmo < Base
      attr_reader :text, :from, :is_unicode

      def build
        @text = ch_data.fetch('text')
        @from = ch_data.fetch('from', nil)
        @is_unicode = ch_data.fetch('is_unicode', false)
      rescue KeyError => e
        fail MissingRequiredParameter, e
      end

      class MissingRequiredParameter < StandardError; end
    end
  end
end