name_fold = 2:1:11;
cost_mat = zeros(length(name_fold), 12);
time_mat = zeros(length(name_fold), 12);

for i = 1:length(name_fold)
    for j=3:12
        clear var_a;
        filename = sprintf('./cvl_target/random_target_%d/%d_1.mat',name_fold(i), j);
        var_a = load(filename,'outfin_cost', 'time_auto_for_struct');
        
        cost_mat(i,j) = sum(var_a.outfin_cost);
        time_mat(i,j) = var_a.time_auto_for_struct.total_time;
        
        
        
    end
    
end

%%
cost_mat_std = std(cost_mat, 1);
time_mat_std = std(time_mat, 1);

cost_mat_mean = mean(cost_mat, 1);
time_mat_mean = mean(time_mat, 1);
%%
figure(122); hold on;
for num_target = 3 : size(cost_mat,2)
    for num_trial = 1 : size(cost_mat,1)
        plot(num_target, cost_mat(num_trial,num_target), 'bo','MarkerFaceColor','b','MarkerSize',4);
    end
end
errorbar(3:12,cost_mat_mean(3:12),cost_mat_mean(3:12)-min(cost_mat(:,3:12),[],1),cost_mat_mean(3:12)-max(cost_mat(:,3:12),[],1));
%%
figure(123); hold on;
for num_target = 3 : size(time_mat,2)
    for num_trial = 1 : size(time_mat,1)
        plot(num_target, time_mat(num_trial,num_target), 'bo','MarkerFaceColor','b','MarkerSize',4);
    end
end
errorbar(3:12,time_mat_mean(3:12),time_mat_mean(3:12)-min(time_mat(:,3:12),[],1),time_mat_mean(3:12)-max(time_mat(:,3:12),[],1));


  %%      
figure(1);
errorbar(3:12,time_mat_mean(3:12),time_mat_std(3:12)*3);
title('time\_target\_random\_3to12');

figure(2);
errorbar(3:12,cost_mat_mean(3:12),cost_mat_std(3:12)*3);
title('cost\_target\_random\_3to12');


%%

%%

