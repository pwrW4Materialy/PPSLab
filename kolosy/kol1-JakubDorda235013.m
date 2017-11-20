clear;
N = 10000;
fx = 12000;

t = 0 : 1/fx : (N-1)/fx;

x = 6*chirp(t, 150, (N-1)/fx, 400) + 10*chirp(t, 250, (N-1)/fx, 600) + 8*sin(2*pi*450*t) + 3*randn(1,N);

dr = 4;
y = decimate(x, dr);
Ny = length(y);
fy = fx/dr;
ty = 0 : 1/fy : (Ny-1)/fy;

figure(1);

%x(t)
subplot(2,2,1);
plot(t,x);
xlabel('czas [s]');
ylabel('x(t)');

%fft(x)
Nf = 2^nextpow2(fx);
v = fft(x, Nf);
w = abs(v);
N21 = Nf/2 + 1;
f = linspace(0, fx/2 ,N21);

subplot(2,2,2);
plot(f,w(1:N21));
xlabel('częstotliwości [Hz]');
ylabel('|x(f)|');

%y(t)
subplot(2,2,3);
plot(ty, y);
xlabel('czas [s]');
ylabel('y(t)');

%fft(y)
Nfy = 2^nextpow2(fy);
vy = fft(y, Nfy);
wy = abs(vy);
N21y = Nfy/2 + 1;
fyy = linspace(0, fy/2, N21y);

subplot(2,2,4);
plot(fyy, wy(1:N21y));
xlabel('częstotliwości [Hz]');
ylabel('|y(f)|');


figure(2);

%h(t)
M = 201;
h = fir1(M-1, 200/(fy/2));
th = 0 : 1/fy : (M-1)/fy;

subplot(2,2,1);
plot(th,h);
xlabel('czas [s]');
ylabel('h(t)');

%fft(h)
vh = fft(h, Nfy);
wh = abs(vh);

subplot(2,2,2);
plot(fyy, wh(1:N21y));
xlabel('częstotliwości [Hz]');
ylabel('|h(f)|');

%z(t)
z = filter(h,1,y);

subplot(2,2,3);
plot(ty, z);
xlabel('czas [s]');
ylabel('z(t)');

%fft(z)
vx = fft(z, Nfy);
wx = abs(vx);

subplot(2,2,4);
plot(fyy, wx(1:N21y));
xlabel('częstotliwości [Hz]');
ylabel('|z(f)|');


figure(3);

%autokorelacja z
kmax = 270;
k = xcorr(z,z,kmax);
kt = -kmax/fy : 1/fy : kmax/fy;

subplot(1,2,1);
plot(kt,k);
xlabel('czas [s]');
ylabel('autokorelacja z');

%histogram
nbins = 35;
subplot(1,2,2);
hist(z, nbins);













