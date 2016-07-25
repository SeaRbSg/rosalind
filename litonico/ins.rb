input = File.read "rosalind_ins.txt"

rows = input.split "\n"
n = rows[0].to_i
arr = rows[1].split(" ").map(&:to_i)

num_swaps = 0

i = 1
while i < n do
  k = i

  tmp = arr[k]

  while k > 0 and arr[k] < arr[k-1] do
    num_swaps += 1

    arr[k] = arr[k-1]
    arr[k-1] = tmp
    k -= 1
  end

  i += 1
end

puts num_swaps
