class Heap
  def self.heapify ary
    h = Heap.new
    h.data = ary

    # Bubble Up
    (h.data.length - 1).downto(0) do |i|
      

    end
  end

  def initialize
    @data       = []
    @next_index = 1
  end

  def swap i, j
    @data[i], @data[j] = @data[j], @data[i]
  end

  def sift_down
    i = 0

    # look at children 2i + 1 and 2i + 2
    # take the larger of the children, if it is less that @data[i] done
    # otherwise swap the larger child with the root and repeat
  end

  def insert x
    @data[@next_index] = x
    i = @next_index

    while i > 1 do
      break if @data[i/2] > x
      swap i, i/2
      i = i/ 2
    end
    @next_index += 1
  end

  def to_s
    @data.join(' ')
  end
end
