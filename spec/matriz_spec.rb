require "./lib/matriz.rb"
#require "matriz.rb"	

        describe Matriz do
                before :each do
                        @m1 = Matriz.new(3,3)
			 @m1densa =  MatrizDensa.new(3,3,[[1,2,0],[3,4,0],[0,2,3]])
                        @m2densa =  MatrizDensa.new(3,3,[[7,10,5],[15,22,3],[2,3,4]])
			 frac1 = Fraccion.new(1,3)
			 frac2 = Fraccion.new(1,4)
                        @m3densa = MatrizDensa.new(3,3,[[frac1,frac2,frac1],[frac1,frac2,frac1],[frac2,frac2,frac1]])
			 @m4dispersa = MatrizDispersa.new(3,3,[[0,0,3],[5,0,0],[0,0,2]])
			 @m5dispersa = MatrizDispersa.new(3,3,[[0,0,4],[3,0,0],[0,0,2]])
			 @m6dispersa = MatrizDispersa.new(3,3,[[0,0,frac1],[frac2,0,0],[0,0,frac1]])
                end
               
		describe "Se comprueba el numero de:" do
                        it "filas de la matriz" do
                                @m1.nfil.should eq(3)  
                        end
                        it "columnas de la matriz" do
                                @m1.ncol.should eq(3)  
                        end
                end
                                    
       
		
		describe "se debe comprobar si la " do
                  it " matriz es densa" do
                        (@m1densa.instance_of? MatrizDensa).should be_true 
                  end
		   it "matriz dispersa" do
                        (@m6dispersa.instance_of? MatrizDispersa).should be_true
		   end
		end   
        
  
		
                describe "se debe comprobar si la matriz ;" do
                        it " densa accede al subindice [0,0]" do
                                @m1densa.mat[0][0].should eq(1)
                        end
                        it "densa accede al subindice [0,1]" do
                                @m1densa.mat[0][1].should eq(2)
                        end
                        it "dispersa accede al subindice[1,0]" do
                                @m4dispersa.mat[1][0].should eq(5)
                        end
                        it "dispersa accede al subindice[2,2]" do
                                @m4dispersa.mat[2][2].should eq(2)
                        end
                end
		
		describe "se debe mostrar la " do
		  
		   it " matriz densa con enteros" do
                        @m2densa.to_s.should eq("  [ 7 10 5 ]\n  [ 15 22 3 ]\n  [ 2 3 4 ]\n ")
                  end
                  it " matriz densa con racionales" do
                        @m3densa.to_s.should eq("  [ 1/3 1/4 1/3 ]\n  [ 1/3 1/4 1/3 ]\n  [ 1/4 1/4 1/3 ]\n ")
                  end
		   it "matriz dispersa con enteros" do
                        @m4dispersa.to_s.should eq ("{\"[0][2]\"=>3, \"[1][0]\"=>5, \"[2][2]\"=>2}")
		   end
		   
		   it "matriz dispersa con racionales" do
                        @m6dispersa.to_s.should eq ("{\"[0][2]\"=>(1/3), \"[1][0]\"=>(1/4), \"[2][2]\"=>(1/3)}")
		   end
		   
		end  
		
		describe "se debe " do
		  
		   it " sumar dos matrices densas con enteros" do
		        sum = @m1densa+@m2densa
                        sum.to_s.should eq("  [ 8 12 5 ]\n  [ 18 26 3 ]\n  [ 2 5 7 ]\n ")
                  end
                  it " restar una matriz densa de enteros con otra matriz densa de racionales" do
		        res = @m1densa-@m3densa
                        res.to_s.should eq("  [ 2/3 7/4 -1/3 ]\n  [ 8/3 15/4 -1/3 ]\n  [ -1/4 7/4 8/3 ]\n ")
                  end
		  
		  it " multiplicar una matriz densa con otra matriz densa de racionales" do
		         mul = @m1densa*@m3densa
                        mul.to_s.should eq("  [ 1/1 3/4 1/1 ]\n  [ 7/3 7/4 7/3 ]\n  [ 17/12 5/4 5/3 ]\n ")
                  end
		  
		   it "calcular el maximo de una matriz Densa " do
			max = @m2densa.max
			max.should eq 22
		  end
   
		  it "calcular el minimo de una matriz Densa" do
			min = @m2densa.min
			min.should eq 2
		  end
		  
		 
	      end
		  

		 
		
		describe "se debe " do
		  
		   it " sumar dos matrices dispersas con enteros " do
		        sum = @m4dispersa+@m5dispersa
                        sum.to_s.should eq("{\"[0][2]\"=>7, \"[1][0]\"=>8, \"[2][2]\"=>4}")

                  end
		  
                  it " restar dos matrices dispersas con enteros " do
		        res = @m4dispersa-@m5dispersa
                        res.to_s.should eq("{\"[0][2]\"=>-1, \"[1][0]\"=>2, \"[2][2]\"=>0}")
                  end
		  
		   it " sumar una matriz dispersa de enteros con otra matriz dispersa de racionales" do
		        sum = @m4dispersa+@m6dispersa
                        sum.to_s.should eq("{\"[0][2]\"=>(10/3), \"[1][0]\"=>(21/4), \"[2][2]\"=>(7/3)}")
                  end
		  
		    it " restar una matriz dispersa de enteros con otra matriz dispersa de racionales" do
		        res = @m4dispersa-@m6dispersa
                        res.to_s.should eq("{\"[0][2]\"=>(8/3), \"[1][0]\"=>(19/4), \"[2][2]\"=>(5/3)}")
			
                  end
		  
		   it "calcular el maximo de una matriz Dispersa " do
		      max = @m4dispersa.max
		      max.should eq 5
		  end
   
		  it "calcular el minimo de una matriz Dispersa" do
		      min = @m4dispersa.min
		      min.should eq 2
		  end
		  
		
		  
		end  
		
		describe "se debe  " do
		  
		   it " sumar una matriz densa con una dispersa " do
		        sum = @m1densa+@m5dispersa
                        sum.to_s.should eq("  [ 1 2 4 ]\n  [ 6 4 0 ]\n  [ 0 2 5 ]\n ")


                  end
                  it " restar una matriz dispersa con una densa" do
		        res = @m5dispersa-@m1densa
                        res.to_s.should eq("  [ 1 2 -4 ]\n  [ 0 4 0 ]\n  [ 0 2 1 ]\n ")
                  end
		  
		end 
				
       end


             