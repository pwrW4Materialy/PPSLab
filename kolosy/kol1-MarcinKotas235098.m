N=20000;
fx=5000;
tx=0:1/fx:(N-1)/fx;

x= 5*sin(2*pi*200*tx)+7*sin(2*pi*450*tx)+8*chirp(tx,150,(N-1)/fx,350)+5*randn(1,N);

dr=4;
y=decimate(x,dr);
Ny=length(y);
fy=fx/dr;
ty=0:1/fy:(Ny-1)/fy;

figure(1);
subplot(2,2,1);
plot(tx,x);
xlabel('czas[s]');
ylabel('x(t)');

subplot(2,2,2);
Nf=2^nextpow2(fx);
v=fft(x,Nf);
w=abs(v);
N21=Nf/2+1;
tf=linspace(0,fx/2, N21);
plot(tf,w(1:N21));
xlabel('czestotliwosc [Hz]');
ylabel('fft(x)');

subplot(2,2,3);
plot(ty,y);
xlabel('czas[s]');
ylabel('y(t)');

subplot(2,2,4);
Nfy=2^nextpow2(fy);
vy=fft(y,Nfy);
wy=abs(vy);
N21y=Nfy/2+1;
tfy=linspace(0,fy/2, N21y);
plot(tfy,wy(1:N21y));
xlabel('czestotliwosc [Hz]');
ylabel('fft(y)');


figure(2);

M = 201;
hy = fir1(M-1,0.64);
thy = 0:1/fy:(M-1)/fy;

subplot(2,2,1);
plot(thy, hy);
xlabel('czas [s]');
ylabel('h(t)');

subplot(2,2,2);
vhy=fft(hy,Nfy);
why=abs(vhy);
tfhy=linspace(0,fy/2, N21y);
plot(tfy,why(1:N21y));
xlabel('czestotliwosc [Hz]');
ylabel('fft(h)');

subplot(2,2,3);
z = filter(hy,1,y);
plot(ty,z);
xlabel('czas[s]');
ylabel('z(t)');

subplot(2,2,4);
vz=fft(z,Nfy);
wvz=abs(vz);
tfvz=linspace(0,fy/2, N21y);
plot(tfvz,wvz(1:N21y));
xlabel('czestotliwosc [Hz]');
ylabel('fft(z)');


figure(3);

subplot(1,2,1);
kmax = 50;
az = xcorr(z,z,kmax);
taz = -kmax/fy:1/fy:kmax/fy;
plot(taz,az);
xlabel('czas [s]');
ylabel('autokorelacja z');

subplot(1,2,2);
nbins = 35;
hist(z,nbins);

