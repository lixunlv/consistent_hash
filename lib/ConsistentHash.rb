class ConsistentHash
  @node_num
  @v_num
  @v_nodes
  @v_nodes_map
  @balance_count
  def initialize(node_num, v_num)
    @node_num = node_num
    @v_num = v_num
    @v_nodes = []
    @v_nodes_map = {}
    @balance_count = {}
    make_nodes
    @v_nodes.sort!
  end

  def make_nodes
    @node_num.times do |i|
      make_one_node(i)
    end
  end

  def make_one_node(i)
    @v_num.times do |j|
      begin
        hash_value = rand(2**32 - 1)
      end while @v_nodes_map[hash_value.to_s] != nil
      @v_nodes << hash_value
      @v_nodes_map[hash_value.to_s] = i
    end
  end

  def balance(item)
    hash_value = rand(2**32 - 1)
    v = @v_nodes.bsearch{|v| v > hash_value}
    v = @v_nodes[0] if v.nil?
    node_index = @v_nodes_map[v.to_s]

    @balance_count[node_index.to_s] ||= 0
    @balance_count[node_index.to_s] += 1
  end

  def counts
    @balance_count.values
  end

  def variance
    size = counts.size
    m = counts.sum / size
    sum = counts.inject(0){|accum, i| accum + (i - m) ** 2 }
    sum / size.to_f
  end

  def deviation
    Math.sqrt(variance)
  end

end
