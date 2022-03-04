module DarujmeCz
  class Address
    # @param [Hash] attributes
    def initialize(attributes)
      @source = attributes
    end

    def to_s
      "#{@source['street']}\n#{@source['postCode']} #{@source['city']}\n#{@source['country']}"
    end

    # alias
    def postal_code
      post_code
    end

    %w[street postCode city country].each do |m|
      define_method m.underscore do
        @source[m]
      end
    end
  end
end
