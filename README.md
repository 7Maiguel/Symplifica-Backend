# Registro de usuarios

API de registro de usuarios desarrollada con Ruby on Rails 7.

## Ejecución

1. Una vez clonado el proyecto, con `bundle install` instalamos todas las dependencias del mismo.
2. Por último, con `rails s` podremos ejecutar el programa que, por defecto, será montado en el **puerto 3000**. Para cambiar el puerto, podemos usar `rails s -p [PORT]`.

## Testing

Luego de ejecutar `bundle install`, tendremos instalada la gema **RSpec** con la cual podremos correr los tests mediante el comando `rspec spec/requests/user_spec.rb -f d`.