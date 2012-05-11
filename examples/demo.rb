
$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'yaml'
require 'nowa-api'


user = Nowa::Api::User.new('Behdv67nNBpZe8szhwTW')

ki = user.create_ki

ki.title = 'A new KI'
ki.tags = { 'industry' => %w{ power metal rock big small light heavy }, 'kittens' => %w{ fluffy small cute evil } }
ki.text = 'And some text about something'

ki.save

