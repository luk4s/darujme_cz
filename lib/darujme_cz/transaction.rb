module DarujmeCz
  # @see https://www.darujme.cz/doc/api/v1/index.html#endpoint-get-organization-organizationid-transactions-by-filter
  class Transaction < Base

    def self.endpoint
      "transactions"
    end

    delegate :name, :address, :city, :street, :postal_code, :country, to: :donor

    # @param [Hash] attributes
    def initialize(attributes)
      @id = attributes["transactionId"]
      super
    end

    def sent_amount
      @sent_amount ||= ::Money.new(*@source["sentAmount"].values) if @source["sentAmount"]
    end

    def outgoing_amount
      @outgoing_amount ||= ::Money.new(*@source["outgoingAmount"].values) if @source["outgoingAmount"]
    end

    def received_at
      @source["receivedAt"]&.to_time
    end

    def pledge
      @pledge ||= Pledge.new(@source["pledge"])
    end

    def donor
      @donor ||= pledge.donor
    end

    def status
      @source["state"]
    end

    %w[pending pending_confirmation pending_update success success_money_on_account sent_to_organization failure error refund timeout canceled].each do |state|
      define_method "#{state}?" do
        status == state
      end
    end

    %w[outgoingVs outgoingBankAccount].each do |m|
      define_method m.underscore do
        @source[m]
      end
    end
  end
end