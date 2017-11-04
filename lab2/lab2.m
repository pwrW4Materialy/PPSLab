clear;
[x,fpx] = wavread('/home/c/mbi04czep.wav');

N = length(x);
t = 0 : 1/fpx : (N-1)/fpx;

figure(1);
subplot(2,2,1);
plot(t,x);

%tranformata dla pliku wav
Nf = 2^nextpow2(fpx); 
N21 = Nf/2+1; %rząd transformaty
v = fft(x,Nf);
w = abs(v);
f = linspace(0,fpx/2,N21);
subplot(2,2,2);
plot(f,w(1:N21));
xlabel('częstotliwość[Hz]');
ylabel('|X(f)|');

%wybieramy co 3 próbkę
dr = 3;
Ny = floor(N/dr);
for i = 1 : Ny
    y(i) = x((i-1)*dr+1);
end
%wykres z co 3 próbki
fpy = fpx/dr;
ty = 0 : 1/fpy : (Ny-1)/fpy;
subplot(2,2,3);
plot(ty,y);
xlabel('częstotliwość[Hz]');
ylabel('y(t)');

%tranformata dla pliku wav z co 3 próbki
Nfy = 2^nextpow2(fpy); 
N21y = Nfy/2+1;
v = fft(y,Nfy);
wy = abs(v);
fy = linspace(0,fpy/2,N21y);
subplot(2,2,4);
plot(fy,wy(1:N21y));
xlabel('częstotliwość[Hz]');
ylabel('|Y(f)|');

%Korelacja
clear;

N = 1000;
fp = 1000;
t = 0 : 1/fp : (N-1)/fp;

figure(2);
x = sin(2*pi*23.6*t);
subplot(2,2,1);
plot(t,x);
xlabel('czas [s]');
ylabel('x(t)');

%losowa
y = randn(1,N);
subplot(2,2,2);
plot(t,y);
xlabel('czas [s]');
ylabel('y(t)');

%funkcja korelacji
kmax = 200; %na kole dobrać kmax tak by było widać korelację
rx = xcorr(x,x,kmax);
tx = -kmax/fp : 1/fp : kmax/fp;
subplot(2,2,3);
plot(tx,rx);
xlabel('opóźnienie [s]');
ylabel('autokorelacja x');

ry = xcorr(y,y,kmax);
subplot(2,2,4);
plot(tx,ry);
xlabel('opóźnienie [s]');
ylabel('autokorelacja x');

%histogram
figure(3);
nbins = 51;
hist(x,nbins);

%kolos
%dostajemy parametry, typy funkcji
%składamy kilka funkcji + losowy szum gaussa
%(sin, chip, rand, randn)
%koniecznie opisywać osie
%-policzyć transformate
%-policzyć korelację
%-filtracja, poda m, wyznaczyć próg odcięcia
%-zrobić histogram


return
