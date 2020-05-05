//Signal carre TP1
//Déclarations

clf();
T0 = 1;
Te = 0.0005;
M = 10000;
A = 1;
temps = Te * (0:1:M-1);
signal = A*[pmodulo(temps,T0)<=T0/2];
nbr_harmonique = 15;

//Affichage graphique

plot(0,-1,10,2,temps,signal,'r');
xgrid;
xlabel('temps');
ylabel('signal');

//Calcul de a0
a0=(1/T0)*Te*sum(signal(1:T0/Te));
//Calcul de an,bn
an=zeros(1,nbr_harmonique);
bn=zeros(1,nbr_harmonique);
for k=1:nbr_harmonique
    an(k)=2*(1/T0)*Te*sum(signal(1:T0/Te) .* cos(2*%pi*temps(1:T0/Te)*k/T0));
    bn(k)=2*(1/T0)*Te*sum(signal(1:T0/Te) .* sin(2*%pi*temps(1:T0/Te)*k/T0));
end;

//Calcul théorique
an_reel=zeros(1,nbr_harmonique);
bn_reel=zeros(1,nbr_harmonique);
for k=[1,3,5,7]
    bn_reel(k)=(2*A)/(%pi*k);
end;

//Affichage des differences entre an et bn

clf();
index=(1:1:nbr_harmonique);
set(gca(),"auto_clear","off")
plot(0.7,-0.1,7.3,3.5,index,bn,'ro');
plot(0.7,-0.1,7.3,3.5,index,bn_reel,'bo')
set(gca(),"auto_clear","on");

//calcul de pn

fn = zeros(1:nbr_harmonique);
pn = sqrt(an^2 + bn^2)
for k=1:nbr_harmonique
    fn(k)=k/T0;
end;
clf();
plot(fn,pn,"r");
xgrid;
xlabel('fréquences');
ylabel('pn');

//Calcul des cn

cn = zeros(1:2*nbr_harmonique+1);
for k=1:2*nbr_harmonique+1
    cn(k)=(1/T0)*Te*sum(signal(1:T0/Te) .* exp(-2*%pi*%i*(k-nbr_harmonique)*temps(1:T0/Te)/T0));
end;

cn_autre = zeros(1:7);
for k=1:nbr_harmonique
    cn_autre(k)=1/2*(an(k)-(%i)*bn(k));
end

//affichage du delta des cn

//clf();
//index=(1:1:7);
//set(gca(),"auto_clear","off")
//plot(0.7,-0.1,7.3,3.5,index,real(cn),'ro');
//plot(0.7,-0.1,7.3,3.5,index,real(cn_autre),'bo');
//plot(0.7,-0.1,7.3,3.5,index,imag(cn),'ro');
//plot(0.7,-0.1,7.3,3.5,index,imag(cn_autre),'bo');
//set(gca(),"auto_clear","on");

//Calcul des nouveaux signaux
clf();
signal_cos_sin = a0 + zeros(0:1:M-1);
for k=1:nbr_harmonique
    plot(0,-1,5,2,temps,signal_cos_sin,'b');
    xgrid;
    xlabel('Temps');
    ylabel('Signal');
    input("Appuyez sur une touche pour continuer");
    clf();
    signal_cos_sin = signal_cos_sin + an(k)*cos(2*%pi*k*temps/T0) + bn(k)*sin(2*%pi*k*temps/T0);
end;
clf();
signal_expo = zeros(0:1:M-1);
for k=1:2*nbr_harmonique+1
    plot(0,-1,5,2,temps,signal_expo,'b');
    xgrid;
    xlabel('Temps');
    ylabel('Signal');
    input("Appuyez sur une touche pour continuer");
    clf();
    signal_expo = signal_expo + cn(k)*exp(%i*(k-nbr_harmonique)*2*%pi*temps/T0);
end;
