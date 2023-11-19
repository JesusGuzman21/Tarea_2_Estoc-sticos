using LinearAlgebra,Distributions,Plots

function f(x)
    n=7
    y=0
    for i=1:n-1
        y=y+100*(x[1,i+1]-x[1,i]^2)^2+(1-x[1,i])^2
    end
    return y
end

function Recocido_simulado(L)

    n=7;
    β=.27;
    A=0.05;
    B=2.95;


    x_act=rand(Uniform(A,B),1,n) #Random numbers

    T₊= β*abs(f(x_act)); #Temperatura inicial
    T₋=1*10^-20; #Temperatura final 
    #α= ; #Razón de cambio de la temperatura

    T=T₊ 
    dx=.5

    while T >=  T₋
        for j=1:L
            x_cand=x_act .+ rand(Uniform(-dx,dx))
            δ=f(x_cand)-f(x_act)
                if rand() < exp(-δ/T) || δ < 0
                    x_act=x_cand
                end
        end
        α=rand()
        dx=abs(rand()-.5)
        T=α*T
    end
    
 return x_act

end

m=300; #Número de iteraciones de Recocido simulado
L=2000; #Número de iteraciones para estar en ese nivel de temperatura 

function Plot_Recocido(m,L)

    n=7;
    b=zeros(m,n);

    for j=1:m
        for i=1:n
            a=Recocido_simulado(L)
            b[j,i]=a[1,i]
        end
    end

    b=b';

    c=scatter(b[1,:],label="x₁");
    d=scatter(b[2,:],label="x₂");
    e=scatter(b[3,:],label="x₃");
    g=scatter(b[4,:],label="x₄");
    h=scatter(b[5,:],label="x₅");
    i=scatter(b[6,:],label="x₆");
    j=scatter(b[7,:],label="x₇");

    x=[1 1 1 1 1 1 1]
    k=f(x)

    plot(c,d,e,g,h,i,j,plot_title="Mínimo=$k [m=$m L=$L]")

end

Plot_Recocido(m,L)
