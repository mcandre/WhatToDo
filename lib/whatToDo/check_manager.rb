require 'pathname'

module WhatToDo
  class CheckManager
    def initialize(facets = [])
      @checks = []
      @facets = facets

      # Require all check scripts
      dir = Pathname.new(File.dirname(__FILE__) + '/check').cleanpath
      Dir["#{dir}/*.rb"].each do |file|
        instance_eval(File.open(File.expand_path(file)).read)
      end
    end

    def check(facets = [], &block)
      if (x & y).any?
        @checks << block
      end
    end

    def run_checks(count)
      results = []

      @checks.each do |check|
        result = instance_eval(&check)

        unless result == nil || result == false
          results << result
          break if results.length >= count
        end
      end

      results
    end
  end
end
