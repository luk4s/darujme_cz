module DarujmeCz
  # @see https://www.darujme.cz/doc/api/v1/index.html#endpoint-get-organization-organizationid-transactions-by-filter
  class Transaction < Base

    def self.endpoint
      "transactions"
    end

    # @param [Hash] attributes
    def initialize(attributes)
      @id = attributes["transactionId"]
      super
    end

    def sent_amount
      @sent_amount ||= ::Money.new(*@source["sentAmount"].values)
    end

    def outgoing_amount
      @outgoing_amount ||= ::Money.new(*@source["outgoingAmount"].values)
    end

    def received_at
      @source["receivedAt"].to_time
    end

    def pledge
      @pledge ||= Pledge.new(@source["pledge"])
    end

    %w[outgoingVs outgoingBankAccount].each do |m|
      define_method m.underscore do
        @source[m]
      end
    end
  end
end