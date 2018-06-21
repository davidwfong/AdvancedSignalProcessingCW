%Record at high sampling rate
fs_high = 44100;
N = 1000;
samples = 1:1:N;
secondsforN = N/fs_high;
% Record e
recObj_e = audiorecorder(fs_high, 16, 1);
disp('Start e')
recordblocking(recObj_e, secondsforN*30);
disp('End of e recording.');
e_sound = getaudiodata(recObj_e);
e_sound = e_sound((15*N)+1:(16*N));
figure
plot(samples,e_sound);
title('1000 samples of "e" sound waveform sampled at 44.1kHz')
% Record a
recObj_a = audiorecorder(fs_high, 16, 1);
disp('Start a')
recordblocking(recObj_a, secondsforN*30);
disp('End of a recording.');
a_sound = getaudiodata(recObj_a);
a_sound = a_sound((15*N)+1:(16*N));
figure
plot(samples,a_sound);
title('1000 samples of "a" sound waveform sampled at 44.1kHz')
% Record s
recObj_s = audiorecorder(fs_high, 16, 1);
disp('Start s')
recordblocking(recObj_s, secondsforN*30);
disp('End of s recording.');
s_sound = getaudiodata(recObj_s);
s_sound = s_sound((15*N)+1:(16*N));
figure
plot(samples,s_sound);
title('1000 samples of "s" sound waveform sampled at 44.1kHz')
% Record t
recObj_t = audiorecorder(fs_high, 16, 1);
disp('Start t')
recordblocking(recObj_t, secondsforN*30);
disp('End of t recording.');
t_sound = getaudiodata(recObj_t);
t_sound = t_sound((15*N)+1:(16*N));
figure
plot(samples,t_sound);
title('1000 samples of "t" sound waveform sampled at 44.1kHz')
% Record x
recObj_x = audiorecorder(fs_high, 16, 1);
disp('Start x')
recordblocking(recObj_x, secondsforN*30);
disp('End of x recording.');
x_sound = getaudiodata(recObj_x);
x_sound = x_sound((15*N)+1:(16*N));
figure
plot(samples,x_sound);
title('1000 samples of "x" sound waveform sampled at 44.1kHz')

ARorder = [2 1 5];
mu = [0.01 0.001 0.1];
% Analyse predictor for adaptation gain 1 = 0.01
[xhat_Emu1, e_Emu1, aevol_Emu1] = predar2(e_sound, mu(1), ARorder(1));
[xhat_Emu2, e_Emu2, aevol_Emu2] = predar2(e_sound, mu(2), ARorder(1));
[xhat_Emu3, e_Emu3, aevol_Emu3] = predar2(e_sound, mu(3), ARorder(1));
[xhat_Ear2, e_Ear2, aevol_Ear2] = predar2(e_sound, mu(1), ARorder(1));
[xhat_Ear1, e_Ear1, aevol_Ear1] = predar1(e_sound, mu(1), ARorder(2));
[xhat_Ear5, e_Ear5, aevol_Ear5] = predar5(e_sound, mu(1), ARorder(3));

[xhat_Amu1, e_Amu1, aevol_Amu1] = predar2(a_sound, mu(1), ARorder(1));
[xhat_Amu2, e_Amu2, aevol_Amu2] = predar2(a_sound, mu(2), ARorder(1));
[xhat_Amu3, e_Amu3, aevol_Amu3] = predar2(a_sound, mu(3), ARorder(1));
[xhat_Aar2, e_Aar2, aevol_Aar2] = predar2(a_sound, mu(1), ARorder(1));
[xhat_Aar1, e_Aar1, aevol_Aar1] = predar1(a_sound, mu(1), ARorder(2));
[xhat_Aar5, e_Aar5, aevol_Aar5] = predar5(a_sound, mu(1), ARorder(3));

[xhat_Smu1, e_Smu1, aevol_Smu1] = predar2(s_sound, mu(1), ARorder(1));
[xhat_Smu2, e_Smu2, aevol_Smu2] = predar2(s_sound, mu(2), ARorder(1));
[xhat_Smu3, e_Smu3, aevol_Smu3] = predar2(s_sound, mu(3), ARorder(1));
[xhat_Sar2, e_Sar2, aevol_Sar2] = predar2(s_sound, mu(1), ARorder(1));
[xhat_Sar1, e_Sar1, aevol_Sar1] = predar1(s_sound, mu(1), ARorder(2));
[xhat_Sar5, e_Sar5, aevol_Sar5] = predar5(s_sound, mu(1), ARorder(3));

[xhat_Tmu1, e_Tmu1, aevol_Tmu1] = predar2(t_sound, mu(1), ARorder(1));
[xhat_Tmu2, e_Tmu2, aevol_Tmu2] = predar2(t_sound, mu(2), ARorder(1));
[xhat_Tmu3, e_Tmu3, aevol_Tmu3] = predar2(t_sound, mu(3), ARorder(1));
[xhat_Tar2, e_Tar2, aevol_Tar2] = predar2(t_sound, mu(1), ARorder(1));
[xhat_Tar1, e_Tar1, aevol_Tar1] = predar1(t_sound, mu(1), ARorder(2));
[xhat_Tar5, e_Tar5, aevol_Tar5] = predar5(t_sound, mu(1), ARorder(3));

[xhat_Xmu1, e_Xmu1, aevol_Xmu1] = predar2(x_sound, mu(1), ARorder(1));
[xhat_Xmu2, e_Xmu2, aevol_Xmu2] = predar2(x_sound, mu(2), ARorder(1));
[xhat_Xmu3, e_Xmu3, aevol_Xmu3] = predar2(x_sound, mu(3), ARorder(1));
[xhat_Xar2, e_Xar2, aevol_Xar2] = predar2(x_sound, mu(1), ARorder(1));
[xhat_Xar1, e_Xar1, aevol_Xar1] = predar1(x_sound, mu(1), ARorder(2));
[xhat_Xar5, e_Xar5, aevol_Xar5] = predar5(x_sound, mu(1), ARorder(3));

% Analyse evolution of a1 & a2 for "e" sound for different mu
figure
a1_Emu1 = aevol_Emu1(2,:);
a2_Emu1 = aevol_Emu1(3,:);
plot(samples, a1_Emu1)
hold on
plot(samples, a2_Emu1)
hold off
title('Evolution of coefficients of predictor for "e" sound with adaptation gain 0.01')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
figure
a1_Emu2 = aevol_Emu2(2,:);
a2_Emu2 = aevol_Emu2(3,:);
plot(samples, a1_Emu2)
hold on
plot(samples, a2_Emu2)
hold off
title('Evolution of coefficients of predictor for "e" sound with adaptation gain 0.001')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
figure
a1_Emu3 = aevol_Emu3(2,:);
a2_Emu3 = aevol_Emu3(3,:);
plot(samples, a1_Emu3)
hold on
plot(samples, a2_Emu3)
hold off
title('Evolution of coefficients of predictor for "e" sound with adaptation gain 0.1')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
% Analyse evolution of a1 & a2 for "e" sound for different model orders
figure
a1_Ear2 = aevol_Ear2(2,:);
a2_Ear2 = aevol_Ear2(3,:);
plot(samples, a1_Ear2)
hold on
plot(samples, a2_Ear2)
hold off
title('Evolution of coefficients of predictor for "e" sound with AR predictor order 2')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
figure
a1_Ear1 = aevol_Ear1(2,:);
plot(samples, a1_Ear1)
title('Evolution of coefficients of predictor for "e" sound with AR predictor order 1')
xlabel('Sample')
ylabel('Value')
legend('a1')
figure
a1_Ear5 = aevol_Ear5(2,:);
a2_Ear5 = aevol_Ear5(3,:);
a3_Ear5 = aevol_Ear5(4,:);
a4_Ear5 = aevol_Ear5(5,:);
a5_Ear5 = aevol_Ear5(6,:);
plot(samples, a1_Ear5)
hold on
plot(samples, a2_Ear5)
plot(samples, a3_Ear5)
plot(samples, a4_Ear5)
plot(samples, a5_Ear5)
hold off
title('Evolution of coefficients of predictor for "e" sound with AR predictor order 5')
xlabel('Sample')
ylabel('Value')
legend('a1','a2','a3','a4','a5')

% Analyse evolution of a1 & a2 for "a" sound for different mu
figure
a1_Amu1 = aevol_Amu1(2,:);
a2_Amu1 = aevol_Amu1(3,:);
plot(samples, a1_Amu1)
hold on
plot(samples, a2_Amu1)
hold off
title('Evolution of coefficients of predictor for "a" sound with adaptation gain 0.01')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
figure
a1_Amu2 = aevol_Amu2(2,:);
a2_Amu2 = aevol_Amu2(3,:);
plot(samples, a1_Amu2)
hold on
plot(samples, a2_Amu2)
hold off
title('Evolution of coefficients of predictor for "a" sound with adaptation gain 0.001')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
figure
a1_Amu3 = aevol_Amu3(2,:);
a2_Amu3 = aevol_Amu3(3,:);
plot(samples, a1_Amu3)
hold on
plot(samples, a2_Amu3)
hold off
title('Evolution of coefficients of predictor for "a" sound with adaptation gain 0.1')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
% Analyse evolution of a1 & a2 for "a" sound for different model orders
figure
a1_Aar2 = aevol_Aar2(2,:);
a2_Aar2 = aevol_Aar2(3,:);
plot(samples, a1_Aar2)
hold on
plot(samples, a2_Aar2)
hold off
title('Evolution of coefficients of predictor for "a" sound with AR predictor order 2')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
figure
a1_Aar1 = aevol_Aar1(2,:);
plot(samples, a1_Aar1)
title('Evolution of coefficients of predictor for "a" sound with AR predictor order 1')
xlabel('Sample')
ylabel('Value')
legend('a1')
figure
a1_Aar5 = aevol_Aar5(2,:);
a2_Aar5 = aevol_Aar5(3,:);
a3_Aar5 = aevol_Aar5(4,:);
a4_Aar5 = aevol_Aar5(5,:);
a5_Aar5 = aevol_Aar5(6,:);
plot(samples, a1_Aar5)
hold on
plot(samples, a2_Aar5)
plot(samples, a3_Aar5)
plot(samples, a4_Aar5)
plot(samples, a5_Aar5)
hold off
title('Evolution of coefficients of predictor for "a" sound with AR predictor order 5')
xlabel('Sample')
ylabel('Value')
legend('a1','a2','a3','a4','a5')

% Analyse evolution of a1 & a2 for "s" sound for different mu
figure
a1_Smu1 = aevol_Smu1(2,:);
a2_Smu1 = aevol_Smu1(3,:);
plot(samples, a1_Smu1)
hold on
plot(samples, a2_Smu1)
hold off
title('Evolution of coefficients of predictor for "s" sound with adaptation gain 0.01')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
figure
a1_Smu2 = aevol_Smu2(2,:);
a2_Smu2 = aevol_Smu2(3,:);
plot(samples, a1_Smu2)
hold on
plot(samples, a2_Smu2)
hold off
title('Evolution of coefficients of predictor for "s" sound with adaptation gain 0.001')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
figure
a1_Smu3 = aevol_Smu3(2,:);
a2_Smu3 = aevol_Smu3(3,:);
plot(samples, a1_Smu3)
hold on
plot(samples, a2_Smu3)
hold off
title('Evolution of coefficients of predictor for "s" sound with adaptation gain 0.1')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
% Analyse evolution of a1 & a2 for "s" sound for different model orders
figure
a1_Sar2 = aevol_Sar2(2,:);
a2_Sar2 = aevol_Sar2(3,:);
plot(samples, a1_Sar2)
hold on
plot(samples, a2_Sar2)
hold off
title('Evolution of coefficients of predictor for "s" sound with AR predictor order 2')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
figure
a1_Sar1 = aevol_Sar1(2,:);
plot(samples, a1_Sar1)
title('Evolution of coefficients of predictor for "s" sound with AR predictor order 1')
xlabel('Sample')
ylabel('Value')
legend('a1')
figure
a1_Sar5 = aevol_Sar5(2,:);
a2_Sar5 = aevol_Sar5(3,:);
a3_Sar5 = aevol_Sar5(4,:);
a4_Sar5 = aevol_Sar5(5,:);
a5_Sar5 = aevol_Sar5(6,:);
plot(samples, a1_Sar5)
hold on
plot(samples, a2_Sar5)
plot(samples, a3_Sar5)
plot(samples, a4_Sar5)
plot(samples, a5_Sar5)
hold off
title('Evolution of coefficients of predictor for "s" sound with AR predictor order 5')
xlabel('Sample')
ylabel('Value')
legend('a1','a2','a3','a4','a5')

% Analyse evolution of a1 & a2 for "t" sound for different mu
figure
a1_Tmu1 = aevol_Tmu1(2,:);
a2_Tmu1 = aevol_Tmu1(3,:);
plot(samples, a1_Tmu1)
hold on
plot(samples, a2_Tmu1)
hold off
title('Evolution of coefficients of predictor for "t" sound with adaptation gain 0.01')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
figure
a1_Tmu2 = aevol_Tmu2(2,:);
a2_Tmu2 = aevol_Tmu2(3,:);
plot(samples, a1_Tmu2)
hold on
plot(samples, a2_Tmu2)
hold off
title('Evolution of coefficients of predictor for "t" sound with adaptation gain 0.001')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
figure
a1_Tmu3 = aevol_Tmu3(2,:);
a2_Tmu3 = aevol_Tmu3(3,:);
plot(samples, a1_Tmu3)
hold on
plot(samples, a2_Tmu3)
hold off
title('Evolution of coefficients of predictor for "t" sound with adaptation gain 0.1')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
% Analyse evolution of a1 & a2 for "t" sound for different model orders
figure
a1_Tar2 = aevol_Tar2(2,:);
a2_Tar2 = aevol_Tar2(3,:);
plot(samples, a1_Tar2)
hold on
plot(samples, a2_Tar2)
hold off
title('Evolution of coefficients of predictor for "t" sound with AR predictor order 2')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
figure
a1_Tar1 = aevol_Tar1(2,:);
plot(samples, a1_Tar1)
title('Evolution of coefficients of predictor for "t" sound with AR predictor order 1')
xlabel('Sample')
ylabel('Value')
legend('a1')
figure
a1_Tar5 = aevol_Tar5(2,:);
a2_Tar5 = aevol_Tar5(3,:);
a3_Tar5 = aevol_Tar5(4,:);
a4_Tar5 = aevol_Tar5(5,:);
a5_Tar5 = aevol_Tar5(6,:);
plot(samples, a1_Tar5)
hold on
plot(samples, a2_Tar5)
plot(samples, a3_Tar5)
plot(samples, a4_Tar5)
plot(samples, a5_Tar5)
hold off
title('Evolution of coefficients of predictor for "t" sound with AR predictor order 5')
xlabel('Sample')
ylabel('Value')
legend('a1','a2','a3','a4','a5')

% Analyse evolution of a1 & a2 for "x" sound for different mu
figure
a1_Xmu1 = aevol_Xmu1(2,:);
a2_Xmu1 = aevol_Xmu1(3,:);
plot(samples, a1_Xmu1)
hold on
plot(samples, a2_Xmu1)
hold off
title('Evolution of coefficients of predictor for "x" sound with adaptation gain 0.01')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
figure
a1_Xmu2 = aevol_Xmu2(2,:);
a2_Xmu2 = aevol_Xmu2(3,:);
plot(samples, a1_Xmu2)
hold on
plot(samples, a2_Xmu2)
hold off
title('Evolution of coefficients of predictor for "x" sound with adaptation gain 0.001')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
figure
a1_Xmu3 = aevol_Xmu3(2,:);
a2_Xmu3 = aevol_Xmu3(3,:);
plot(samples, a1_Xmu3)
hold on
plot(samples, a2_Xmu3)
hold off
title('Evolution of coefficients of predictor for "x" sound with adaptation gain 0.1')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
% Analyse evolution of a1 & a2 for "x" sound for different model orders
figure
a1_Xar2 = aevol_Xar2(2,:);
a2_Xar2 = aevol_Xar2(3,:);
plot(samples, a1_Xar2)
hold on
plot(samples, a2_Xar2)
hold off
title('Evolution of coefficients of predictor for "x" sound with AR predictor order 2')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
figure
a1_Xar1 = aevol_Xar1(2,:);
plot(samples, a1_Xar1)
title('Evolution of coefficients of predictor for "x" sound with AR predictor order 1')
xlabel('Sample')
ylabel('Value')
legend('a1')
figure
a1_Xar5 = aevol_Xar5(2,:);
a2_Xar5 = aevol_Xar5(3,:);
a3_Xar5 = aevol_Xar5(4,:);
a4_Xar5 = aevol_Xar5(5,:);
a5_Xar5 = aevol_Xar5(6,:);
plot(samples, a1_Xar5)
hold on
plot(samples, a2_Xar5)
plot(samples, a3_Xar5)
plot(samples, a4_Xar5)
plot(samples, a5_Xar5)
hold off
title('Evolution of coefficients of predictor for "x" sound with AR predictor order 5')
xlabel('Sample')
ylabel('Value')
legend('a1','a2','a3','a4','a5')
