def gcd(u, v) # Calcula el mcd entre dos numeros
  u, v = u.abs, v.abs # Convierte los numeros a valor aboluto
  while v != 0
    u, v = v, u % v
  end
  u #r eturn(u) , el ultimo valor que se indica es el que devuelve
end


