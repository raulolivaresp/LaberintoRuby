require 'matrix'
class Laberinto
	attr_accessor :laberinto
	attr_accessor :travel_path
	attr_accessor :solution

	# Crear matrix
  	def initialize(laberinto = [])
    	@laberinto = laberinto
   		@travel_path = []
   		@solution = false
  	end

  	# Define si se puede mover a ese punto o no
	def can_move(i,j)
		#posición es 0
		if @laberinto[i,j] == 0
			#no se a pasado antes por ahi
			if @travel_path.count([i,j]) == 0
				return true
			else 
				return false
			end
		else
			return false
		end
	end

  	# Define los puntos colindantes donde se puede ir
	def paths(i,j)
		#decidir donde moverse
  		possible_path = []
	  	path = false
  		
  		#arriba
  		if i-1 > -1
			path = can_move(i-1,j)
  			if path == true
  				possible_path.push([i-1,j])
  			end
 		end
 		#abajo
		if i+1 < @laberinto.column_count
  			path = can_move(i+1,j)
			if path == true
				possible_path.push([i+1,j])
			end
		end  	
		#izquierda
		if j-1 > -1
			path = can_move(i,j-1)
  			if path == true
  				possible_path.push([i,j-1])
  			end
  		end  	
  		#derecha
	  	if j+1 < @laberinto.column_count
  			path = can_move(i,j+1)
  			if path == true
  				possible_path.push([i,j+1])
	  		end
  		end  	

  		return possible_path
	end

	# Tiene salida el laberinto ?
  	def exit(i,j)

  		if i == @laberinto.column_count-1 && j == @laberinto.column_count-1
  			@solution = true
  		else

  			#agregar punto a los puntos ya pasados
			@travel_path.push([i,j])

  			#lista posibles caminos
  			possible_path = paths(i,j)

			#siguiente punto o fin  				
			if possible_path.length == 0 
				#posicion sin camino pero junto a la salida 
			else
				#siguientes puntos del laberinto
	  			possible_path.each do |pts|
  					return exit(pts[0],pts[1])
  				end
			end
  		
  		end

  	end

#end class
end

if __FILE__ == $0
  la = Laberinto.new

  la.laberinto = Matrix[[0,0,0,0,0,1], [1,1,1,1,0,1], [0,0,0,0,0,1], [0,1,1,1,1,1], [0,0,0,0,1,1], [1,1,1,0,0,0]]
    
  la.exit(0,0) 

  if la.solution == true
	puts "El laberinto Si tiene solución"
  else
  	puts "El laberinto No tiene solución"
  end
end