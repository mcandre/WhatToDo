module WhatToDo
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
      @facets += facet if yield
    end
  end
end