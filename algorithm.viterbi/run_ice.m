function [path,lower,upper]=run_ice(fname, top_smooth, bottom_smooth, ...
    top_peak, bottom_peak, repulse, pts1, pts2, alg)

% Read the image
A=imread(fname);

% Choose MCMC
%if alg == 2
    while 1
        if(numel(pts1) + numel(pts2) > 0 )
            [path, lower, upper]=RJ_MCMC(double(A(:,:,1)), pts1, pts2);
        else
            [path, lower, upper]=RJ_MCMC(double(A(:,:,1)));
        end
        
        plot = 1;
        if plot
            imshow(A, 'Border', 'tight', 'InitialMagnification', 100);
            line(1:size(A,2), path(1,:), 'Color', [1 0 0], 'LineWidth', 3);
            line(1:size(A,2), path(2,:), 'Color', [0 1 0], 'LineWidth', 3);
            line(1:size(A,2), upper, 'Color', [0 0 1], 'LineWidth', 1);
            line(1:size(A,2), lower, 'Color', [0 0 1], 'LineWidth', 1);
            if(numel(pts1) > 0)
                line(pts1(1,:), pts1(2,:), 'LineStyle', 'none', 'Marker', '*', ...
                    'Color', [1 0 0]);
            end
            if(numel(pts2) > 0)
                line(pts2(1,:), pts2(2,:), 'LineStyle', 'none', 'Marker', '*', ...
                    'Color', [0 1 0]);
            end
        end
        
        
        % Hmm
        opts = [top_smooth bottom_smooth top_peak bottom_peak repulse];
        if(numel(pts1) + numel(pts2) > 0 )
            [AA, path]=stereo(1, double(A(:,:,1)), opts, pts1, pts2);
        else
            [AA, path]=stereo(1, double(A(:,:,1)), opts);
        end
        
        plot=1;
        if plot
            figure(4)
            imshow(A, 'Border', 'tight', 'InitialMagnification', 100);
            
            line(1:size(A,2), path(1,:), 'Color', [1 0 0], 'LineWidth', 3);
            line(1:size(A,2), path(2,:), 'Color', [0 1 0], 'LineWidth', 3);
            if(numel(pts1) > 0)
                line(pts1(1,:), pts1(2,:), 'LineStyle', 'none', 'Marker', '*', ...
                    'Color', [1 0 0]);
            end
            if(numel(pts2) > 0)
                line(pts2(1,:), pts2(2,:), 'LineStyle', 'none', 'Marker', '*', ...
                    'Color', [0 1 0]);
            end
        end
        % Hmm
        
        
        
        x=[];
        if(numel(x) == 0)
            break
        end
        
        if(b == 3)
            pts1 = [pts1 double([x y]')];
        else
            pts2 = [pts2 double([x y]')];
        end
    end
    
% Choose Hmm
% elseif alg == 1
%     while 1
%         opts = [top_smooth bottom_smooth top_peak bottom_peak repulse];
%         if(numel(pts1) + numel(pts2) > 0 )
%             [AA, path]=stereo(1, double(A(:,:,1)), opts, pts1, pts2);
%         else
%             [AA, path]=stereo(1, double(A(:,:,1)), opts);
%         end
%         
%         plot=1;
%         if plot
%             figure('MCMC ALgorithm Graph')
%             imshow(A, 'Border', 'tight', 'InitialMagnification', 100);
%             
%             line(1:size(A,2), path(1,:), 'Color', [1 0 0], 'LineWidth', 3);
%             line(1:size(A,2), path(2,:), 'Color', [0 1 0], 'LineWidth', 3);
%             if(numel(pts1) > 0)
%                 line(pts1(1,:), pts1(2,:), 'LineStyle', 'none', 'Marker', '*', ...
%                     'Color', [1 0 0]);
%             end
%             if(numel(pts2) > 0)
%                 line(pts2(1,:), pts2(2,:), 'LineStyle', 'none', 'Marker', '*', ...
%                     'Color', [0 1 0]);
%             end
%         end
%         
%         
%         % MCMC
%         if(numel(pts1) + numel(pts2) > 0 )
%             [path, lower, upper]=RJ_MCMC(double(A(:,:,1)), pts1, pts2);
%         else
%             [path, lower, upper]=RJ_MCMC(double(A(:,:,1)));
%         end
%         
%         plot = 1;
%         if plot
%             imshow(A, 'Border', 'tight', 'InitialMagnification', 100);
%             line(1:size(A,2), path(1,:), 'Color', [1 0 0], 'LineWidth', 3);
%             line(1:size(A,2), path(2,:), 'Color', [0 1 0], 'LineWidth', 3);
%             line(1:size(A,2), upper, 'Color', [0 0 1], 'LineWidth', 1);
%             line(1:size(A,2), lower, 'Color', [0 0 1], 'LineWidth', 1);
%             if(numel(pts1) > 0)
%                 line(pts1(1,:), pts1(2,:), 'LineStyle', 'none', 'Marker', '*', ...
%                     'Color', [1 0 0]);
%             end
%             if(numel(pts2) > 0)
%                 line(pts2(1,:), pts2(2,:), 'LineStyle', 'none', 'Marker', '*', ...
%                     'Color', [0 1 0]);
%             end
%         end
%         % MCMC
%         
%         
%         x=[];
%         if(numel(x) == 0)
%             break
%         end
%         
%         if(b == 3)
%             pts1 = [pts1 double([x y]')];
%         else
%             pts2 = [pts2 double([x y]')];
%         end
%     end
% end
