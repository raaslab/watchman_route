 whole_path_nodes = cell(num_bots,1);

for i = 1:num_bots
    for j = 1:length(node_num_forw_cell{i})
       if(j==1)
           str_s_bot2node = sprintf('B%d', -1*node_num_forw_cell{i,1}(1));
           str_t_bot2node = sprintf('V%d', node_num_forw_cell{i,1}(2));
           whole_path_nodes{i} =  [whole_path_nodes{i}; shortestpath(G_nodebot, str_s_bot2node, str_t_bot2node)];  
       elseif(j>1 && j< length(node_num_forw_cell{i})-1)
           str_s_node2node = sprintf('V%d', node_num_forw_cell{i,1}(j));
           str_t_node2node = sprintf('V%d', node_num_forw_cell{i,1}(j+1));
           whole_path_nodes{i} =  [whole_path_nodes{i}(1:end-1) shortestpath(G_nodebot, str_s_node2node, str_t_node2node)]; 
       elseif (j==length(node_num_forw_cell{i})-1)
           
           str_s_node2bot = sprintf('V%d', node_num_forw_cell{i,1}(end-1));
           str_t_node2bot = sprintf('B%d', -1*node_num_forw_cell{i,1}(end));
           whole_path_nodes{i} =  [whole_path_nodes{i}(1:end-1) shortestpath(G_nodebot, str_s_node2bot, str_t_node2bot)]; 
       end
         
       
        
    end
end