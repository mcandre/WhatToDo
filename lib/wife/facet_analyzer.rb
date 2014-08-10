module Wife
  class FacetAnalyzer
    attr_reader :facets

    def initialize
      @facets = []

      # Require all facet scripts
      dir = Pathname.new(File.dirname(__FILE__) + '/facet').cleanpath
      Dir["#{dir}/*.rb"].each do |file|
        instance_eval(File.open(File.expand_path(file)).read)
      end
    end

    def facet(facets)
      unless facets.is_a?(Array)
        facets = [facets]
      end

      @facets += facets if yield
      @facets.flatten
    end
  end
end
