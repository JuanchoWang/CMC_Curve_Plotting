clear all;
addpath('\\hi2crsmb\external\wan4hi\Code\CMC_Curve\src');
folder_path = uigetdir();
cd(folder_path);
mkdir('ScoreMatrix');
mkdir('CMC_Vectors');
GF_list = dir(strcat(folder_path,'\*gallery*test*FeatureVector.txt'));
GN_list = dir(strcat(folder_path,'\*gallery*test*ImageList.txt'));
PF_list = dir(strcat(folder_path,'\*probe*test*FeatureVector.txt'));
PN_list = dir(strcat(folder_path,'\*probe*test*ImageList.txt'));

figure(3) %change the index of figure so that you can compare
if (length(GF_list) == length(GN_list)) && ...
    (length(GN_list) == length(PN_list)) && ...
    (length(PF_list) == length(PN_list))
    for i = 1:length(GF_list)
        gal_ret = importdata(strcat(GF_list(i).folder,'\',GF_list(i).name));
        pro_ret = importdata(strcat(PF_list(i).folder,'\',PF_list(i).name));
        
        gal_img_cell = importdata(strcat(GN_list(i).folder,'\',GN_list(i).name));
        gal_lab = zeros(1,length(gal_img_cell));
        for idx = 1:length(gal_img_cell)
            temp_cell = strsplit(gal_img_cell{idx},{'_','-'});% change here if other splitter
            gal_lab(idx) = str2double(temp_cell{1});% change here if person ID is not the first part of image name
        end
        pro_img_cell = importdata(strcat(PN_list(i).folder,'\',PN_list(i).name));
        pro_lab = zeros(1,length(pro_img_cell));
        for idx = 1:length(pro_img_cell)
            temp_cell = strsplit(pro_img_cell{idx},{'_','-'});
            pro_lab(idx) = str2double(temp_cell{1});
        end
        
        %% This section only changes the legend
        name_idx = regexp(PF_list(i).name, '[pP][rR][oO][bB][eE]');
        exp_name = PF_list(i).name(1:name_idx-2);
        
%         cam_idx = regexp(GF_list(i).name, '[cC][aA][mM]');
%         
%         if ~isempty(cam_idx)
%             name_idx = regexp(PF_list(i).name, '[pP][rR][oO][bB][eE]');
%             exp_name = PF_list(i).name(1:name_idx+4);
%             cam_idx = regexp(GF_list(i).name, '[cC][aA][mM]');
%             name_idx = regexp(GF_list(i).name, '[gG][aA][lL][lL][eE]');
%             exp_name = strcat(exp_name, '-',GF_list(i).name(cam_idx:cam_idx+1),'_',GF_list(i).name(name_idx:name_idx+6));
%         else
%             name_idx = regexp(PF_list(i).name, '[pP][rR][oO][bB][eE]');
%             exp_name = PF_list(i).name(1:name_idx-1);
%         end

%         name_part_cell = strsplit(PF_list(i).name,'_');
%         exp_name = strcat(name_part_cell{1},'-',name_part_cell{2},'-',name_part_cell{3},'-Probe-',name_part_cell{4});
%         name_part_cell = strsplit(GF_list(i).name,'_');
%         exp_name = strcat(exp_name,'-Gallery-',name_part_cell{4},'-');
        %%
        cmc_NEW(pro_ret,pro_lab,gal_ret,gal_lab, i, length(GF_list), exp_name);
        hold on;
    end

    title('CMC Curve');
    legend('show');
else
    disp('The numbers of txt files in selected folder do not match.');
end