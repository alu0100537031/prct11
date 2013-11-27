# Clase Base Matriz
class Matriz
  require "./lib/racional.rb"

  attr_reader :nfil, :ncol, :mat # metodos de acceso (getter)
  
  # metodo que inicializa la matriz 
  
  def initialize(nfil,ncol)  
    @nfil = nfil # inicializo numero de filas
    @ncol = ncol # inicializo numero de columnas 
  end
end



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
  

  def to_s
     cad = " "
    for i in 0...nfil
      cad << " [ "
      for j in 0...ncol
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
      for i in 0...nfil 
         for j in 0...ncol
             m[i][j] = self.mat[i][j]+ other.mat[i][j]
         end
      end
      return MatrizDensa.new(other.nfil,other.ncol,m) 
   end
   
    # metodo que resta dos matrices (Sobrecarga del operador -)
  
   def -(other)
      raise ArgumentError, "Las matrices no son cuadradas." unless @nfil == other.nfil && @ncol == other.ncol
      m = Array.new(@nfil){Array.new(@ncol){0}}
      for i in 0...nfil 
         for j in 0...ncol
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
    for i in 0...nfil do
      for j in 0...other.ncol do  
        for k in 0...ncol do
          m[i][j] = m[i][j] + self.mat[i][k] * other.mat[k][j]
         end
      end
    end
    return MatrizDensa.new(self.nfil,other.ncol,m)  
  end
  
  def max
    max=mat[0][0] # Maximo toma como valor inicial el primer elemento de la matriz	
      for i in 0...nfil do   
         for j in 0...ncol do
            if mat[i][j] > max
               max=mat[i][j]
            end
          end
      end			  	
    return max  
  end
  
      
  
  def min
      min=mat[0][0] # Minimo toma como valor inicial el primer elemento de la matriz
      for i in 0...nfil do   
         for j in 0...ncol do
            if mat[i][j] < min
               min=mat[i][j]
            end
          end
      end			  	 
      return min  
  end
end	  


      


class MatrizDispersa < Matriz
  
  attr_reader:hash , :mat
  
  def initialize (nfil, ncol, mat)
    super(nfil, ncol)
    @mat = Array.new(mat)	
    nceros = 0 # numero de elementos nulos de la matriz (0)
    nelementos= (nfil * ncol)*0.6 # elementos de la matriz aplicado el 60 % 
    psincero = 0 # posiciones de los elementos de la matriz cuyo valor no es nulo (0)
    @hash = Hash.new(0)
    for i in 0...nfil do
       for j in 0...ncol do
           if (mat[i][j]==0)  
               nceros=nceros+1
            else
               psincero="[#{i}][#{j}]"
	       if (mat[i][j].is_a?Fraccion)
		 a = mat[i][j].num
		 b = mat[i][j].denom
	        @hash[psincero] = Rational(a,b)
		#cad = " " 
		#cad << "#{a}"
		#cad << "/"
		#cad << "#{b}" 
		#@hash[psincero] = cad		
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
 
  def to_s
    if (hash.values != nil)
      cad = ""
      cad << "#{hash}"
      return cad 
    else
      return 0
    end 
    #return hash
  end 

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
  
  def max
    max = hash.values[0] # max toma el primer valor del hash
    hash.each do |clave,valor|
	  if (valor > max)
	     max=valor
          end
    end
   return max 
   end
  
  def min
    min = hash.values[0] # min toma el primer valor del hash	
    hash.each do |clave,valor|
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
#puts " El valor maximo de la matriz M4(dispersa) es  #{m4.max}"




  


  
 

  

    
  

  
  
 
  

  
 
