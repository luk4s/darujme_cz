module DarujmeCz
  # @see https://www.darujme.cz/doc/api/v1/index.html#endpoint-get-project-projectid
  class Project < Base
    def self.endpoint
      "project"
    end

    def self.find(id)
      data = connection.get "project/#{id}"
      new data[endpoint]
    end

    # @param [Hash] attributes
    def initialize(attributes)
      @id = attributes["projectId"]
      super
    end

    def name(lang = "cs")
      get_localized_attribute "title", lang
    end

    def organization
      # TODO
    end

    def content(lang = "cs")
      get_localized_attribute "content", lang
    end

    def synopsis(lang = "cs")
      get_localized_attribute "synopsis", lang
    end

    private

    def get_localized_attribute(attribute, lang)
      value = @source[attribute]
      if value.is_a?(Hash)
        value[lang] || value.values.first
      else
        value
      end
    end
  end
end
# project_id = 1201275
# project_id = 1584
