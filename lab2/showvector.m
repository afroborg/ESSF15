function showvector(valfa,vbeta)
% function showvector(valfa,vbeta) visar en animering av den komplexa 
% vektorn v n�r godtycklig tangent trycks ner.
% valfa och vbeta �r vektorns real- och imagin�rdelar som funktion av tid
%
% Funktionen kan avbrytas med Ctrl-C
figure(1)
clf
subplot(1,1,1)
vab=plot([0 valfa(1)],[0 vbeta(1)]);
mx=1.1*max([max(abs(valfa)) max(abs(vbeta))]);
set(gca,'xlim',[-mx mx],'ylim',[-mx mx])
xlabel('alfa')
ylabel('beta')
axis('square')
for k=2:length(valfa),
    set(vab,'xdata',[0 valfa(k)],'ydata',[0 vbeta(k)])
    pause
end
end