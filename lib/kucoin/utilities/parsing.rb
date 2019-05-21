module Kucoin
  module Utilities
    class Parsing
      
      class << self
        def convert_value(value, type, use_ms_for_time: true)
          if type.is_a?(Symbol)
            return case type
              when :string
                value.to_s
              when :symbol
                value.to_s.underscore.downcase.to_sym
              when :integer
                value.to_i
              when :float
                value.to_f
              when :decimal
                to_decimal(value)
              when :boolean
                ["true", "1"].include?(value.to_s.downcase)
              when :datetime
                DateTime.parse(value)
              when :time
                epoch_to_time(value, ms: use_ms_for_time)
              when :hash
                value.symbolize_keys
              when :json
                JSON.parse(value) unless value.to_s.empty?
              else
                value
            end
          elsif type.is_a?(Hash)
            return case type.keys.first
              when :enum
                type[:enum][value.to_i]
              else
                value
            end
          end
        end
      
        def time_to_epoch(time, ms: false)
          ms ? (time.to_i * 1_000) : time.to_i
        end
      
        def epoch_to_time(epoch, ms: false)
          ms ? ::Time.at(epoch.to_i / 1_000).utc : ::Time.at(epoch.to_i).utc
        end
      
        def numeric?(string)
          !!Kernel.Float(string) 
        rescue TypeError, ArgumentError
          false
        end
      
        def to_decimal(number)
          if number
            num = number.to_s
            num.empty? ? nil : BigDecimal.new(num)
          else
            nil
          end
        end

        def divide(number, divisor)
          result = number / divisor
          result.nan? || result.infinite? ? 0 : result
        end
          
      end
      
    end    
  end
end
