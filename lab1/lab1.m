%sin
fp = 1000;
N = 2000;
t = 0 : 1/fp : (N-1)/fp;

A = 2;
f = 2.5;
f0 = 0.2;
x = A*sin(2*pi*f*t + f0);

figure(1);
subplot(2,2,1); %dzieli okno wykresu, wymienne hold on
plot(t,x);
xlabel('czas [s]');
ylabel('x(t)');

%hold on; %pozwala rysować więcej niż jeden wykres

%sinusoida o zmiennej częst.
subplot(2,2,2);
y = chirp(t,2,(N-1)/fp,10); 
plot(t,y,'r'); %kolejne wywołanie wymazuje bez hold on/off
xlabel('czas [s]');
ylabel('x(t)');

z1 = rand(1, 2000); %rozkład bliski jednolitego losowych
subplot(2,2,3);
plot(t,z1,'g');
xlabel('czas [s]');
ylabel('z1(t)');

z2 = randn(1, 2000); %rozkład naturalny losowych
subplot(2,2,4);
plot(t,z2,'k');
xlabel('czas [s]');
ylabel('z2(t)');

%hold off;

%bez średnika na końcu -> wyświetla w konsoli
mean(z1) %średnia
var(z1) %wariancja

mean(z2)
var(z2)
