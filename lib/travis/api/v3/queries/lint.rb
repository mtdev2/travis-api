require 'travis/yaml'

module Travis::API::V3
  class Queries::Lint < Query
    def lint
      request.body.rewind
      content  = params[:content] || request.body.read
      parsed   = Travis::Yaml.parse(content)
      warnings = parsed.nested_warnings.map { |k, m| { key: k, message: m } }
      { lint: { warnings: warnings } }.to_json
    end
  end
end