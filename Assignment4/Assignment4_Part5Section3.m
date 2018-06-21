% Record at low sampling rate
fs_low = 16000;
N = 1000;
samples = 1:1:N;
secondsforN = N/fs_low;
% Record e
recObj_e = audiorecorder(fs_low, 16, 1);
disp('Start e')
recordblocking(recObj_e, secondsforN*30);
disp('End of e recording.');
e_sound = getaudiodata(recObj_e);
e_sound = e_sound((15*N)+1:(16*N));
figure
plot(samples,e_sound);
title('1000 samples of "e" sound waveform sampled at 16kHz')
% Record a
recObj_a = audiorecorder(fs_low, 16, 1);
disp('Start a')
recordblocking(recObj_a, secondsforN*30);
disp('End of a recording.');
a_sound = getaudiodata(recObj_a);
a_sound = a_sound((15*N)+1:(16*N));
figure
plot(samples,a_sound);
title('1000 samples of "a" sound waveform sampled at 16kHz')
% Record s
recObj_s = audiorecorder(fs_low, 16, 1);
disp('Start s')
recordblocking(recObj_s, secondsforN*30);
disp('End of s recording.');
s_sound = getaudiodata(recObj_s);
s_sound = s_sound((15*N)+1:(16*N));
figure
plot(samples,s_sound);
title('1000 samples of "s" sound waveform sampled at 16kHz')
% Record t
recObj_t = audiorecorder(fs_low, 16, 1);
disp('Start t')
recordblocking(recObj_t, secondsforN*30);
disp('End of t recording.');
t_sound = getaudiodata(recObj_t);
t_sound = t_sound((15*N)+1:(16*N));
figure
plot(samples,t_sound);
title('1000 samples of "t" sound waveform sampled at 16kHz')
% Record x
recObj_x = audiorecorder(fs_low, 16, 1);
disp('Start x')
recordblocking(recObj_x, secondsforN*30);
disp('End of x recording.');
x_sound = getaudiodata(recObj_x);
x_sound = x_sound((15*N)+1:(16*N));
figure
plot(samples,x_sound);
title('1000 samples of "x" sound waveform sampled at 16kHz')

ARorder = [2 1 5];
mu = [0.01 0.001 0.1];
%Calculate prediction gain for "e" sound adaptation gains and model orders 
[xhat_Emu1, e_Emu1, aevol_Emu1] = predar2(e_sound, mu(1), ARorder(1));
[xhat_Emu2, e_Emu2, aevol_Emu2] = predar2(e_sound, mu(2), ARorder(1));
[xhat_Emu3, e_Emu3, aevol_Emu3] = predar2(e_sound, mu(3), ARorder(1));
[xhat_Ear2, e_Ear2, aevol_Ear2] = predar2(e_sound, mu(1), ARorder(1));
[xhat_Ear1, e_Ear1, aevol_Ear1] = predar1(e_sound, mu(1), ARorder(2));
[xhat_Ear5, e_Ear5, aevol_Ear5] = predar5(e_sound, mu(1), ARorder(3));
var_xE = (std(e_sound))^2;
var_eEmu1 = (std(e_Emu1))^2;
Rp_Emu1 = 10*log10(var_xE / var_eEmu1);
var_eEmu2 = (std(e_Emu2))^2;
Rp_Emu2 = 10*log10(var_xE / var_eEmu2);
var_eEmu3 = (std(e_Emu1))^2;
Rp_Emu3 = 10*log10(var_xE / var_eEmu3);
var_eEar2 = (std(e_Ear2))^2;
Rp_Ear2 = 10*log10(var_xE / var_eEar2);
var_eEar1 = (std(e_Ear1))^2;
Rp_Ear1 = 10*log10(var_xE / var_eEar1);
var_eEar5 = (std(e_Ear5))^2;
Rp_Ear5 = 10*log10(var_xE / var_eEar5);
%Calculate prediction gain for "a" sound adaptation gains and model orders 
[xhat_Amu1, e_Amu1, aevol_Amu1] = predar2(a_sound, mu(1), ARorder(1));
[xhat_Amu2, e_Amu2, aevol_Amu2] = predar2(a_sound, mu(2), ARorder(1));
[xhat_Amu3, e_Amu3, aevol_Amu3] = predar2(a_sound, mu(3), ARorder(1));
[xhat_Aar2, e_Aar2, aevol_Aar2] = predar2(a_sound, mu(1), ARorder(1));
[xhat_Aar1, e_Aar1, aevol_Aar1] = predar1(a_sound, mu(1), ARorder(2));
[xhat_Aar5, e_Aar5, aevol_Aar5] = predar5(a_sound, mu(1), ARorder(3));
var_xA = (std(a_sound))^2;
var_eAmu1 = (std(e_Amu1))^2;
Rp_Amu1 = 10*log10(var_xA / var_eAmu1);
var_eAmu2 = (std(e_Amu2))^2;
Rp_Amu2 = 10*log10(var_xA / var_eAmu2);
var_eAmu3 = (std(e_Amu1))^2;
Rp_Amu3 = 10*log10(var_xA / var_eAmu3);
var_eAar2 = (std(e_Aar2))^2;
Rp_Aar2 = 10*log10(var_xA / var_eAar2);
var_eAar1 = (std(e_Aar1))^2;
Rp_Aar1 = 10*log10(var_xA / var_eAar1);
var_eAar5 = (std(e_Aar5))^2;
Rp_Aar5 = 10*log10(var_xA / var_eAar5);
%Calculate prediction gain for "s" sound adaptation gains and model orders 
[xhat_Smu1, e_Smu1, aevol_Smu1] = predar2(s_sound, mu(1), ARorder(1));
[xhat_Smu2, e_Smu2, aevol_Smu2] = predar2(s_sound, mu(2), ARorder(1));
[xhat_Smu3, e_Smu3, aevol_Smu3] = predar2(s_sound, mu(3), ARorder(1));
[xhat_Sar2, e_Sar2, aevol_Sar2] = predar2(s_sound, mu(1), ARorder(1));
[xhat_Sar1, e_Sar1, aevol_Sar1] = predar1(s_sound, mu(1), ARorder(2));
[xhat_Sar5, e_Sar5, aevol_Sar5] = predar5(s_sound, mu(1), ARorder(3));
var_xS = (std(s_sound))^2;
var_eSmu1 = (std(e_Smu1))^2;
Rp_Smu1 = 10*log10(var_xS / var_eSmu1);
var_eSmu2 = (std(e_Smu2))^2;
Rp_Smu2 = 10*log10(var_xS / var_eSmu2);
var_eSmu3 = (std(e_Smu1))^2;
Rp_Smu3 = 10*log10(var_xS / var_eSmu3);
var_eSar2 = (std(e_Sar2))^2;
Rp_Sar2 = 10*log10(var_xS / var_eSar2);
var_eSar1 = (std(e_Sar1))^2;
Rp_Sar1 = 10*log10(var_xS / var_eSar1);
var_eSar5 = (std(e_Sar5))^2;
Rp_Sar5 = 10*log10(var_xS / var_eSar5);
%Calculate prediction gain for "t" sound adaptation gains and model orders 
[xhat_Tmu1, e_Tmu1, aevol_Tmu1] = predar2(t_sound, mu(1), ARorder(1));
[xhat_Tmu2, e_Tmu2, aevol_Tmu2] = predar2(t_sound, mu(2), ARorder(1));
[xhat_Tmu3, e_Tmu3, aevol_Tmu3] = predar2(t_sound, mu(3), ARorder(1));
[xhat_Tar2, e_Tar2, aevol_Tar2] = predar2(t_sound, mu(1), ARorder(1));
[xhat_Tar1, e_Tar1, aevol_Tar1] = predar1(t_sound, mu(1), ARorder(2));
[xhat_Tar5, e_Tar5, aevol_Tar5] = predar5(t_sound, mu(1), ARorder(3));
var_xT = (std(t_sound))^2;
var_eTmu1 = (std(e_Tmu1))^2;
Rp_Tmu1 = 10*log10(var_xT / var_eTmu1);
var_eTmu2 = (std(e_Tmu2))^2;
Rp_Tmu2 = 10*log10(var_xT / var_eTmu2);
var_eTmu3 = (std(e_Tmu1))^2;
Rp_Tmu3 = 10*log10(var_xT / var_eTmu3);
var_eTar2 = (std(e_Tar2))^2;
Rp_Tar2 = 10*log10(var_xT / var_eTar2);
var_eTar1 = (std(e_Tar1))^2;
Rp_Tar1 = 10*log10(var_xT / var_eTar1);
var_eTar5 = (std(e_Tar5))^2;
Rp_Tar5 = 10*log10(var_xT / var_eTar5);
%Calculate prediction gain for "x" sound adaptation gains and model orders 
[xhat_Xmu1, e_Xmu1, aevol_Xmu1] = predar2(x_sound, mu(1), ARorder(1));
[xhat_Xmu2, e_Xmu2, aevol_Xmu2] = predar2(x_sound, mu(2), ARorder(1));
[xhat_Xmu3, e_Xmu3, aevol_Xmu3] = predar2(x_sound, mu(3), ARorder(1));
[xhat_Xar2, e_Xar2, aevol_Xar2] = predar2(x_sound, mu(1), ARorder(1));
[xhat_Xar1, e_Xar1, aevol_Xar1] = predar1(x_sound, mu(1), ARorder(2));
[xhat_Xar5, e_Xar5, aevol_Xar5] = predar5(x_sound, mu(1), ARorder(3));
var_xX = (std(x_sound))^2;
var_eXmu1 = (std(e_Xmu1))^2;
Rp_Xmu1 = 10*log10(var_xX / var_eXmu1);
var_eXmu2 = (std(e_Xmu2))^2;
Rp_Xmu2 = 10*log10(var_xX / var_eXmu2);
var_eXmu3 = (std(e_Xmu1))^2;
Rp_Xmu3 = 10*log10(var_xX / var_eXmu3);
var_eXar2 = (std(e_Xar2))^2;
Rp_Xar2 = 10*log10(var_xX / var_eXar2);
var_eXar1 = (std(e_Xar1))^2;
Rp_Xar1 = 10*log10(var_xX / var_eXar1);
var_eXar5 = (std(e_Xar5))^2;
Rp_Xar5 = 10*log10(var_xX / var_eXar5);

