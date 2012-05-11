
$: << './lib'

require 'yaml'
require 'nowa-api'


user = Nowa::Api::User.new('Behdv67nNBpZe8szhwTW')


ki = user.create_ki

ki.title = 'A new KI'
ki.tags = { 'industry' => %w{ power metal rock big small light heavy }, 'kittens' => %w{ fluffy small cute evil } }
ki.text = 'And some text about something'

ki.save

__END__

puts user.knowledge_items.to_yaml



#ki = user.find_ki 859

#puts ki.to_yaml
