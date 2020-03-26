function f = findIndex(vec,sub) 
%znajdowanie indeksu, dla kt�rego warto�� zapisana w vec jest najbli�sza
%warto�ci sub
diff = abs(vec(1) - sub);
index = 1;

for i = 2:length(vec)
   if (diff > abs(vec(i) - sub))
       diff = abs(vec(i) - sub);
       index = i;
   end
end

f = index;