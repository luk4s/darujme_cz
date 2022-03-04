module DarujmeCz
  # @see https://www.darujme.cz/doc/api/v1/index.html#endpoint-get-organization-organizationid-pledges-by-filter
  class Pledge < Base
    delegate :name, :address, :city, :street, :post_code, :postal_code, :country, to: :donor

    def self.endpoint
      "pledges"
    end

    define_attributes %w[organizationId projectId promotionId paymentMethod]

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

    def donor
      @donor ||= Donor.new @source["donor"]
    end

    def transactions
      @transactions ||= Array(@source["transactions"]).collect do |transaction_source|
        Transaction.new(transaction_source)
      end
    end

    def project
      @project ||= Project.find project_id
    end
  end
end
