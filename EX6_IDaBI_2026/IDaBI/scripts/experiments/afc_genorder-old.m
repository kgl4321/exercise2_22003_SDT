function orderarray = afc_genorder;

global def

% get expparsize
expparsize=[];
for i=1:def.expparnum
   eval(['tmpsize = size(def.exppar' num2str(i) ');']);
   %eval(['[expparsize; size(def.exppar' num2str(i) ')];'])
   expparsize=[expparsize; tmpsize];
end
def.expparsize=expparsize;

allorderrand = 0;
if size(def.parrand,2) ~= def.expparnum
	% of request 12-03-2004 10:46 randomize completly if def.parrant scalar und expparnum > 1 
	% FIXME should go to main!
	if size(def.parrand,2) == 1
		allorderrand = 1;
		def.parrand = repmat(def.parrand,1,def.expparnum);
	else

   		error('def.parrand dimension mismatch');
   	end
end

%def.repeatnum = 10;
%def.expparnum = 3;
%def.parrand = [1 0 1];
%expparsize = [2 4;1 2; 1 3];

indmat = [];
         for i_rep = 1:def.repeatnum
            indmatblock = [];
            for i_exp = 1:def.expparnum
               % column in indmat
               indmatcol = [];
               
               if def.expparnum - i_exp == 0
                  repnum = 1;
               else
                  repnum = prod(expparsize(i_exp + 1:end,2),1);
               end
               
               for i_col = 1:repnum
               	switch def.parrand(i_exp)
               	case 0	% order
                  	indmattmp = [1:expparsize(i_exp,2)]';
               	case 1	% random
                  	indmattmp = randperm(expparsize(i_exp,2))';
                  end
                  
                  if i_exp == 1
                     repnum2 = 1;
                  else
                     repnum2 = prod(expparsize(1:i_exp-1,2),1);
                  end
                  
                  for i = 1:length(indmattmp)
                     indmatcol = [indmatcol; repmat(indmattmp(i),repnum2,1)];
                  end		% for i  
               end			% for i_col
               indmatblock = [indmatblock indmatcol];
            end				% for i_exp
            indmat = [indmat; indmatblock];
         end					% fro i_rep
         
         orderarray = indmat;

% 15-03-2004 12:27
if allorderrand == 1;
	indmattmp = [];
	blocksize = size(orderarray,1)/def.repeatnum;
	for i_rep = 1:def.repeatnum
		indmattmp = [indmattmp; (blocksize*(i_rep-1))+randperm(blocksize)'];
	end
	orderarray = orderarray(indmattmp,:);   
end
         % eof