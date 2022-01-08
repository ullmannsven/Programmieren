function visualize_grid(h)
Omega = buildGitter(h);
figure;
plot(Omega(:,:,1),Omega(:,:,2),'r.');
grid on
hold on
len = length(Omega(1,:,:));
k = 1;
for i=1:len
    for j=1:len
        if Omega(i,j,3)~=0
            text(Omega(i,j,1),Omega(i,j,2),num2str(k),'Color','k')
            drawnow
            pause(1/len^2)
            k = k + 1;
        end 
    end 
end
hold off
end
