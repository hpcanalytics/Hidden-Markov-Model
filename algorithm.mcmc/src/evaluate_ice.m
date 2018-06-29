function [list, result_mean,result_med, contain]=evaluate_ice(fnamebase)
global X Y Mup Mdn
Mup=[];
Mdn = [];
L=ls(fnamebase);
list = unique(regexprep(strread(L, '%s'), '_[0-9][a-z_]*.png', ''));

S=prod(size(list));

X=zeros(1,2001);
Y=zeros(1,2001);

%[m1, m2] = evaluate_single_ice('../../2009_Antarctica_DC8/images/20091016_seg1_23_18080323');

 [m1, m2] = evaluate_single_ice('../../2009_Antarctica_DC8/images/20091016_seg1_17_17342459');


 result_mean = [];
 result_med = [];
 contain = [];
 return;
 
 
results_mean = zeros(4,2,S)*nan;
results_med = zeros(4,2,S)*nan;
skip=0;
parfor i=1:S
  [m1, m2,cup, clow] = evaluate_single_ice(strcat(fnamebase,[list{i}]));
  if isnan(cup)
      skip=skip+1;
  else
    result_mean(:,:,i)=m1;
    result_med(:,:,i)=m2;
    contain(:,i) = [cup;clow];
  end
end

result=[nanmean(result_mean,3) nanmean(result_med,3)];

display('           Means:                                     Medians:');
display(sprintf('               sse %11.1f  %11.1f', result(1,:)));
display(sprintf('               err %11.1f  %11.1f', result(2,:)));
display(sprintf('       1pt     sse %11.1f  %11.1f', result(3,:)));
display(sprintf('               err %11.1f  %11.1f', result(4,:)));
display(sprintf(' --> SKIPPED: %d of %d', skip, S));



function [result_mean result_med cup clow] = evaluate_single_ice(fnamebase)
global X Y Mup Mdn

imgfname = [fnamebase '_1chop.png'];


gtfname = [fnamebase '_2chop_picks.png'];
A=imread(gtfname);
upper_gt=(A(:,:,1)==255).*(A(:,:,2)==0).*(A(:,:,3)==255);    
lower_gt=(A(:,:,1)==255).*(A(:,:,2)==0).*(A(:,:,3)==0);    

U=vec2ind(upper_gt);
L=vec2ind(lower_gt);

%if it cant find any
if(sum(sum(upper_gt)) <300 || sum(sum(lower_gt)) <300)
  result_mean=[nan];
  result_med=[nan];
  cup = nan;
  clow = nan;
  return;
end
[path,lower,upper]=run_ice(imgfname,[],[]);

upper_gt = interp1(find(U>1), U(find(U>1)), 1:size(A,2), 'linear', 'extrap');
lower_gt = interp1(find(L>1), L(find(L>1)), 1:size(A,2), 'linear', 'extrap');

A=imread(imgfname);
alpha=0.20;
for i=1:length(lower(1,:))
   top = upper(1,i);
   bot = lower(1,i);
   for j=top:bot
    A(j,i,1) = (1-alpha)*A(j,i,1) + alpha*255;
    A(j,i,2) = (1-alpha)*A(j,i,2);
    A(j,i,3) = (1-alpha)*A(j,i,3);
   end
   
   top = upper(2,i);
   bot = lower(2,i);
   for j=top:bot
    A(j,i,1) = (1-alpha)*A(j,i,1);
    A(j,i,2) = (1-alpha)*A(j,i,2) + alpha*255;
    A(j,i,3) = (1-alpha)*A(j,i,3);
   end
end


imshow(A)
hold on;
plot(path(1,:), 'LineWidth',2, 'Color','red')
plot(lower(1,:),'LineWidth',1, 'Color','red')
plot(upper(1,:),'LineWidth',1, 'Color','red')
plot(path(2,:), 'LineWidth',2, 'Color','green')
plot(lower(2,:),'LineWidth',1, 'Color','green')
plot(upper(2,:),'LineWidth',1, 'Color','green')
hold off;


upper_band = (upper_gt >= upper(1,:)).*(upper_gt <= lower(1,:));
lower_band = (lower_gt >= upper(2,:)).*(lower_gt <= lower(2,:));


cup = mean(upper_band);
clow = mean(lower_band);



gt = [upper_gt; lower_gt];
result_mean=[];
result_med=[];
result_mean=[result_mean; mean(((path-gt).^2)')];
result_mean=[result_mean; mean(abs((path-gt))')];
result_med=[result_med; median(((path-gt).^2)')];
result_med=[result_med; median(abs((path-gt))')];

upper_hist=upper_gt(2:end)-upper_gt(1:(end-1));
lower_hist=lower_gt(2:end)-lower_gt(1:(end-1));
if(sum(isnan(upper_hist) == 0))
  X=[X upper_hist];
end
low_ok=0;
high_ok=0;

if(sum(isnan(lower_hist) == 0))
  Y=[Y lower_hist];
  low_ok=1;
end

if(sum(isnan(upper_hist) == 0))
  high_ok=1;
end


[i j] = max((path(2,:)-lower_gt).^2);
[iii2 jjj2] = max((path(1,:)-upper_gt).^2);

if j > size(A,2) || lower_gt(j) > size(A,1) || j < 1 || lower_gt(j) ...
      < 1
  low_ok = 0;
end
if upper_gt(jjj2) > size(A,1) || jjj2 > size(A,2) || jjj2 < 1 || ...
      upper_gt(jjj2) < 1
  high_ok = 0;
end

if(low_ok && high_ok && 1==0)
    try 
        disp(imgfname);
        [path,lower, upper] = run_ice(imgfname, [jjj2; floor(upper_gt(jjj2))], [j; floor(lower_gt(j))]);
    catch err
        
    end
end





if(low_ok)
  result_mean=[result_mean; mean(((path-gt).^2)')];
  result_med=[result_med; median(((path-gt).^2)')];
  result_mean=[result_mean; mean(abs((path-gt))')];
  result_med=[result_med; median(abs((path-gt))')];
else
  result_mean=[result_mean; ones(2,2)*nan];
  result_med=[result_med; ones(2,2)*nan];
end


disp(strcat(imgfname, ' - ',sprintf('ME: upper: %f lower %f %f  %f', mean(abs((path(1,:)-upper_gt).^1)), mean(abs((path(2,:)-lower_gt).^1)), cup, clow)));



