function Aprox_poligonal4(BW)

    s=size(BW);
    for row = 2:55:s(1)
        for col=1:s(2)
            if BW(row,col), break;
            end
        end
        %contour = bwtraceboundary(BW, [row, col], 'W', 4);
        
contour = bwboundaries (BW,4);
contour = cell2mat (contour);
%figure, imshow (bw);
%hold on
%plot (contour(:,2), contour(:,1), '.g');
        if(~isempty(contour))
            hold on; 
            plot(contour(:,2),contour(:,1),'g','LineWidth',4);
            hold on; 
            plot(col, row,'gx','LineWidth',2);
        else
            hold on; 
            plot(col, row,'rx','LineWidth',2);
        end
    end
end