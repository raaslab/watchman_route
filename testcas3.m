% Open the temporary tsplib format file
%
%     'EDGE_DATA_FORMAT : EDGE_LIST\n' ...
%    'EDGE_WEIGHT_FORMAT :  UPPER_ROW\n' ...
%



fid = fopen('temp.tsp','W');
if fid < 0
	error('Cannot create temp file');
	return;
end



fprintf(fid, ['NAME : temp\n' ...
							'TYPE : GRAPH\n' ...
							'COMMENT : temp\n' ...
							'DIMENSION :  4 \n' ...
                            'GRAPH_TYPE  : SPARSE_GRAPH\n' ...
							'EDGE_WEIGHT_TYPE : EXPLICIT\n' ...                            
                            'EDGE_DATA_FORMAT : EDGE_LIST\n' ...
                            'EDGE_WEIGHT_FORMAT :  UPPER_ROW\n' ...
                            'NODE_COORD_TYPE :  NO_COORDS\n' ...
                            'EDGE_DATA_SECTION : \n']);

% for i = 1 : n
% 	fprintf(fid, [num2str(i-1) ' ' num2str(scaled_X(i,1)) ' ' num2str(scaled_X(i,2)) '\n']); 
% end

fprintf(fid, ['0' ' ' '1' '\n']); 
fprintf(fid, ['1' ' ' '2' '\n']); 
fprintf(fid, ['2' ' ' '3' '\n']); 
fprintf(fid, ['3' ' ' '0' '\n']); 

fprintf(fid, ['-1' '\n']); 

fprintf(fid, ['EDGE_WEIGHT_SECTION : \n']); 

fprintf(fid, ['10' ' ' '180' ' ' '50' '\n']); 
fprintf(fid, ['40' ' ' '180' '\n']);                         
fprintf(fid, ['70' '\n']);                         
%fprintf(fid, ['0' ' ' '0' ' ' '0' ' ' '0' '\n']);                         

%fprintf(fid, ['-1' '\n']); 

fclose(fid);




cmd = ['/home/ashishkb/softwares/concorde/concorde_build/TSP/concorde' ' -x temp.tsp'];
system(cmd);

%'EDGE_DATA_FORMAT : EDGE_LIST\n' ...
%'EDGE_DATA_SECTION : \n' ...
%