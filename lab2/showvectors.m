function showvectors(uspsis)
% function showvectors(uspsis) spelar upp en animering av spänningsvektorn 
% us och flödesvektorn psis när godtycklig tangent trycks ned. För us visas
% själva vektorn i varje tidpunkt, medan för psis visas spåret efter 
% vektorns spets.
%
% Funktionen kan avbrytas med Ctrl-C
%
% uspsis är en "structure with time" från Simulink
%
figure(1)
clf
t=uspsis.time;
ualf=uspsis.signals(1).values(:,1);
ubet=uspsis.signals(1).values(:,2);
palf=uspsis.signals(2).values(:,1);
pbet=uspsis.signals(2).values(:,2);
subplot(1,2,1)
uab=plot([0 ualf(1)],[0 ubet(1)]);
set(gca,'xlim',[-500 500],'ylim',[-500 500])
xlabel('us_a')
ylabel('us_b')
axis('square')

subplot(1,2,2)
pab=plot([0 palf(1)],[0 pbet(1)]);
set(gca,'xlim',[-2 2],'ylim',[-2 2])
xlabel('psis_a')
ylabel('psis_b')
axis('square')
hold on

for k=2:length(t),
    set(uab,'xdata',[0 ualf(k)],'ydata',[0 ubet(k)])
    plot([palf(k-1) palf(k)],[pbet(k-1) pbet(k)])
    pause
end
end