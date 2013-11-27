Práctica de Laboratorio #9. Creacion De Una Gema
================

## Componentes Del Grupo:

- RUSHIL LAKHANI LAKHANI
- WALDO NAZCO TORRES


## GemaMatriz

Construcción de una gema ruby para la creación de matrices dispersas y densas,que heredan de la clase base Matriz 

##Descripción de la práctica.

La práctica consiste en crear una clase abstracta llamada Matriz, donde pondremos los distintos métodos abstractos de la clase  
Para ello partimos de la clase base Matriz cuya funcion va a ser que sea heredada por las clases hijas ,y creamos dos clases 
hijas que van a ser: clase Matriz Densa  ya implementada de la práctica anterior con las operaciones basicas 
correspondientes (+-*/)  y clase Matriz Dispersa cuya madre va a ser la clase base Matriz y donde se van a redifinir los metodos de 
la clase madre.

class  Matriz

  metodos abstractos
  
end

class MatrizDensa < Matriz

  metodos

end

class MatrizDispersa < Matriz

metodos

end

En dichas clases hijas se redefiniran los metodos para trabajar con el tipo de matrices indicado.
## Installation

Add this line to your application's Gemfile:

    gem 'GemaMatriz'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install GemaMatriz

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

---

Universidad de La Laguna  
Escuela Técnica Superior de Ingeniería Informática  
Lenguajes y Paradigmas de la Programación 2013-14

