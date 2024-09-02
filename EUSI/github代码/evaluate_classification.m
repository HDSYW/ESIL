function [ precision, recall, f1,  gmeans, AUC, PCC] = evaluate_classification(Y, predY)
    % 计算混淆矩阵
   predY(predY == 0) = 1;
    confusionMatrix = confusionmat(Y, predY);
    % 计算真正率（True Positive Rate）和假正率（False Positive Rate）
    TP = confusionMatrix(1, 1);
    FN = confusionMatrix(2, 1);
    FP = confusionMatrix(1, 2);
    TN = confusionMatrix(2, 2);
    % 计算 Precision
    precision = TP / (TP + FP);
    % 计算 Recall
    recall = TP / (TP + FN);

    % 计算 F1 值
    f1 = 2 * (precision * recall) / (precision + recall);
    % 计算 G-means
    sensitivity = recall;  % 在二分类情况下，sensitivity 和 recall 相等
    specificity = TN / (TN + FP);
    gmeans = sqrt(sensitivity * specificity);
    % 将 NaN 值替换为 0（当 TP、FP、FN、TN 中有 0 时会出现）
    precision(isnan(precision)) = 0;
    recall(isnan(recall)) = 0;
    f1(isnan(f1)) = 0;
    gmeans(isnan(gmeans)) = 0;
    specificity(isnan(specificity)) = 0;

  % 计算AUC值
    [~, ~, ~, AUC] = perfcurve(Y, predY, 1);

    % 计算PCC值
    PCC = (TP+TN)/(FN+FP+TP+TN) ;
 

end
