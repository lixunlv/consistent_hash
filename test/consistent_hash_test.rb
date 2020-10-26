#!usr/bin/ruby

require 'benchmark'
require "../lib/ConsistentHash.rb"

def test
  (0..300).step(30) do |v_num|
    c = ConsistentHash.new(10, v_num)
    time = Benchmark.realtime do
      1000000.times do
        c.balance({})
      end
    end

    puts "use time:#{time.round(2)}s v_num: #{[v_num, 1].max} deviation:#{c.deviation} counts:#{c.counts}"
  end
end

test
