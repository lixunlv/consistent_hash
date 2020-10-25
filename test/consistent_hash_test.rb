#!usr/bin/ruby

require "consistent_hash"

def test
  (80..200).step(10) do |v_num|
    c = ConsistentHash.new(10, v_num)
    1000000.times do
      c.balance({})
    end

    puts "v_num: #{v_num} deviation:#{c.deviation} counts:#{c.counts}"
  end
end
