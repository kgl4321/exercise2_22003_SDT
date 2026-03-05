function demo2(h_fig,no)
% DEMO2 second part of the demonstration of sampling effects
%
% syntax: demo2(h_fig,no)
%
% Show slide number no of the demonstration in figure h_fig.

% (c) of, 2003 Dec 04
% Last Update: 2004 Feb 05
% Timestamp: <demo2.m Thu 2004/02/05 14:13:32 OF@OFPC>

figure(h_fig);

%General settings for all slides
txtY_t = 9.75;
yl_t = [0 10];
xl_f = [-2.5 2.5];
yl_f = [0 5];
srate   = 60;
srate1  = 4;
srate2  = 3;
srate44 = 44.1;                 % just for playback purposes
tb  = 0;
te  = tb + 2;
t   = tb:1/srate:te-1/srate;
t1  = tb:1/srate1:te-1/srate1;
t2  = tb:1/srate2:te-1/srate2;
t44 = tb:1/srate44:te-1/srate44;
sig    = 4 + 3*cos(pi*t)   + cos(4*pi*t);
asig   = 4 + 3*cos(pi*t)   + cos(2*pi*t);
sig1   = 4 + 3*cos(pi*t1)  + cos(4*pi*t1);
sig2   = 4 + 3*cos(pi*t2)  + cos(4*pi*t2);
sig44  = 4 + 3*cos(pi*t44) + cos(4*pi*t44);
asig44 = 4 + 3*cos(pi*t44) + cos(2*pi*t44);
spec  = fftshift(abs(fft(sig)))/length(sig);
spec2 = fftshift(abs(fft(sig2)))/length(sig2);
step  = srate/length(sig);
step2 = srate2/length(sig2);
freq  = -srate/2:step:srate/2-step;
freq2 = -srate2/2:step2:srate2/2-step2;
ind  = find(spec > 0.05);
ind2 = find(spec2 > 0.05);

% individual slides
switch no,
case 1,
  clf
  plot(t,sig);
  h_txt = text(tb,txtY_t,'We have the function x(t) = 4+3cos(\pit)+cos(4\pit), with t in ms:');
  xlim([tb-0.05 te+0.05])
  ylim(yl_t);
  xlabel('Time in ms');
  ylabel('Amplitude');
case 2,
  clf
  plot(t,sig);
  hold on;
  stem(t1,sig1,'k','filled');
  hold off
  str1 = sprintf('Its highest frequency component is f_{max}=%s kHz.', ...
                 num2str(max(freq(ind))) );
  str2 = sprintf('According to the sampling theorem, a sample rate of f_s=%s kHz is sufficient.', ...
                 num2str(srate1) );
  h_txt = text(tb,txtY_t,{str1, str2});
  xlim([tb-0.05 te+0.05])
  ylim(yl_t);
  xlabel('Time in ms');
  ylabel('Amplitude');
case 3,
  clf
  plot(t,sig,t,asig,'r--');
  hold on
  stem(t1,sig1,'k','filled');
  stem(t2,sig2,'r','filled');
  hold off
  h_txt = text(tb,txtY_t,{
    ['Undersampling with f_s=' num2str(srate2) ' kHz results in the red samples.'], ...
    'Reconstructing this undersampled signal leads to the red dashed signal.', ...
    'What does this mean for the spectral content?'});
  xlim([tb-0.05 te+0.05])
  ylim(yl_t);
  xlabel('Time in ms');
  ylabel('Amplitude');
case 4,
  clf
  stem(freq(ind),spec(ind),'filled');
  h_txt = text(xl_f(1)+0.1,yl_f(2)-0.1,'The spectral content of our original signal:');
  xlim(xl_f);
  ylim(yl_f);
  xlabel('Frequency in kHz');
case 5,
  clf
  stem(freq(ind),spec(ind),'filled');
  fc = srate2/2;
  line([-fc -fc fc fc],[0 max(spec)*[1.025 1.025] 0],'LineStyle','--','Color','r');
  str = sprintf('With a sample rate of f_s=%s kHz, the Nyquist interval is [-%s, %s] kHz:', ...
                 num2str(srate2),num2str(srate2/2),num2str(srate2/2) );
  h_txt = text(xl_f(1)+0.1,yl_f(2)-0.1,str);
  xlim(xl_f);
  ylim(yl_f);
  xlabel('Frequency in kHz');
case 6,
  clf
  stem(freq2(ind2),spec2(ind2),'r','filled');
  hold on
  stem(freq(ind),spec(ind),'filled');
  hold off
  fc = srate2/2;
  line([-fc -fc fc fc],[0 max(spec)*[1.025 1.025] 0],'LineStyle','--','Color','r');
  h_txt = text(xl_f(1)+0.1,yl_f(2)-0.1,{'Without any antialias filter the frequency components', ...
                         'outside the Nyquist interval will be replicated inside it.'});
  xlim(xl_f);
  ylim(yl_f);
  xlabel('Frequency in kHz');
  i = find(abs(freq(ind))>srate2/2);
  x_from = [freq(ind(i))]';
  x_to   = [x_from(1:end/2)+srate2; x_from(end/2+1:end)-srate2];
  y      = [spec(ind(i(1:end/2)))+0.03 spec(ind(i(end/2+1:end)))-0.03]';
  arrow([x_from, y], [x_to, y], 'EdgeColor','r','FaceColor','r','LineStyle','--')
case 7,
  clf
  stem(freq(ind),spec(ind),'filled');
  hold on
  stem(freq2(ind2),spec2(ind2),'r:');
  hold off
  fc = srate2/2;
  line([-fc -fc fc fc],[0 max(spec)*[1.025 1.025] 0],'LineStyle','--','Color','r');
  h_txt = text(xl_f(1)+0.1,yl_f(2)-0.1,'Hear the difference between the two reconstructed signals!');
  xlim(xl_f);
  ylim(yl_f);
  xlabel('Frequency in kHz');
  set([h_txt, gca],'Units','pixels');
  pos_txt = get(h_txt,'Extent');
  pos_ax  = get(gca,'Position');
  set(h_txt,'Units','data');
  set(gca,  'Units','normalized');
  CBS_3kHz = strcat(mfilename,'(',int2str(h_fig),',''s1'');');
  CBS_4kHz = strcat(mfilename,'(',int2str(h_fig),',''s2'');');
  h_3kHz = uicontrol(h_fig,'Style','PushButton','CallBack',CBS_3kHz, ...
                     'String','sample rate: 3 kHz','ForegroundColor','r');
  h_4kHz = uicontrol(h_fig,'Style','PushButton','CallBack',CBS_4kHz, ...
                     'String','sample rate: 4 kHz','ForegroundColor','b');
  pos_3kHz = get(h_3kHz,'Position');
  pos_4kHz = get(h_4kHz,'Position');
  pos_3kHz = [pos_txt(1)+pos_ax(1) pos_txt(2)+pos_ax(2)-pos_txt(4)*2 ...
              pos_3kHz(3)*1.6      pos_3kHz(4)];
  pos_4kHz = [pos_txt(1)+pos_ax(1) pos_3kHz(2)-pos_3kHz(4)*1.2 ...
              pos_4kHz(3)*1.6      pos_4kHz(4)];
  set(h_3kHz,'Position',pos_3kHz);
  set(h_4kHz,'Position',pos_4kHz);
case 's1',
  % just to be able to play the reconstructed signal (sampled at 3 kHz)
  fact = 1/max(abs([asig44,sig44]));
  tmp = fact*asig44;
  for i = 1:5, tmp = [tmp tmp tmp tmp]; end
  sound(tmp,srate44*1000);
case 's2',
  % just to be able to play the reconstructed signal (sampled at 4 kHz)
  fact = 1/max(abs([asig44,sig44]));
  tmp = fact*sig44;
  for i = 1:5, tmp = [tmp tmp tmp tmp]; end
  sound(tmp,srate44*1000);
end

% and some general settings to be applied after creating the slide
if isnumeric(no),
  set(h_txt,'VerticalAlignment','cap','FontSize',14);
end
