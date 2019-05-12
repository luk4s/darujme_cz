module DarujmeCz
  # @see https://www.darujme.cz/doc/api/v1/index.html#endpoint-get-organization-organizationid-pledges-by-filter
  class Pledge < Base

    def self.endpoint
      "pledges"
    end

    # @param [Hash] attributes
    def initialize(attributes)
      @id = attributes["pledgeId"]
      super
    end

    def recurrent?
      !!@source["isRecurrent"]
    end

    def want_donation_certificate?
      !!@source["wantDonationCertificate"]
    end

    # @return [Money]
    def amount
      @amount ||= ::Money.new(*@source["pledgedAmount"].values)
    end

    # @return [Time]
    def pledged_at
      @source["pledgedAt"].to_time
    end

    %w[organizationId projectId promotionId paymentMethod].each do |m|
      define_method m.underscore do
        @source[m]
      end
    end

    def donor
      @donor ||= Donor.new @source["donor"]
    end

    def transactions
      @transactions ||= Array(@source["transactions"]).collect do |transaction_source|
        Transaction.new(transaction_source)
      end
    end

  end
end