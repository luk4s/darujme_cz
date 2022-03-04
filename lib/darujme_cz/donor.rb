module DarujmeCz
  class Donor
    delegate :city, :street, :post_code, :postal_code, :country, to: :address
    # @param [Hash] attributes
    def initialize(attributes)
      @source = attributes
    end

    def name
      "#{first_name} #{last_name}"
    end

    def address
      @address = Address.new(@source["address"]) if @source["address"]
    end

    %w[firstName lastName email phone].each do |m|
      define_method m.underscore do
        @source[m]
      end
    end
  end
end
