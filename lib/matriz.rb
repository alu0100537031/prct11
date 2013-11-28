# == Fichero que contiene la gema para el trabajo con matrices.
# Operacion con matrices densas y dispersas.
# Autores: Rushil Lakhani Lakhani, Waldo Nazco Torres
# Github: alu0100537031@ull.edu.es, alu0100537185@ull.edu.es

#
# Para realizacion de esta practica se ha creado una jerarquia de clases. 
# Partiendo de la clase abstracta matriz, que es heredada por las clases hijas (Matriz Dispersa) y (Matriz Densa). En dichas clases hijas se 
# encuentran los metodos implementados que constituyen las operaciones basicas con matrices (+,-,*). 

# == Construcción de una gema.
#  Se pretende construir una gema que contenga los principales métodos para matrices densas y dispersas siguiendo la filosofía de la programación funcional.
#  Utilización de la gema Rdoc para generar documentación.


# === Clase Matriz
#
#   Es la clase base , consiste en una clase abstacta cuya funcion es que sea heredada por sus clases hijas (Matriz Dispersa y Matriz Densa)

class Matriz
  require "./lib/racional.rb"

  attr_reader :nfil, :ncol, :mat # metodos de acceso (getter)
  
  # metodo que inicializa la matriz 
  
  def initialize(nfil,ncol)  
    @nfil = nfil # inicializo numero de filas
    @ncol = ncol # inicializo numero de columnas 
  end
end

# ===Clase MatrizDensa
#
#   Es una clase hija de la clase base matriz ,en ella se implementan los principales métodos para operar con matrices.
#   Los métodos que forman dicha clase son :
#       to_s: Método que imprime por patalla la matriz como una cadena 
#       +(other): Metodo que permite sumar dos matrices y devuelve un objeto de tipo matriz densa.
#       -(other): Metodo que permite sumar dos matrices y devuelve un objeto de tipo matriz densa.
#       *(other): Permite multiplicar dos matrices y devuelve un objeto de tioo matriz densa.
#       max: Devuelve el mayor elemento de la matriz.
#       min :Devuelve el menor elemento de la matriz.


class MatrizDensa < Matriz
  
  attr_reader :mat # metodos de acceso (getter)
  
  def initialize(nfil,ncol,mat)
     super(nfil, ncol)
     @mat = Array.new(mat) #inicializo la matriz pasando como parametro un objeto de tipo matriz 
  end

#Funcion que devuelve una posicion i dentro de la matriz  
  
  def [](i)
    return mat[i]
  end

   
#Funcion que asigna un valor k a una posicion i,j dentro de la matriz
   
   def []=(i, j, k)
      return mat[i][j] = k
   end
  
# metodo que imprime por pantalla la matriz
  def to_s
     cad = " "
     nfil.times do |i| # nfil indica el numero de veces que se va a iterar 
      cad << " [ "
      ncol.times do |j| # ncol indica el numero de veces que se va a iterar
	cad <<  "#{mat[i][j]} "
      end
      cad << "]"
      cad << "\n "
    end
    return cad
  end 

  # metodo que suma dos matrices (Sobrecarga del operador +)
  
   def +(other)
      raise ArgumentError, "Las matrices no son cuadradas." unless @nfil == other.nfil && @ncol == other.ncol
      m = Array.new(@nfil){Array.new(@ncol){0}}
      nfil.times do |i|
	 ncol.times do |j|
             m[i][j] = self.mat[i][j]+ other.mat[i][j]
         end
      end
      return MatrizDensa.new(other.nfil,other.ncol,m) 
   end
   
    # metodo que resta dos matrices (Sobrecarga del operador -)
  
   def -(other)
      raise ArgumentError, "Las matrices no son cuadradas." unless @nfil == other.nfil && @ncol == other.ncol
      m = Array.new(@nfil){Array.new(@ncol){0}}
      nfil.times do |i|
	ncol.times do |j|
	     m[i][j] = mat[i][j]- other.mat[i][j]
         end
      end
      return MatrizDensa.new(other.nfil,other.ncol,m) 
   end

   # metodo que multiplica dos matrices (Sobrecarga del operador *)
   
   
  def *(other)
  # Han de coincidir el numero de columnas de una con el numero de filas de la otra
    raise ArgumentError , 'Las matrices no se pueden multiplicar debido a sus dimensiones (A.col == B.fil)' unless @ncol == other.nfil
    m = Array.new(@nfil){Array.new(@ncol){0}}
    nfil.times do |i|
      other.ncol.times do |j|
	ncol.times do |k|
          m[i][j] = m[i][j] + self.mat[i][k] * other.mat[k][j]
         end
      end
    end
    return MatrizDensa.new(self.nfil,other.ncol,m)  
  end

   # metodo que calcula el mayor elemento de la matriz
  
  def max
    max=mat[0][0] # Maximo toma como valor inicial el primer elemento de la matriz	
        0.upto(nfil-1) do |i|
	  @mat[i].inject(max) do |aux , j| # j recorre la matriz 
                     aux > j ? max : max = j
                     end
          end 				  	
    return max  
  end
  
  # metodo que calcula el menor elemento de la matriz      
  
  def min
      min=mat[0][0] # Minimo toma como valor inicial el primer elemento de la matriz
        0.upto(nfil-1) do |i|  
	 @mat[i].inject(min) do |aux , j| # j recorre la matriz 
                     aux < j ? min : min = j
                     end
          end  			  	 
      return min  
  end
end	  


      
# ===Clase MatrizDispersa
#
#   Es la otra clase hija de la clase base matriz ,en donde el 60 % de elementos de la matriz son nulos.
#   Para ello utilizamos un hash en donde almacenamos los elementos no nulos. Al igual que la matriz densa tambien
#   se implementan los principales métodos para operar con matrices.
#   Los métodos que forman dicha clase son :
#       to_s: Método que imprime por patalla el hash 
#       +(other): Metodo que permite sumar dos matrices y devuelve un objeto de tipo matriz densa o un objeto de tipo matriz dispersa.
#       -(other): Metodo que permite restar dos matrices y devuelve un objeto de tipo matriz densa o un objeto de tipo matriz dispersa..
#       *(other): Permite multiplicar dos matrices y devuelve un objeto de tipo matriz densa.
#       max: Devuelve el mayor elemento de la matriz.
#       min :Devuelve el menor elemento de la matriz.

class MatrizDispersa < Matriz
  
  attr_reader:hash , :mat
 
  # metodo que inicializa los valores de la matriz y almacena en un hash los elementos no nulos
  
  def initialize (nfil, ncol, mat)
    super(nfil, ncol)
    @mat = Array.new(mat)	
    nceros = 0 # numero de elementos nulos de la matriz (0)
    nelementos= (nfil * ncol)*0.6 # elementos de la matriz aplicado el 60 % 
    psincero = 0 # posiciones de los elementos de la matriz cuyo valor no es nulo (0)
    @hash = Hash.new(0)
    nfil.times do |i|
       ncol.times do |j|
           if (mat[i][j]==0)  
               nceros=nceros+1
            else
               psincero="[#{i}][#{j}]"
	       if (mat[i][j].is_a?Fraccion)
		 a = mat[i][j].num
		 b = mat[i][j].denom
	        @hash[psincero] = Rational(a,b)	
	       else 
		@hash[psincero] = mat[i][j]
	       end
            end
       end
    end
      if nceros >= nelementos # compruebo que la matriz sea dispersa 
	 #puts "La matriz es dispersa" 
      else
	 raise ArgumentError, 'La Matriz no es dispersa'
      end
 end
 
 # metodo que imprime por pantalla el hash
 
  def to_s
    hash.size.times do |i|
        if (hash.values[i] != nil)
          cad = ""
          cad << "#{hash}"
          return cad 
        else
          return 0
        end
      end
  end 

  # metodo que suma dos matrices (Sobrecarga del operador +)

  def +(other)
      
      case other
          when MatrizDensa
              other.+(self)
          when MatrizDispersa
	      raise ArgumentError, "Las matrices no son cuadradas." unless @nfil == other.nfil && @ncol == other.ncol 
	      suma = MatrizDispersa.new(nfil,ncol,0)
	      suma = hash.merge(other.hash){|key,oldval,newval| oldval+newval }
	      return suma # devuelve un objeto de tipo Matriz Dispersa
	   else
	      raise TypeError, "La matriz no es dispersa ni densa" unless other.instance_of? MatrizDispersa
       end
      
      
  end
  
  # metodo que resta dos matrices (Sobrecarga del operador -)
  
   def -(other)
       case other
          when MatrizDensa
              other.-(self)
          when MatrizDispersa
	      raise ArgumentError, "Las matrices no son cuadradas." unless @nfil == other.nfil && @ncol == other.ncol
	      resta = MatrizDispersa.new(nfil,ncol,0)
	      resta = hash.merge(other.hash){|key,oldval,newval| oldval-newval}
	      return resta # devuelve un objeto de tipo Matriz Dispersa
	   else
	       raise TypeError, "La matriz no es dispersa ni densa " unless other.instance_of? MatrizDispersa
       end
      
  end
  
 # metodo que calcula el producto de dos matrices (Sobrecarga del operador *) 
  
   def *(other)
     case other
      when MatrizDensa
         other.*(self)
      when MatrizDispersa
	 sum=0;
         elemento = Hash.new {}
         mult=0
         self.nfil.times do |i|
            other.ncol.times do |j|
            acumulado = 0
            self.ncol.times do |k|
               if ((self.hash.key?("[#{i}][#{k}]")) && (other.hash.key?("[#{k}][#{j}]"))) # compruebas si las posiciones de las claves tienen algun valor no nulo
                        mult= self.hash["[#{i}][#{k}]"] * other.hash["[#{k}][#{j}]"]
               else
         #sumarle 0 al acumulado
                 if (self.hash.key?("[#{i}][#{k}]") == false ) #  si la clave del primer elemento a sumar tiene valor nulo 
                  mult=0
                 else
		 if (self.hash.key?("[#{k}][#{j}]") == false ) # si la clave del segundo elemento a sumar tiene valor nulo
                  mult=0
                 end
		 end
         end
         acumulado = acumulado +mult
            end
         pos="[#{i}][#{j}]"
         if (acumulado!=0)
         elemento[pos] = acumulado #se queda con el ultimo valor
         else
         end
         end
      end
      return(elemento)
      else
	  raise TypeError, "La matriz no es dispersa ni densa " unless other.instance_of? MatrizDispersa
      end
   end   
 
 # metodo que calcula el mayor elemento de la matriz
  
  def max
    max = hash.values[0] # max toma el primer valor del hash
    hash.collect do |clave,valor| # collect recorre cada elemento y devuelve un array con los resultados del bloque
	  if (valor > max)
	     max=valor
          end
    end
   return max 
   end
   
   
   
 # metodo que calcula el menor elemento de la matriz
   
  def min
    min = hash.values[0] # min toma el primer valor del hash	
    hash.map do |clave,valor| # map recorre cada elemento y devuelve un array con los resultados del bloque
	  if (valor < min)
	    min=valor 
          end
    end
   return min
  end
end

frac1 = Fraccion.new(5,3)
frac2 = Fraccion.new(4,9)
m1 = MatrizDensa.new(3,3,[[1,2,0],[3,4,0],[0,2,3]])
m2 = MatrizDensa.new(3,3,[[7,10,5],[15,22,3],[2,3,4]])
m3 = MatrizDensa.new(3,3,[[frac1,frac2,frac1],[frac1,frac2,frac1],[frac2,frac2,frac1]])
m4 = MatrizDispersa.new(3,3,[[0,0,10],[5,0,0],[0,0,40]])
m5 = MatrizDispersa.new(3,3,[[0,0,4],[3,0,0],[0,0,2]])
m6 = MatrizDispersa.new(3,3,[[0,0,frac1],[frac2,0,0],[0,0,frac1]])
#puts 4-frac2 # Tiene que estar implementado el coerce para que funcione
#puts frac2-4
#puts 1+frac2
#puts m1.to_s
#puts m3.to_s
#puts m4.to_s
#puts m5.to_s
#puts m6.to_s
#print 
=begin
puts " Matrices Densas "
puts "     M1   "
puts m1.to_s
puts "     M2   "
puts m2.to_s
puts "     M3   "
puts m3.to_s
puts " (M1+M3)"
puts m1+m3
puts " (M1-M3)"
puts m1-m3
puts " (M1*M3)"
puts m1*m3
puts " Matrices Dispersas "
puts "     M4   "
m4.to_s
puts "     M5   "
m5.to_s
puts
puts " (M4+M5)"
puts m4+m5 # Matriz Dispersa - Matriz Dispersa = Matriz Dispersa
puts
puts " (M4-M5)"
puts m4-m5 # Matriz Dispersa + Matriz Dispersa = Matriz Dispersa
puts " El valor maximo de la matriz M2(densa) es  #{m2.max}"
puts " El valor minimo de la matriz M2(densa) es  #{m2.min}"
puts " El valor maximo de la matriz M4(dispersa) es  #{m4.max}"
puts " El valor minimo de la matriz M4(dispersa) es  #{m4.min}"
=end






  


  
 

  

    
  

  
  
 
  

  
 
