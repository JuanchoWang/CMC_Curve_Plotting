function [  ] = cmc_NEW(pro_ts_feat, pro_ts_labels, gal_ts_feat, gal_ts_labels, nt, n_trial, exp)
% CMC for VCU project (ags2hi)
%
% pro_ts_feat: 
% feature matrix for the peresons in the probe_test, each
% row of this matrix is a feature array for one person
%
% pro_ts_labels: 
% label vector for the persons in the probe_test, each
% element of this vector is a label (int) for one person. this array is
% matching the order of pro_ts_feat
%
% gal_ts_feat: 
% feature matrix for the peresons in the gallery_test, each
% row of this matrix is a feature array for one person
%
% gal_ts_labels:
% label vector for the persons in the gallery_test, each
% element of this vector is a label (int) for one person. this array is
% matching the row order of gallery_ts_feat persons

%% evaluation settings
n_ranks = 500;
CMC = zeros(n_trial,n_ranks);
colors = {[1 0 0];[0 1 0];[0 0 1];[0 0 0];[1 1 0];[1 0 1];[0 1 1]};
%% Loop on trial (splits)
disp(['Trial ' num2str(nt) ' of ' num2str(n_trial) ' ...']);

%calculate scores
scores = CosDist(gal_ts_feat, pro_ts_feat);
% cd('ScoreMatrix');
% save(strcat(exp, 'Scores_Matrix.txt'),'scores','-ascii');% comment when Scores Matrix is not needed
% cd('..');

for p=1:numel(pro_ts_labels)        
    score = scores(p, :);
    [sortscore, ind] = sort(score, 'descend');

    correctind = find( gal_ts_labels(ind) == pro_ts_labels(p));
    rank = numel(unique(gal_ts_labels(ind(1:correctind(1)))));
    CMC(nt, rank:end) = CMC(nt, rank:end) + 1;
end
idPersons = size(pro_ts_labels,2);
CMC_percent(nt,:) = 100.*CMC(nt,:)/(idPersons);
    
CMC_mean =  mean(CMC_percent,1);% average value for each trial
CMC_vector = CMC_mean/max(CMC_mean);
% cd('CMC_Vectors');
% save(strcat(exp, 'CMC_Vector.txt'),'CMC_vector','-ascii');% comment when CMC Vectors are not needed
% cd('..');
plot(CMC_vector, 'Color', colors{nt},'DisplayName',exp);
xlim([0 100]);

end


