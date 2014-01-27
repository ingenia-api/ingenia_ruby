# Run all the examples

Dir.foreach('./') do |item|
  next if ['.', '..', 'console.rb'].include? item

  require("./#{item}")
end