#************************************************************************
# Blending, "Mathematical Programming Modelling" (42112)
#************************************************************************

#************************************************************************
# Intro definitions
using JuMP
using Gurobi
using Printf

#************************************************************************


#************************************************************************


#************************************************************************
#                       MODEL
#************************************************************************


m = Model(GLPK.Optimizer)

n = 5 # no ingredients
b = 10 # max capacity
@variable(m, 0<= x[1:n] <=1)  # Relaxere (fjerner binary  constraint)
#@variable(m, x[1:n], Bin) 

@objective(m, Max, sum(p[i]*x[i] for i =1:n))
 
@constraint(m, sum(w[i]*x[i] for i=1:n) <=b)
#@constraint(m, x[3] ==1)
#@constraint(m, x[2] ==0)
#@constraint(m, x[4] ==0)


print(m)
optimize!(m)
println("Termination status: $(termination_status(m))")
if termination_status(m) == MOI.OPTIMAL
    println("Optimal objective value: $(objective_value(m))")
    for ci = 1:n # to

        println("x values: ",ci,"  ", value(x[ci]))
        # @printf "objective = %0.2f\n"  objective_value(shortest_path)

    end



else
    println("No optimal solution available")
end


