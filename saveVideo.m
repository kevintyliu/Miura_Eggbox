T = 10;
tFrame = 0.2;
mergedobj = VideoWriter('compositevid','Motion JPEG AVI');
mergedobj.FrameRate = 1/tFrame; 
open(mergedobj); 

for k = 1:T/tFrame
    M = getframe(gcf);
    writeVideo(mergedobj,M);
    pause(tFrame);
end

close(mergedobj);
