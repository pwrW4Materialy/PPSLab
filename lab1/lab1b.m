clear;
fp = 1000;
N = 2000;
t = 0 : 1/fp : (N-1)/fp;

x = 2*sin(2*pi*250*t) + sin(2*pi*100*t) + 4*chirp(t,50,(N-1)/fp, 150);

figure(1);
subplot(3,2,1);
plot(t,x);
xlabel('czas [s]');
ylabel('x(t)');

%transformata Fouriera
Nf = 2^11;
v = fft(x,Nf);
w = abs(v);
N21 = Nf/2+1; % połowa przedziału 
f = linspace(0,fp/2,N21); %dzieli na części
subplot(3,2,2);
plot(f,w(1:N21)); %wybieramy od 1 do połowy
xlabel('częst. [Hz]');
ylabel('|x(f)|');
% wykres transformaty zawsze jest symetryczny: powielenie widma np. f -> fp-f
% problem można rozwiązać zakładając prawidłowe f <= fp/2 lub fp >= 2f
% -> (rysujemy tylko połowę przedziału częst.) 
% problem wynika z konwersji analogowej -> cyfrowej sygnłów przed transf.
% transformata działa na zasadzie przybliżenia x = sigma(Li*xi)

%filtr dolno przepustowy (ogranicza częst.)
M = 201;
h = fir1(M-1,0.4); %problem brak add-ona ( współczynnik określa miejsce odcięcia )
th = 0 : 1/fp : (M-1)/fp;
subplot(3,2,3);
plot(th, h);
xlabel('czas [s]');
ylabel('h(t)');

Nfh = 2^10; %rząd transformaty
v = fft(h,Nfh);
wh = abs(v);
N21h = Nfh/2+1;
fh = linspace(0,fp/2,N21h);
subplot(3,2,4);
plot(fh, wh(1:N21h));
xlabel('częst. [Hz]');
ylabel('|H(f)|');

y = filter(h,1,x);
ty = 0 : 1/fp : (N-1)/fp;
subplot(3,2,5);
plot(ty,y);
xlabel('czas [s]');
ylabel('x(t)');

Nfy = 2^11;
v = fft(y,Nfy);
wy = abs(v);
N21y = Nfy/2+1;

fy = linspace(0,fp/2,N21y);
subplot(3,2,6);
plot(fy,wy(1,N21y));
xlabel('częst. [Hz]');
ylabel('|Y(f)|');

