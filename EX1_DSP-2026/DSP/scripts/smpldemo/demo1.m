function demo1(h_fig,no)
% DEMO1 first part of the demonstration of sampling effects
%
% syntax: demo1(h_fig,no)
%
% Show slide number no of the demonstration in figure h_fig.

% (c) of, 2003 Dec 03
% Last Update: 2004 Jan 07

figure(h_fig);

%General settings for all slides
txt_y = 1.5;
srate = 4;
f = [7 3 1 5 9]';
t1 = 0;
t2 = t1 + 1;
t = t1:1/(srate*256):t2;
sig = cos(2*pi*f*t);
tdot = -t1:1/srate:t2;
dots = cos(2*pi*f(3)*tdot);

% individual slides
switch no,
case 1,
  clf
  h_txt = text(t1,txt_y,'We would like to sample five cosines of different frequency:');
  box on
case 2,
  plot(t,sig(1,:),'-');
  legend('7 Hz');
  h_txt=text(t1,txt_y,'One with a frequency of 7 Hz,\ldots');
case 3,
  plot(t,sig(1:2,:),'-');
  legend('7 Hz','3 Hz');
  h_txt=text(t1,txt_y,'\ldotsanother one with a frequency of 3 Hz,\ldots');
case 4,
  plot(t,sig(1:3,:),'-');
  legend('7 Hz','3 Hz','1 Hz');
  h_txt=text(t1,txt_y,'\ldotsanother one with a frequency of 1 Hz,\ldots');
case 5,
  plot(t,sig(1:4,:),'-');
  legend('7 Hz','3 Hz','1 Hz','5 Hz');
  h_txt=text(t1,txt_y,'\ldotsanother one with a frequency of 5 Hz,\ldots');
case 6,
  plot(t,sig(1:5,:),'-');
  legend('7 Hz','3 Hz','1 Hz','5 Hz','9 Hz');
  h_txt=text(t1,txt_y,{'\ldotsand another one with a frequency of 9 Hz.',...
         'Sampling at a rate of 4 Hz results in\ldots'});
case 7,
  h = plot(tdot,dots,'ko',t,sig,'-');
  set(h(1),'MarkerSize',10,'MarkerfaceColor','k','MarkerEdgeColor','k');
  legend(h(2:end),'7 Hz','3 Hz','1 Hz','5 Hz','9 Hz');
  h_txt=text(t1,txt_y,{'\ldotsthe same samples for all five cosines.',...
                       'Only the cosine with a frequency of 1 Hz is', ...
                       'in accordance with the sampling theorem.'});
end

% and some general settings to be applied after creating the slide
set(h_txt,'VerticalAlignment','cap','Fontsize',14);
axis([t1-0.025 t2+0.025 -1.1 1.6])
xlabel('Time in s');
ylabel('Amplitude');
