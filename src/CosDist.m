function sco = CosDist(gal_mat, pro_mat)
sco = zeros(size(pro_mat,1),size(gal_mat,1));
for p_idx = 1:size(sco,1)
    for g_idx = 1:size(sco,2)
        sco(p_idx,g_idx) = dot(pro_mat(p_idx,:), gal_mat(g_idx,:));
    end
end