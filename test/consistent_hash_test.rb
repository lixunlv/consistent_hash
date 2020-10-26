#!usr/bin/ruby

require 'benchmark'
require "../lib/ConsistentHash.rb"

def test
  (80..200).step(10) do |v_num|
    c = ConsistentHash.new(10, v_num)
    time = Benchmark.realtime do
      1000000.times do
        c.balance({})
      end
    end

    puts "use time:#{time.round(2)} v_num: #{v_num} deviation:#{c.deviation} counts:#{c.counts}"
  end
end

test
