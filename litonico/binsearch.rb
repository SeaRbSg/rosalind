input = File.read "rosalind_bins.txt"

rows = input.split("\n")
haystack = rows[2].split(" ").map(&:to_i)
needles = rows[3].split(" ").map(&:to_i)

out = []
needles.each do |needle|

  start = 0
  last = haystack.length-1

  loop do
    middle = (last+start)/2

    if start > last
      out << -1
      break
    end

    if needle < haystack[middle]
      last = middle - 1
    elsif needle > haystack[middle]
      start = middle + 1
    elsif needle == haystack[middle]
      # TODO(lito): Walk backwards
      out << middle+1
      break
    end
  end

end

puts out.join(" ")
