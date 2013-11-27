require "./lib/gcd.rb"
class Fraccion
  
   include Comparable # Se incluye el modulo de nombre "comparable" utilizado para el operador <=>.
  
  attr_reader :num, :denom # metodos de acceso (getter)
  
  def initialize(num,denom)
   
    # Se encarga de comprobar que los datos sean numericos, si no lo son lanza una excepcion y sale del programa  
    
    raise ArgumentError, 'El argumento no es numerico' unless num.is_a? Numeric 
    raise ArgumentError, 'El argumento no es numerico' unless denom.is_a? Numeric 
    if (denom == 0)
	raise ArgumentError, 'El argumento no puede valer 0' unless (denom !=0)
    end 
    aux = gcd(num,denom) 
    @num = num/aux # numerador en su forma simplificada
    @denom= denom/aux # denominador en su forma simplificada 
  end
  

  
  # metodo que muestra la fraccion con formato de salida: a/b
  
   def to_s 
	"#{@num}/#{@denom}"
    end


  # metodo que calcula la suma de dos fracciones
  
  def +(other)
    if other.is_a? Fraccion     
      if (@denom == other.denom)   #si los denominadores son iguales
         Fraccion.new(@num + other.num, @denom)
      else  #si los denominadores son distintos
        aux3 = ((@denom/gcd(@denom,other.denom)) * other.denom) # Calculo del mcm usando la propiedad (a*b/mcd(a,b))
	aux = ((aux3/@denom) * @num) # calculo del numerador de la primera fraccion
	aux2 = ((aux3/other.denom) * other.num) # calculo del denominador de la segunda fraccion        
	Fraccion.new((aux+aux2),aux3)
      end
    else
      tmp = Fraccion.new(other,1)
      if (@denom == tmp.denom)   #si los denominadores son iguales
         Fraccion.new(@num + other.num, @denom)
      else  #si los denominadores son distintos
        aux3 = ((@denom/gcd(@denom,tmp.denom)) * tmp.denom) # Calculo del mcm usando la propiedad (a*b/mcd(a,b))
	aux = ((aux3/@denom) * @num) # calculo del numerador de la primera fraccion
	aux2 = ((aux3/tmp.denom) * tmp.num) # calculo del denominador de la segunda fraccion        
	Fraccion.new((aux+aux2),aux3)
      end
    end
  end  
   
   # metodo que calcula la resta de dos fracciones
   
    def -(other)
    if other.is_a? Fraccion     
      if (@denom == other.denom)   #si los denominadores son iguales
         Fraccion.new(@num - other.num, @denom)
      else  # si los denominadores son distintos
        aux3 = ((@denom/gcd(@denom,other.denom)) * other.denom) # Calculo del mcm usando la propiedad (a*b/mcd(a,b))
	aux = ((aux3/@denom) * @num) # calculo del numerador de la primera fraccion
	aux2 = ((aux3/other.denom) * other.num) # calculo del denominador de la segunda fraccion        
	Fraccion.new((aux-aux2),aux3)
      end
    else
      tmp = Fraccion.new(other,1)
      if (@denom == tmp.denom)   #si los denominadores son iguales
         Fraccion.new(@num + other.num, @denom)
      else  #si los denominadores son distintos
        aux3 = ((@denom/gcd(@denom,tmp.denom)) * tmp.denom) # Calculo del mcm usando la propiedad (a*b/mcd(a,b))
	aux = ((aux3/@denom) * @num) # calculo del numerador de la primera fraccion
	aux2 = ((aux3/tmp.denom) * tmp.num) # calculo del denominador de la segunda fraccion        
	Fraccion.new((aux-aux2),aux3)
      end
    end  
   end
   
   # metodo que calcula el producto de dos fracciones
   
   def *(other)
	Fraccion.new(@num*other.num,@denom*other.denom)
   end
   
    # metodo que calcula la division de dos fracciones
   
   def /(other)
	Fraccion.new(@num*other.denom,@denom*other.num)
   end
   
   # método que contempla el uso del modulo comparable <, >, <= y >=
  
  def <=>(other)
     return nil unless other.instance_of? Fraccion
     # self.to_f <=> other.to_f
     @num.to_f/@denom <=> other.num.to_f/other.denom
  end
 
  def coerce(other)
       [Fraccion.new(other,1),self]
  end
  
end

=begin  
   def coerce(other)
       return [self,other]
  end
=end


   


