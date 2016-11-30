        

counter_struct =1;
        
        


        [fin_sol, fin_rm_redunt, G_init, G_gadget2, nodes_totsp, total_cost, whole_path, time_auto_for_struct] = auto_for_content(visibility_adjacency_matrix, guard_target_struct, counter_struct);
        
        %%
        
         [fin_sol, fin_rm_redunt, Out_solName, Out_sol, G_init, G_gadget, G_gadget2, time_concorde_struct] = solve_GTSP(V_adj, V_Cluster) ;
         
         %%
         %********noon-bean************
         counter_struct =1;
        
        %currently cost I
        %
        % <http://www.mathworks.com N gtsp_to_atsp is changed ..> .we are using max max
        % 
        % * ITEM1
        % * ITEM2
        % 
        %instead OF SUMSUM


        [outfin_sol, outfin_cost,Out_solName, Out_sol, G_init, edges_totsp, nodes_totsp, time_auto_for_struct] = auto_for_content_noon_bean(visibility_adjacency_matrix, guard_target_struct, counter_struct);
        %%
        outfin_sol_unique = [unique(outfin_sol,'stable') outfin_sol(1)];
        
        fid = fopen('goals.txt','W');
        if fid < 0
            error('Cannot create  file');
            return;
        end

        %fprintf(fid,'//goals or outfin_sol_unique x-y coordinates \n');
        %goals or outfin_sol_unique x-y coordinates
        for i = 1:length(outfin_sol_unique)
            fprintf(fid,'%f\t%f\n', guards_x(outfin_sol_unique(i)), guards_y(outfin_sol_unique(i)));
        end

        fclose(fid);
        
        %currently cost IN gtsp_to_atsp is changed ...we are using max max
        
          %instead OF SUMSUM
          
          %%
          
          
          
           counter_struct =1;
          

          
         
         
           
          [outfin_sol, outfin_cost, Out_solName, whole_path_nodes, G_init, G_nodebot, edges_totsp, nodes_totsp, time_concorde_struct] = auto_for_content_Multi_noon_bean(visibility_adjacency_matrix, guard_target_struct, counter_struct);
         
         %%
%          tic;
%          for i =1:100000
%              x_ss = ismember(X,[1 2 3; 2 3 4]);
%          end
%          toc;

%%

%Adj_G_comp = full(adjacency(G_comp));
[s_ t_]=findedge(G_comp);

 Adj_G_comp(:,:) = sum(G_comp.Edges.Weight(:));
 Adj_G_comp_ind = sub2ind(size(Adj_G_comp), s_(:),t_(:));
 
 Adj_G_comp(Adj_G_comp_ind(:)) = G_comp.Edges.Weight(:);
 diag_ind = sub2ind(size(Adj_G_comp), 1:length(Adj_G_comp),1:length(Adj_G_comp));
 Adj_G_comp(diag_ind(:)) = 0;
 
 setMap = []
 
 
 
 %
***nodes20target10_40s***
gtsp_ILP ->sol= 1,19,8,15,14,4,17,1 =>cluse => 1, 4, 8, 9, 3, 4, 2, 10, 5, 6, 7, 1  => all fine cost 161 approz
normal_tsp-> sol = 1,18,19,7,14,13,12,15,10,9,8,7,6,5,3,17,3,1  => clus=>  % [1,8,9,4,8,9,4,5,5,10,2,10,3,3,3,4,4,6,6,7,6] total cost: 1616/10
 {'V20-9','V19-4','V5-6','V18-8','V14-5','V12-10','V17-7','V16-2','V8-3','V2-1'}
 
 
 

%%



%     edge_table = G_atsp.Edges;
%     zero_weight_ind = edge_table.Weight==0;
% 
%     cur_clus_cell = cell(1, length(Cluster_to_node));
%     weight_vec_cell = cell(num_bots, 1);
%     str_f_cell = cell(num_bots,1);
% 
%     for i = 1: length(Cluster_to_node)
%         log_ind_clus(:,i) = cell2mat(cellfun(@(x) isequal(sprintf('-%d', i),x(regexp(x,'-','start'):end)), edge_table.EndNodes(:,2), 'uni', 0 )); % index belonging to cluster i 
%         cur_clus_ind = log_ind_clus(:,i) & zero_weight_ind; % edges having zeros cost and belonging to clus i
%         
%         if(sum(cur_clus_ind)~=0)
%             cur_clus_cell{1,i} = edge_table.EndNodes(cur_clus_ind==1, 1); % cell containing names of all the nodes in cluster i connected in a cycle
% 
%             for j = 1:num_bots
% 
%                 % this time as we have edges from all nodes to all finish
%                 % depots, we don't need to tail shift but only assign costs of
%                 % current edge to the previous edge. 
%                 weight_vec_cell{j,1} = ...
%                 circshift(G_nodebot_comp.Edges.Weight(findedge(G_nodebot_comp, cellfun(@(x) sprintf('B%d', j), cur_clus_cell{1,i},'uni', 0), cellfun(@(x) x(1:(regexp(x,'-','start')-1)) , cur_clus_cell{1,i},'uni',0))),-1); 
%                 % find edges from Bi to V1(all parts of cur_clus_cell) and
%                 % shift their weights
%                 str_f_cell{j, 1} = cellfun(@(x) sprintf('B%d-f', j), cur_clus_cell{1,i},'uni', 0);
% 
% 
%             end
% 
%             concat_f_cell = [str_f_cell{:,:}];
%             concat_w_cell = [weight_vec_cell{:,:}];
%             G_atsp = addedge(G_atsp, repmat(cur_clus_cell{1,i}, num_bots, 1), concat_f_cell(:), [concat_w_cell(:)]); 
%         elseif(sum(cur_clus_ind)==0)
%             for j = 1:num_bots  
%                 lonely_node_name =  edge_table.EndNodes(log_ind_clus(:,i),2); % this node is a single node in a cluster
%                 weight_vec_cell{j,1} = G_nodebot_comp.Edges.Weight(findedge(G_nodebot_comp, sprintf('B%d', j), lonely_node_name{1}(1:(regexp(lonely_node_name{1},'-','start')-1))));
%                 str_f_cell{j, 1} = {sprintf('B%d-f', j)};
%             end
%             
%             concat_f_cell = [str_f_cell{:,:}];
%             concat_w_cell = [weight_vec_cell{:,:}];
%             G_atsp = addedge(G_atsp, repmat(lonely_node_name(1), num_bots, 1), concat_f_cell(:), [concat_w_cell(:)]); 
%             
%         end
% 
%     end

