module HeyYou
  class Builder
    class Nexmo < Base
      attr_reader :text, :from, :is_unicode
      LINE_BREAKS_BEFORE_AUTOFILL_HASH = 2

      def build
        @text = interpolate(ch_data.fetch('text'), options)
        if options[:google_autofill_code_hash]
          @text << "\n" * (options[:line_breaks_before_hash] || LINE_BREAKS_BEFORE_AUTOFILL_HASH)
          @text << "#{options[:google_autofill_code_hash]}"
        end
        @from = ch_data.fetch('from', nil)
        @is_unicode = ch_data.fetch('is_unicode', false)
      rescue KeyError => e
        fail MissingRequiredParameter, e
      end

      class MissingRequiredParameter < StandardError; end
    end
  end
end